--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap
-- opts: silent = suppress errors, noremap = does not expand mappings
local opts = { noremap = true, silent = true }

-- format: mode, Key, Command, opts
-- Toggle nvim-tree
map('n', 'T', '<Cmd>NvimTreeToggle<CR>', {})

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Floatterm bindings
map('n', '<leader>ft', ':FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 zsh <CR>', {})
map('n', 't', ':FloatermToggle myfloat<CR>', {})
map('t', '<leader><Esc>', '<C-\\><C-n>:q<CR>', {})

-- Lua
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
map("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", opts)

-- Telescope is life
vim.keymap.set('n', 'ff', "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set('n', 'fg', "<cmd>Telescope live_grep<cr>", opts)
vim.keymap.set('n', 'fi', "<cmd>Telescope git_files<cr>", opts)
vim.keymap.set('n', 'fb', "<cmd>Telescope buffers<cr>", opts)
vim.keymap.set('n', 'fh', "<cmd>Telescope search_history<cr>", opts)
vim.keymap.set('n', 'fa', "<cmd>Telescope help_tags<cr>", opts)
vim.keymap.set('n', 'fd', "<cmd>Telescope diagnostics<cr>", opts)
vim.keymap.set('n', 'fr', "<cmd>Telescope lsp_definitions<cr>", opts)
vim.keymap.set('n', 'fm', "<cmd>Telescope lsp_implementations<cr>", opts)

-- Other default keys
-- folding: zc, zo, zR, za, etc (close, open, Open Recursivelly, toggle, )