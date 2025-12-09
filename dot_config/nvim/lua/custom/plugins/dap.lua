return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'suketa/nvim-dap-ruby',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
    },

    keys = {
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = '[D]ebug Toggle [B]reakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = '[D]ebug [C]ontinue',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = '[D]ebug Step [I]nto',
      },
      {
        '<leader>do',
        function()
          require('dap').step_over()
        end,
        desc = '[D]ebug Step [O]ver',
      },
      {
        '<leader>dO',
        function()
          require('dap').step_out()
        end,
        desc = '[D]ebug Step [O]ut',
      },
      {
        '<leader>dq',
        function()
          require('dap').terminate()
        end,
        desc = '[D]ebug [Q]uit',
      },
      {
        '<leader>du',
        function()
          require('dapui').toggle()
        end,
        desc = '[D]ebug Toggle [U]I',
      },
    },

    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Register Ruby adapter + configs (debug gem)
      -- This follows nvim-dap-ruby README.
      require('dap-ruby').setup()

      -- UI + inline values
      dapui.setup()
      require('nvim-dap-virtual-text').setup()

      -- Auto-open/close UI
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
}
