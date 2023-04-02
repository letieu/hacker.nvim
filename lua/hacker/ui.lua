local M = {}

M.open_win = function(buf)
  local win_width = vim.api.nvim_get_option("columns")
  local win_height = vim.api.nvim_get_option("lines")

  -- create a new window to display the buffer
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = 0,
    col = 1,
  })
end

return M
