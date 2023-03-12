-- Mason LSP Config is a requirement from mason and bridges mason and nvim-lspconfig
return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim"
    },
    config = function()
        require("mason-lspconfig").setup()
    end,
}