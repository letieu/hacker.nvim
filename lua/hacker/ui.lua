local M = {}

M.open_full_screen_win = function(buf)
  local win_width = vim.api.nvim_get_option("columns")
  local win_height = vim.api.nvim_get_option("lines")

  -- create a new window to display the buffer
  return vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = 0,
    col = 1,
  })
end

M.open_float_win = function(buf)
  return vim.api.nvim_open_win(buf, true, {
    relative = 'win',
    width = 120,
    height = 10,
    border = "single",
    win = 1001,
    row = 20,
    col = 20,
    zindex = 99,
  })
end

M.open_random_float_win = function(buf)
  local win_width = vim.api.nvim_get_option("columns")
  local win_height = vim.api.nvim_get_option("lines")

  local width = math.random(20, 100)
  local height = math.random(5, 20)
  local row = math.random(0, win_height - height)
  local col = math.random(0, win_width - width)

  return vim.api.nvim_open_win(buf, true, {
    relative = 'win',
    width = width,
    height = height,
    border = "single",
    win = 1001,
    row = row,
    col = col,
    zindex = 99,
  })
end

return M
