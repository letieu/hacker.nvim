-- module represents a lua module for the plugin
local M = {}

local get_insert_position = function(bufnr)
  local pos = {}

  local cursor = vim.api.nvim_win_get_cursor(0)

  -- if cursor is at the beginning of the line, mean user hit enter
  -- need to disable enter key, so just append the text to the end of the line
  if cursor[2] == 0 and cursor[1] > 1 then
    local prev_line = vim.api.nvim_buf_get_lines(bufnr, cursor[1] - 2, cursor[1] - 1, false)[1]

    pos.s_row = cursor[1] - 2
    pos.s_col = prev_line:len()
    pos.e_row = pos.s_row + 1
    pos.e_col = 0
  else
    pos.s_row = cursor[1] - 1
    pos.s_col = cursor[2] - 1
    pos.e_row = pos.s_row
    pos.e_col = pos.s_col + 1
  end

  return pos
end

-- TODO: Improve this function
M.split_text_to_words = function(content)
  local words = {}
  for word in content:gmatch("%S+") do
    table.insert(words, word)
  end
  return words
end

M.append_word = function(bufnr, word)
  -- TODO: if word is newline, just append a newline
  local pos = get_insert_position(bufnr)

  -- append a new text after the cursor
  vim.api.nvim_buf_set_text(bufnr, pos.s_row, pos.s_col, pos.e_row, pos.e_col, { word })

  -- move the cursor to the end of the inserted text
  vim.api.nvim_win_set_cursor(0, { pos.s_row + 1, pos.s_col + word:len() })
end

return M
