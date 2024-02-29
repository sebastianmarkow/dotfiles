return {
   "mfussenegger/nvim-dap",
    event = "BufRead",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "leoluz/nvim-dap-go",
        "folke/neodev.nvim",
    },
    config = function()
        local dap_ui = require("dapui")
        dap_ui.setup()

        local dap_vt = require("nvim-dap-virtual-text")
        dap_vt.setup({})

        local dap_go = require("dap-go")
        dap_go.setup()
    end
}
