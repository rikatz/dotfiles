return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        view = {
            float = {
                enable = true,
            },
        },
        diagnostics = {
            enable = true,
            severity = {
                min = vim.diagnostic.severity.WARN,
            },
        },
        modified = {
            enable = true,
        },
    },
    config = function(_, opts) 
        require("nvim-tree").setup(opts)
    end,
} 
