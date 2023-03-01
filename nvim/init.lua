--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
-- mapleader is the general leader key
vim.g.mapleader = ","
-- localleader is the leader key for specific files, if defined
vim.g.localleader = "\\"

-- below is from https://github.com/nvim-tree/nvim-tree.lua#setup
-- Disable netrw because we use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



require('keys')      -- Keymaps
require('opts')      -- Keymaps

-- I use lazy.nvim as a plugin manager because it can do some 
-- better autoload and autoinstall.
-- It needs nvim with luajit so be aware of it.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Themes should load after possibly installed
vim.cmd[[colorscheme dracula]]

-- Treesitter folding. Adding after init otherwise it will close all the foldings
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99 -- Start with all folds open!
