-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
  'akinsho/toggleterm.nvim',
  version = '*', -- Use latest release
  cmd = 'ToggleTerm', -- This makes it lazy-loadable
  opts = {
    size = 20,
    open_mapping = '<leader>tt',
    direction = 'float',
    shade_filetypes = {},
    shading_factor = 1,
    start_in_insert = true,
    insert_mappings = false,
    persist_size = true,
    close_on_exit = true, -- Important for process termination

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

    -- Keymap: Exit terminal mode and toggle the ToggleTerm window
    -- This ensures the python -i process is killed when you press Esc Esc.
    -- 1. <C-\><C-n> exits terminal-insert mode to normal mode.
    -- 2. :ToggleTerm<CR> then executes the ToggleTerm command from normal mode,
    --    which will hide your floating terminal.
    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>:ToggleTerm<CR>', { noremap = true, silent = true, desc = 'Toggle/Exit terminal' })

    -- The <leader>r keymap has been moved back to keymaps.lua to ensure it's defined at startup.
  end,
}
