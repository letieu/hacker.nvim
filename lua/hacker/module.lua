-- module represents a lua module for the plugin
local M = {}

local split_str = function(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local get_insert_position = function(bufnr)
  local pos = {}

  local cursor = vim.api.nvim_win_get_cursor(0)

  pos.s_row = cursor[1] - 1
  pos.s_col = cursor[2] - 1
  pos.e_row = pos.s_row
  pos.e_col = pos.s_col + 1

  return pos
end

local split_text_by_newline = function(text)
  local chunks = {}
  if text:sub(1, 1) == "\n" then
    table.insert(chunks, "\n")
  end

  local smaller_chunks = split_str(text, "\n")

  for j, smaller_chunk in ipairs(smaller_chunks) do
    if j ~= 1 then
      table.insert(chunks, "\n")
    end
    table.insert(chunks, smaller_chunk)
  end

  if text:sub(-1, -1) == "\n" then
    table.insert(chunks, "\n")
  end

  return chunks
end

M.split_text_to_chunks = function(content, speed)
  local chunks = {}
  local i = 1
  while i <= content:len() do
    local chunk_length = math.random(speed.min, speed.max)
    local chunk = content:sub(i, i + chunk_length - 1)

    if chunk:find("\n") then
      local split_chunks = split_text_by_newline(chunk)
      for _, split_chunk in ipairs(split_chunks) do
        table.insert(chunks, split_chunk)
      end
    else
      table.insert(chunks, chunk)
    end

    i = i + chunk_length
  end
  return chunks
end

M.append_word = function(bufnr, word)
  local pos = get_insert_position(bufnr)

  if word == "\n" then
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

return M
