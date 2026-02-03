return {
  {
    -- lazydev for Neovim Lua development
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Mason for installing LSP servers (but NOT for enabling them)
    'mason-org/mason.nvim',
    cmd = 'Mason',
    opts = {},
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = {
        'lua-language-server',
        'ruby-lsp',
        'stylua',
      },
    },
  },
  {
    -- Fidget for LSP progress
    'j-hui/fidget.nvim',
    opts = {},
  },
  {
    -- LSP setup for Neovim 0.11+ (NO mason-lspconfig needed)
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'saghen/blink.cmp',
    },
    keys = {
      { 'grn', vim.lsp.buf.rename, desc = 'LSP: [R]e[n]ame' },
      { 'gra', vim.lsp.buf.code_action, desc = 'LSP: Code [A]ction', mode = { 'n', 'x' } },
      { 'grr', function() Snacks.picker.lsp_references() end, desc = 'LSP: [R]eferences' },
      { 'gri', function() Snacks.picker.lsp_implementations() end, desc = 'LSP: [I]mplementation' },
      { 'grd', function() Snacks.picker.lsp_definitions() end, desc = 'LSP: [D]efinition' },
      { 'grD', vim.lsp.buf.declaration, desc = 'LSP: [D]eclaration' },
      { 'gO', function() Snacks.picker.lsp_symbols() end, desc = 'LSP: Document Symbols' },
      { 'gW', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP: Workspace Symbols' },
      { 'grt', function() Snacks.picker.lsp_type_definitions() end, desc = 'LSP: [T]ype Definition' },
    },
    config = function()
      -- LSP attach autocmd for buffer-specific features
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            vim.keymap.set('n', '<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, { buffer = event.buf, desc = 'LSP: [T]oggle Inlay [H]ints' })
          end
        end,
      })

      -- Diagnostic config
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
        },
      }

      -- LSP capabilities with blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Configure LSPs using Neovim 0.11 API
      vim.lsp.config('ruby_lsp', {
        capabilities = capabilities,
        root_dir = function(bufnr, on_dir)
          local root = vim.fs.root(bufnr, { 'Gemfile', '.git' })
          if root then
            on_dir(root)
          end
        end,
        reuse_client = function(client, cfg)
          return client.name == cfg.name and client.config.root_dir == cfg.root_dir
        end,
      })

      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      })

      -- Enable LSPs one at a time
      if not vim.g._lsp_config_loaded then
        vim.g._lsp_config_loaded = true
        vim.lsp.enable('ruby_lsp')
        vim.lsp.enable('lua_ls')
      end
    end,
  },
}
