-- Lualine is the status bar on bottom
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "Mofiqul/dracula.nvim",
        "f-person/git-blame.nvim", -- Get blame on status
        "folke/tokyonight.nvim"
    },
    opts = function()
        local git_blame = require('gitblame')
        return {
            options = {
                theme = "dracula-nvim",
            },
            sections = {
                lualine_c = {
                    {
                        git_blame.get_current_blame_text, cond=git_blame.is_blame_text_available,
                    },
                },
            },
        }
    end,
    config = function(_, opts) 
        require("lualine").setup(opts)
    end, 
}
