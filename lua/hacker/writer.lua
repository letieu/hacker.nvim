local M = {}

-- current index of the words
local index = 1
local total_newline = 1;

local is_type_enter = function()
  local total_lines = vim.api.nvim_buf_line_count(0)

  return total_lines > total_newline
end

local get_insert_position = function(bufnr)
  local is_user_hit_enter = is_type_enter()
  local pos = {}

  local cursor = vim.api.nvim_win_get_cursor(0)

  if is_user_hit_enter then
    local line = vim.api.nvim_buf_get_lines(bufnr, cursor[1] - 2, cursor[1] - 1, false)[1]
    local line_length = line:len()
    pos.s_row = cursor[1] - 2
    pos.s_col = line_length
    pos.e_row = pos.s_row + 1
    pos.e_col = 0

    return pos
  end

  pos.s_row = cursor[1] - 1
  pos.s_col = cursor[2] - 1
  pos.e_row = pos.s_row
  pos.e_col = pos.s_col + 1

  return pos
end

local append_word = function(bufnr, word)
  local pos = get_insert_position(bufnr)

  if word == "\n" then
    total_newline = total_newline + 1
    -- remove the newest char inputve the newest char input
    vim.api.nvim_buf_set_text(bufnr, pos.s_row, pos.s_col, pos.e_row, pos.e_col, { "" })

    vim.api.nvim_buf_set_lines(bufnr, pos.s_row + 1, pos.s_row + 1, false, { "" })
    vim.api.nvim_win_set_cursor(0, { pos.s_row + 2, 0 })

    return
  end

  -- append a new text after the cursor
  vim.api.nvim_buf_set_text(bufnr, pos.s_row, pos.s_col, pos.e_row, pos.e_col, { word })

  -- move the cursor to the end of the inserted text
  vim.api.nvim_win_set_cursor(0, { pos.s_row + 1, pos.s_col + word:len() })
end

M.on_input = function(words)
  local next_word = words[index]
  append_word(0, next_word)

  -- if out of range, reset index to 1
  if index == #words then
    index = 1
  else
    index = index + 1
  end
end

M.reset_index = function()
  index = 1
  total_newline = 1
end

return M
