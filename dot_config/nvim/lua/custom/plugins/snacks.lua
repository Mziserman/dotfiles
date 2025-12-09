return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,

  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = { enabled = true },
  },

  keys = {
    -- === Telescope -> Snacks equivalents ===

    -- [S]earch [H]elp
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[S]earch [H]elp',
    },

    -- [S]earch [K]eymaps
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },

    -- [S]earch [F]iles
    {
      '<leader>sf',
      function()
        Snacks.picker.files()
      end,
      desc = '[S]earch [F]iles',
    },

    -- [S]earch [S]elect (list of all pickers)
    {
      '<leader>ss',
      function()
        Snacks.picker()
      end,
      desc = '[S]earch [S]elect Snacks picker',
    },

    -- [S]earch current [W]ord
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = '[S]earch current [W]ord',
      mode = { 'n', 'x' },
    },

    -- [S]earch by [G]rep
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[S]earch by [G]rep',
    },

    -- [S]earch [D]iagnostics
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[S]earch [D]iagnostics',
    },

    -- [S]earch [R]esume
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = '[S]earch [R]esume',
    },

    -- [S]earch Recent Files (Telescope oldfiles)
    {
      '<leader>s.',
      function()
        Snacks.picker.recent()
      end,
      desc = '[S]earch Recent Files',
    },

    -- Find existing buffers
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Find existing buffers',
    },

    -- Fuzzy search in current buffer (Telescope current_buffer_fuzzy_find)
    {
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Search in current buffer',
    },

    -- [S]earch [/] in Open Files (Telescope live_grep + grep_open_files)
    {
      '<leader>s/',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = '[S]earch [/] in Open Files',
    },

    -- [S]earch [N]eovim config
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[S]earch [N]eovim config files',
    },

    -- [T]erminal [T]oggle (float)
    {
      '<leader>tt',
      function()
        require('snacks').terminal()
      end,
      desc = '[T]erminal [T]oggle (float)',
    },

    {
      '<leader>e',
      function()
        require('snacks').explorer()
      end,
      desc = 'File Explorer',
    },
  },
}
