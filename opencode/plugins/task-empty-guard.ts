import type { Plugin } from "@opencode-ai/plugin"

export default (async () => {
  return {
    "tool.execute.after": async (input, output) => {
      try {
        if (input.tool !== "task") return
        const text = output.output
        if (text != null && text.trim() !== "") return
        const subagent = input.args?.subagent_type ?? "unknown"
        output.output = `[task-empty-guard] Subagent '${subagent}' returned no final text output. It most likely ended its turn on a tool call, hit its step limit, or the provider returned an empty trailing message. Re-run the delegation and explicitly instruct the subagent to END with a complete plain-text report and to never yield on a tool call.`
      } catch {
        // never throw out of a hook
      }
    },
  }
}) satisfies Plugin
