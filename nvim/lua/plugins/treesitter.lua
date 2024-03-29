-- treesitter is the responsible for syntaxes, making folding work, etc
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate", -- Runs with new plugins
        -- Most configs were copied from lazyVim (https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua)
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                init = function()
                -- PERF: no need to load the plugin, if we only need its queries for mini.ai
                local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
                local opts = require("lazy.core.plugin").values(plugin, "opts", false)
                local enabled = false
                if opts.textobjects then
                    for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
                        if opts.textobjects[mod] and opts.textobjects[mod].enable then
                            enabled = true
                            break
                        end
                    end
                end
                if not enabled then
                    require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
                end
            end,
            },
        },
        opts = {
            highlight = { enable = true },
            indent  = { enable = true, disable = { "python" } },
            context_commentstring = { enable = true, enable_autocmd = false },
            incremental_selection = { enable = true },
            -- Languages: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
            ensure_installed = {
                "bash",
                "help",
                "html",
                "go",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "rust",
                "toml",
                "vim",
                "yaml",
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
