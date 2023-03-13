-- This plugin adds a scrollbar on a buffer in NVIM like vscode, with
-- colors for diagnostics, git, etc
return {
    "petertriho/nvim-scrollbar",
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "Mofiqul/dracula.nvim",
    },
    event = "BufReadPost",
    config = function()
      local scrollbar = require("scrollbar")
      local colors = require('dracula').colors()
      scrollbar.setup({
        handle = { color = colors.bg_highlight },
        excluded_buftypes = {
            "terminal",
        },
        excluded_filetypes = {
            "prompt",
            "TelescopePrompt",
            "noice",
        },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
      })
      require("scrollbar.handlers.gitsigns").setup()
    end,
}