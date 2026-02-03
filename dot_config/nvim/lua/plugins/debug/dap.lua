return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
    'suketa/nvim-dap-ruby',
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
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = '[D]ebug Conditional [B]reakpoint',
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
    {
      '<leader>dr',
      function()
        require('dap').repl.open()
      end,
      desc = '[D]ebug [R]EPL',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = '[D]ebug Run [L]ast',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup()
    require('nvim-dap-virtual-text').setup()

    dap.listeners.after.event_initialized['dapui'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui'] = function()
      dapui.close()
    end

    require('dap-ruby').setup()
  end,
}
