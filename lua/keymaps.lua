-- ~/.config/nvim/lua/keymaps.lua

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- If you uncomment these, ensure they end with '})'
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Oil.nvim Floating Window Keymaps ]]
-- These keymaps open Oil.nvim in a floating window.
-- They are placed here because they are general Neovim commands, not specific to actions *within* an Oil buffer.
vim.keymap.set('n', '<leader>of', function()
  require('oil').open_float('.')
end, { desc = 'Oil: Open float in CWD' })

vim.keymap.set('n', '<leader>oF', function()
  require('oil').open_float(vim.fn.expand '%:p:h')
end, { desc = "Oil: Open float in current file's directory" })

-- [[ Recommended Python Run Keymap (Floating Term via ToggleTerm) ]]
-- This keymap uses `toggleterm.nvim` to run the current Python file in a floating terminal window.
-- It saves the current file, constructs the command to run it from its directory,
-- and then creates/toggles a floating terminal to execute this command.
vim.keymap.set('n', '<leader>r', function()
  -- Check if the current file is a Python file
  if vim.bo.filetype == 'python' then
    vim.cmd 'w' -- Save the current file

    -- Get the full path and directory of the current file, shell-escaped
    local file_path = vim.fn.shellescape(vim.fn.expand '%:p')
    local file_dir = vim.fn.shellescape(vim.fn.expand '%:h')
    local file_name = vim.fn.shellescape(vim.fn.expand '%:t')

    -- Construct the command to run: change directory, then execute python3 with -i
    -- The '-i' flag keeps the Python interpreter interactive after the script finishes.
    local run_command = 'cd ' .. file_dir .. ' && python3 -i ' .. file_name

    -- Use ToggleTerm to open/toggle a floating terminal and execute the command.
    require('toggleterm.terminal').Terminal
      :new({
        cmd = run_command,
        direction = 'float',
        -- You can keep or remove 'hidden = true'. If removed, the terminal will always
        -- appear even if it was previously open and hidden.
        -- hidden = true,
        float_opts = {
          border = 'rounded',
          width = math.floor(vim.o.columns * 0.8), -- 80% of screen width
          height = math.floor(vim.o.lines * 0.6), -- 60% of screen height
          row = math.floor((vim.o.lines - math.floor(vim.o.lines * 0.6)) / 2),
          col = math.floor((vim.o.columns - math.floor(vim.o.columns * 0.8)) / 2),
        },
      })
      :toggle() -- The :toggle() method creates and shows the terminal, or hides it if already visible
  else
    vim.notify('Not a Python file (filetype is ' .. vim.bo.filetype .. ').', vim.log.levels.WARN, { title = 'Run Script' })
  end
end, { desc = 'Run [P]ython File (Floating)' })

-- vim: ts=2 sts=2 sw=2 et
