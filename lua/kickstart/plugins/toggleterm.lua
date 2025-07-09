-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
  'akinsho/toggleterm.nvim',
  version = '*', -- Use latest release
  cmd = 'ToggleTerm', -- This makes it lazy-loadable
  opts = {
    size = 20, -- Default height for horizontal/vertical splits
    open_mapping = '<leader>tt', -- Key to toggle the default terminal
    direction = 'float', -- Make the default terminal float by default
    shade_filetypes = {}, -- Disable shading for terminal buffers
    shading_factor = 1, -- No shading
    start_in_insert = true, -- Start in insert mode automatically
    insert_mappings = true, -- Enable insert mode mappings (like <esc><esc> to exit)
    persist_size = true,
    close_on_exit = true, -- <--- ADD THIS LINE to automatically close when the shell exits
    -- For the Esc Esc mapping to directly hide/close the window, you handle it in the config callback
    -- as a direct toggle action.

    -- highlights = {
    --   FloatBorder = { bg = 'none' },
    --   FloatBg = { bg = 'none' },
    -- },
    -- Terminal specific options (if you need persistent, named terminals)
    terminals = {
      {
        name = 'python_runner',
        cmd = { 'python3' },
        hidden = true,
        direction = 'float',
      },
    },
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    -- Corrected: Define keymap to exit terminal mode easily using vim.keymap.set
    -- This mapping will now directly toggle/hide the terminal.
    -- This overrides toggleterm's default insert_mappings for <Esc><Esc>
    vim.keymap.set('t', '<Esc><Esc>', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true, desc = 'Toggle/Exit terminal' })

    -- If you had an Autocmd here, ensure its callback signature is correct.
    -- Example:
    -- vim.api.nvim_create_autocmd('TermOpen', {
    --   callback = function(args)
    --     -- args will contain { buf, file, data, id }
    --   end,
    -- })
  end,
}
