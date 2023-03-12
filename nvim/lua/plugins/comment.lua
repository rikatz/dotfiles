-- Commenting blocks and lines :)
-- For lines on normal mode: gcc, gcb (line, block)
-- For lines on visual mode, just gc or gb
return {
    "numToStr/Comment.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
        require('Comment').setup()
    end,
}