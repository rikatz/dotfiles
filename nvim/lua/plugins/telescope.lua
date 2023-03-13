-- telescope to fuzzy find everything!
return {
        "nvim-telescope/telescope.nvim",
        dependencies = { 
            {
              "nvim-lua/plenary.nvim",
            },
            {
              -- Better way of doing, stollen from https://github.com/folke/dot/blob/master/nvim/lua/plugins/telescope.lua
              -- Should be careful with fzf native as it needs build tools that may not be available
              "nvim-telescope/telescope-fzf-native.nvim",
              build = "make",
                config = function()
                  require("telescope").load_extension("fzf")
                end,
            },
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                                   -- the default case_mode is "smart_case"
          }
        }
}
