return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'python' }, -- Added 'python' here
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },

      -- === START: nvim-treesitter-textobjects configuration ===
      -- This 'textobjects' table is where the magic happens for nvim-treesitter-textobjects
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- Python-specific text objects:
            -- See: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/python/textobjects.scm
            ['af'] = '@function.outer', -- Around a function definition
            ['if'] = '@function.inner', -- Inside a function definition
            ['ac'] = '@class.outer', -- Around a class definition
            ['ic'] = '@class.inner', -- Inside a class definition
            ['ap'] = '@parameter.outer', -- Around a parameter (e.g., in a function call/definition)
            ['ip'] = '@parameter.inner', -- Inside a parameter

            -- General text objects that work well with many languages
            ['aa'] = '@parameter.outer', -- around an argument/parameter
            ['ia'] = '@parameter.inner', -- inside an argument/parameter
            ['ad'] = '@conditional.outer', -- around a conditional (if/else)
            ['id'] = '@conditional.inner', -- inside a conditional
            ['al'] = '@loop.outer', -- around a loop (for/while)
            ['il'] = '@loop.inner', -- inside a loop
            -- ['ab'] = '@block.outer', -- around a block of code (e.g., in Python: the indented body of if/for/func)
            -- ['ib'] = '@block.inner', -- inside a block of code
            ['a='] = '@assignment.outer', -- around an assignment
            ['i='] = '@assignment.inner', -- inside an assignment
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>ap'] = '@parameter.inner', -- Swap with next parameter
          },
          swap_previous = {
            ['<leader>aP'] = '@parameter.inner', -- Swap with previous parameter
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer', -- Next function start
            [']]'] = '@class.outer', -- Next class start
            [']i'] = '@conditional.outer', -- Next if/else start
            [']l'] = '@loop.outer', -- Next loop start
          },
          goto_next_end = {
            [']M'] = '@function.outer', -- Next function end
            [']['] = '@class.outer', -- Next class end
            [']I'] = '@conditional.outer', -- Next if/else end
            [']L'] = '@loop.outer', -- Next loop end
          },
          goto_previous_start = {
            ['[m'] = '@function.outer', -- Previous function start
            ['[['] = '@class.outer', -- Previous class start
            ['[i'] = '@conditional.outer', -- Previous if/else start
            ['[l'] = '@loop.outer', -- Previous loop start
          },
          goto_previous_end = {
            ['[M'] = '@function.outer', -- Previous function end
            ['[]'] = '@class.outer', -- Previous class end
            ['[I'] = '@conditional.outer', -- Previous if/else end
            ['[L'] = '@loop.outer', -- Previous loop end
          },
        },
        -- You can also enable 'lsp_interop' for better interaction with LSP,
        -- though this might require 'nvim-lspconfig' setup as well.
        -- lsp_interop = {
        --   enable = true,
        --   peek_definition_if_nil = true,
        -- },
      },
      -- === END: nvim-treesitter-textobjects configuration ===
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

    -- IMPORTANT: Add nvim-treesitter-textobjects as a dependency here
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
