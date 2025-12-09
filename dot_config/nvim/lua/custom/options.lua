local opt = vim.opt
local api = vim.api

opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldenable = true
opt.foldlevel = 99

api.nvim_set_keymap('x', '>', '>gv', { noremap = true })
api.nvim_set_keymap('x', '<', '<gv', { noremap = true })
