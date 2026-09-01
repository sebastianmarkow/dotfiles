-- Claude Code quota menubar
--
-- Shows Claude Code usage quota in the menubar (small icon + 5-hour
-- utilization %), with a dropdown breaking down the 5-hour, weekly and
-- per-model windows plus any extra-usage credits.
--
-- It polls the same endpoint Claude Code's `/usage` screen uses
-- (https://api.anthropic.com/api/oauth/usage) with the OAuth token read
-- read-only from the macOS Keychain (falling back to ~/.claude/.credentials.json).
-- That endpoint is internal/undocumented, so if Anthropic changes it the field
-- names in `getMenu`/`updateMenubar` may need a small tweak.
local Claude = {
  menubar = hs.menubar.new(),
  data = nil,
  status = 'loading', -- 'loading' | 'ok' | 'noauth' | 'error'
  intervalSeconds = 300, -- poll every 5 min (matches reference "5m")
  url = 'https://api.anthropic.com/api/oauth/usage',
  betaHeader = 'oauth-2025-04-20',
  keychainService = 'Claude Code-credentials',
}

-- Color thresholds: red >= 90%, orange >= 70%, else default label color.
local function colorFor(u)
  u = u or 0
  if u >= 90 then
    return { red = 0.9, green = 0.2, blue = 0.2, alpha = 1 }
  elseif u >= 70 then
    return { red = 0.95, green = 0.6, blue = 0.1, alpha = 1 }
  end
  return { list = 'System', name = 'labelColor' }
end

local function pct(u)
  return string.format('%.0f%%', u or 0)
end

-- Parse an ISO8601 timestamp (UTC, e.g. "2026-06-10T15:00:00Z") to epoch seconds.
local function parseISO(iso)
  if not iso then return nil end
  local y, mo, d, h, mi, s = iso:match('(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)')
  if not y then return nil end
  local t = os.time({
    year = tonumber(y),
    month = tonumber(mo),
    day = tonumber(d),
    hour = tonumber(h),
    min = tonumber(mi),
    sec = tonumber(s),
  })
  -- os.time treats the table as local time; correct to UTC since `iso` is UTC.
  local utcOffset = os.difftime(os.time(), os.time(os.date('!*t')))
  return t + utcOffset
end

-- Human-readable countdown until reset, e.g. "resets in 3h 12m".
local function resetStr(iso)
  local target = parseISO(iso)
  if not target then return '--' end
  local remaining = target - os.time()
  if remaining <= 0 then return 'resets now' end
  local hours = math.floor(remaining / 3600)
  local mins = math.floor((remaining % 3600) / 60)
  if hours > 0 then
    return string.format('resets in %dh %dm', hours, mins)
  end
  return string.format('resets in %dm', mins)
end

-- Build a monochrome template icon (a small asterisk/sunburst) at runtime so we
-- do not need to commit a binary asset, and it adapts to light/dark menubars.
local function makeIcon()
  local size = 16
  local canvas = hs.canvas.new({ x = 0, y = 0, w = size, h = size })
  local cx, cy, r = size / 2, size / 2, size / 2 - 1
  for i = 0, 7 do
    local angle = (i / 8) * 2 * math.pi
    canvas[i + 1] = {
      type = 'segments',
      coordinates = {
        { x = cx, y = cy },
        { x = cx + r * math.cos(angle), y = cy + r * math.sin(angle) },
      },
      action = 'stroke',
      strokeColor = { white = 0, alpha = 1 },
      strokeWidth = 1.6,
      strokeCapStyle = 'round',
    }
  end
  local icon = canvas:imageFromCanvas():template(true)
  canvas:delete()
  return icon
end

function Claude:readToken()
  -- Keychain (read-only): returns a JSON blob {"claudeAiOauth":{"accessToken":...}}
  local cmd = string.format('security find-generic-password -s "%s" -w 2>/dev/null', self.keychainService)
  local pipe = io.popen(cmd, 'r')
  if pipe then
    local out = pipe:read('*a')
    pipe:close()
    if out and out ~= '' then
      local ok, decoded = pcall(hs.json.decode, out)
      if ok and decoded and decoded.claudeAiOauth and decoded.claudeAiOauth.accessToken then
        return decoded.claudeAiOauth.accessToken
      end
    end
  end

  -- Fallback: ~/.claude/.credentials.json
  local path = os.getenv('HOME') .. '/.claude/.credentials.json'
  local file = io.open(path, 'r')
  if file then
    local contents = file:read('*a')
    file:close()
    local ok, decoded = pcall(hs.json.decode, contents)
    if ok and decoded and decoded.claudeAiOauth and decoded.claudeAiOauth.accessToken then
      return decoded.claudeAiOauth.accessToken
    end
  end

  return nil
end

function Claude:refresh()
  local token = self:readToken()
  if not token then
    self.status = 'noauth'
    self.data = nil
    self:updateMenubar()
    return
  end

  local headers = {
    ['Authorization'] = 'Bearer ' .. token,
    ['anthropic-beta'] = self.betaHeader,
    ['Content-Type'] = 'application/json',
  }

  hs.http.asyncGet(self.url, headers, function(code, body)
    if code == 200 and body then
      local ok, decoded = pcall(hs.json.decode, body)
      if ok and decoded then
        self.status = 'ok'
        self.data = decoded
        self:updateMenubar()
        return
      end
    end
    self.status = 'error'
    self.errorCode = code
    self:updateMenubar()
  end)
end

function Claude:updateMenubar()
  self.menubar:returnToMenuBar()
  self.menubar:setIcon(makeIcon())

  if self.status == 'ok' and self.data and self.data.five_hour then
    local u = self.data.five_hour.utilization
    self.menubar:setTitle(hs.styledtext.new(' ' .. pct(u), {
      color = colorFor(u),
      font = { name = 'Menlo', size = 12 },
    }))
    self.menubar:setTooltip(string.format('Claude Code: %s of 5-hour limit used', pct(u)))
  elseif self.status == 'noauth' then
    self.menubar:setTitle(' ?')
    self.menubar:setTooltip('Claude Code: not signed in')
  elseif self.status == 'error' then
    self.menubar:setTitle(' !')
    self.menubar:setTooltip(string.format('Claude Code: failed to load usage (HTTP %s)', tostring(self.errorCode)))
  else
    self.menubar:setTitle(' …')
    self.menubar:setTooltip('Claude Code: loading usage…')
  end
end

function Claude:getMenu()
  local menu = {}

  if self.status == 'noauth' then
    table.insert(menu, { title = 'Not signed in to Claude Code', disabled = true })
  elseif self.status == 'error' then
    table.insert(menu, {
      title = string.format('Failed to load usage (HTTP %s)', tostring(self.errorCode)),
      disabled = true,
    })
  elseif self.status == 'ok' and self.data then
    local function windowRow(label, window)
      if not window then return end
      table.insert(menu, {
        title = string.format('%-14s %4s   %s', label, pct(window.utilization), resetStr(window.resets_at)),
        disabled = true,
      })
    end

    windowRow('5-hour', self.data.five_hour)
    windowRow('Weekly', self.data.seven_day)
    windowRow('Weekly (Opus)', self.data.seven_day_opus)
    windowRow('Weekly (Sonnet)', self.data.seven_day_sonnet)

    local extra = self.data.extra_usage
    if extra and extra.is_enabled then
      table.insert(menu, { title = '-' })
      table.insert(menu, {
        title = string.format(
          'Extra usage: %.2f / %.2f %s',
          extra.used_credits or 0,
          extra.monthly_limit or 0,
          extra.currency or ''
        ),
        disabled = true,
      })
    end
  else
    table.insert(menu, { title = 'Loading…', disabled = true })
  end

  table.insert(menu, { title = '-' })
  table.insert(menu, {
    title = 'Refresh now',
    fn = function()
      Claude:refresh()
    end,
  })

  return menu
end

if Claude.menubar then
  Claude.menubar:setMenu(function()
    return Claude:getMenu()
  end)
  Claude:updateMenubar()
  Claude:refresh()
  hs.timer.doEvery(Claude.intervalSeconds, function()
    Claude:refresh()
  end)
end
