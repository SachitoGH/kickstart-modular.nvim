return {
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        opts = {},
      },

      'folke/lazydev.nvim',

      -- Dadbod completion
      { 'kristijanhusak/vim-dadbod-completion' },
    },

    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },

      appearance = { nerd_font_variant = 'mono' },

      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        -- Default sources
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'dadbod' },

        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          dadbod = {
            name = 'Dadbod',
            module = 'vim_dadbod_completion.blink', -- required for blink
            score_offset = 75,
            filetypes = { 'sql', 'mysql', 'plsql' }, -- optional restriction
          },
        },
      },

      snippets = { preset = 'luasnip' },

      fuzzy = { implementation = 'lua' },

      signature = { enabled = true },
    },
  },
}
