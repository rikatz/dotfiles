return {
    {
        -- lsp config is the integration between neovim and the LSP servers
        "neovim/nvim-lspconfig",
    },
    -- Mason is a package manager for LSP
    -- It does the role of installing dependencies, like rust-analyzer, gopls, etc if 
    -- not found.
    -- Once you add new dependencies to it (see rust.lua, go.lua) you should run 
    -- :Mason to update it if you cannot see the stuff being installed
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim"
        },
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup()
        end,
    },
}
