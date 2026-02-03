-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load core config
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- Setup lazy.nvim with plugin imports
require('lazy').setup({
  -- Import all plugin specs from subdirectories
  { import = 'plugins' },
  { import = 'plugins.editor' },
  { import = 'plugins.ui' },
  { import = 'plugins.lsp' },
  { import = 'plugins.debug' },
  { import = 'plugins.test' },
  { import = 'plugins.lang' },
  { import = 'plugins.tools' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
