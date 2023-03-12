return {
    "ray-x/go.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "ms-jpq/coq_nvim",
        "ray-x/guihua.lua", -- For go plugin floatterms
    },
    opts = {
        trouble = true,
        run_in_floaterm = true,
    },
    config = function(_, opts)
        -- Mason to install gopls and other needs
        require("mason-lspconfig").setup {
            ensure_installed = { 
                "gopls",
            },
        }
        -- Enable Go on nvim lsp
        require'lspconfig'.gopls.setup{}
        require("go").setup(opts)
        
        -- Run gofmt + goimport on save
        local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                require('go.format').goimport()
            end,
            group = format_sync_grp,
        })
    end,
    -- Install all other go tools
    build = ':lua require("go.install").update_all_sync()',
    ft = {"go", 'gomod'},
}