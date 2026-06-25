import type { Plugin } from "@opencode-ai/plugin"
import type { AssistantMessage, UserMessage, TextPart } from "@opencode-ai/sdk"

const id = (prefix: string) =>
  prefix + "_" + crypto.randomUUID().replace(/-/g, "")

export default (async () => {
  return {
    "experimental.chat.messages.transform": async (_input, output) => {
      try {
        const messages = output.messages
        if (!messages || messages.length === 0) return

        const last = messages[messages.length - 1]
        if (!last || !last.info) return
        if (last.info.role !== "assistant") return

        // Only inject if the trailing assistant message has no real text content.
        // A bare assistant tail (step-cap message, tool-use-only turn) causes
        // Vertex/Bedrock to reject with HTTP 400 "does not support assistant prefill".
        const hasText = last.parts?.some(
          (p: any) => p.type === "text" && typeof p.text === "string" && p.text.trim() !== ""
        )
        if (hasText) return

        const lastAssistant = last.info as AssistantMessage
        const sessionID = lastAssistant.sessionID
        const providerID = lastAssistant.providerID
        const modelID = lastAssistant.modelID

        const msgId = id("msg")
        const prtId = id("prt")

        const userInfo: UserMessage = {
          id: msgId,
          sessionID,
          role: "user",
          time: { created: Date.now() },
          model: { providerID, modelID },
        }

        const textPart: TextPart = {
          id: prtId,
          sessionID,
          messageID: msgId,
          type: "text",
          text: "Continue.",
          synthetic: true,
        }

        messages.push({ info: userInfo, parts: [textPart] })
      } catch {
        // never throw out of a hook
      }
    },
  }
}) satisfies Plugin
