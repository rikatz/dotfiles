-- Simple plugin to show git blame
return {
    "f-person/git-blame.nvim",
    name = "gitblame",
    config = function()
        -- Disable the virtual text on editor so we can just see on lualine
        vim.g.gitblame_display_virtual_text = 0
    end,
}
