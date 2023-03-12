-- Shows some help on key binding (will disable in future)
return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup({
        })
    end,
}
