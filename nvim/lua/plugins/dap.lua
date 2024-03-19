return {
    {
        "mfussenegger/nvim-dap",
        event = "BufRead",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
            "mfussenegger/nvim-dap-python",
            "folke/neodev.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            local dap_ui = require("dapui")
            dap_ui.setup()

            local dap_vt = require("nvim-dap-virtual-text")
            dap_vt.setup({})

            local dap_go = require("dap-go")
            dap_go.setup()

            local dap_python = require("dap-python")
            dap_python.setup()
        end,
    },
}
