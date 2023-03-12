-- Mason is a package manager for LSP
-- It does the role of installing dependencies, like rust-analyzer, gopls, etc if 
-- not found
return {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end,
}