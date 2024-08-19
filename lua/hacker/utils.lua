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

M.get_text_from_buf = function(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  return table.concat(lines, "\n") .. "\n"
end

return M
