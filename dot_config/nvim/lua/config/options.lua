-- Options configuration
local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.cursorline = true
opt.showmode = false
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Indentation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.breakindent = true

-- Folding (treesitter-based)
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldenable = true
opt.foldlevel = 99

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'split'

-- Behavior
opt.mouse = 'a'
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 10
opt.confirm = true

-- Clipboard (deferred for startup perf)
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)
