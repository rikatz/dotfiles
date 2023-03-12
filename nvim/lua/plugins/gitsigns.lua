-- gitsigns marks the lines changed if files are on a git repo
return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()
    end,
}