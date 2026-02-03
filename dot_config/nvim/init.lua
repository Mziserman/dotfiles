-- Set leader keys before anything else
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nerd font detection
vim.g.have_nerd_font = true

-- Load configuration
require 'config.lazy'
