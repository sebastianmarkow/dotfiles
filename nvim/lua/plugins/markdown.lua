return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
    },
    ft = { 'markdown' },
    opts = {
      render_modes = { 'n', 'c', 't' },
      anti_conceal = { enabled = true },
      heading = {
        enabled = true,
        sign = false,
        icons = { '󰉫 ', '󰉬 ', '󰉭 ', '󰉮 ', '󰉯 ', '󰉰 ' },
        width = 'full',
        left_pad = 0,
        right_pad = 0,
      },
      code = {
        enabled = true,
        sign = false,
        style = 'full',
        border = 'thin',
        left_pad = 1,
        right_pad = 1,
        width = 'full',
        language_pad = 1,
      },
      dash = {
        enabled = true,
        icon = '─',
        width = 'full',
      },
      bullet = {
        enabled = true,
        icons = { '●', '○', '◆', '◇' },
        left_pad = 0,
        right_pad = 1,
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = '󰄱 ' },
        checked = { icon = '󰱒 ' },
        custom = {
          todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
        },
      },
      quote = {
        enabled = true,
        icon = '▋',
        repeat_linebreak = true,
      },
      pipe_table = {
        enabled = true,
        preset = 'round',
        style = 'full',
        cell = 'padded',
      },
      link = {
        enabled = true,
        footnote = { superscript = true },
        image = '󰥶 ',
        email = '󰀓 ',
        hyperlink = '󰌹 ',
        wiki = { icon = '󱗖 ' },
      },
    },
  },
}
