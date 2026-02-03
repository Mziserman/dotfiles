return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'olimorris/neotest-rspec',
  },

  keys = {
    {
      '<leader>tn',
      function()
        require('neotest').run.run()
      end,
      desc = '[T]est [N]earest',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = '[T]est [F]ile',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = '[T]est [S]ummary',
    },
    {
      '<leader>to',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = '[T]est [O]utput panel',
    },
    {
      '<leader>tp',
      function()
        require('neotest').output.open { enter = true }
      end,
      desc = '[T]est [P]opup output',
    },
    {
      '<leader>tx',
      function()
        require('neotest').run.stop()
      end,
      desc = '[T]est stop e[X]ecution',
    },
    {
      '<leader>td',
      function()
        require('neotest').run.run {
          strategy = 'dap',
        }
      end,
      desc = '[T]est [D]ebug nearest',
    },
    {
      '<leader>tD',
      function()
        require('neotest').run.run {
          path = vim.fn.expand '%',
          strategy = 'dap',
        }
      end,
      desc = '[T]est [D]ebug file',
    },
  },

  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-rspec',
      },
    }
  end,
}
