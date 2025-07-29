return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
  opts = {
    enhanced_diff_hl = true, -- highlight changed words within lines
  },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = 'Open Diffview' },
    { '<leader>gD', '<cmd>DiffviewClose<CR>', desc = 'Close Diffview' },
  },
}
