-- module represents a lua module for the plugin
local M = {}

-- TODO: Improve this function
M.split_text_to_words = function(content)
  local words = {}
  for word in content:gmatch("%S+") do
    table.insert(words, word)
  end
  return words
end

-- TODO: Fix the case Enter
M.append_word = function(bufnr, word)
  -- get current cursor position
  local cursor = vim.api.nvim_win_get_cursor(0)

  local start_row = cursor[1] - 1
  local start_col = cursor[2] - 1

  -- append a new text after the cursor
  vim.api.nvim_buf_set_text(bufnr, start_row, start_col, start_row, start_col + 1, { word })

  -- move the cursor to the end of the inserted text
  vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + word:len() })
end

return M
