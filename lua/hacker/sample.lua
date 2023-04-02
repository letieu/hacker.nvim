local sample_text = [[
M.split_text_to_words = function(content)
  local words = {}
  local i = 1

  while i <= content:len() do
    local chunk_length = math.random(2, 5)
    local word = content:sub(i, i + chunk_length - 1)
    if word:find("\n") then
      local split_words = {}
      local split_word = ""
      for i = 1, word:len() do
        if word:sub(i, i) == "\n" then
          if split_word ~= "" then
            table.insert(split_words, split_word)
          end
          table.insert(split_words, "\n")
          split_word = ""
        else
          split_word = split_word .. word:sub(i, i)
        end
      end
      if split_word ~= "" then
        table.insert(split_words, split_word)
      end
      for _, split_word in ipairs(split_words) do
        table.insert(words, split_word)
      end
    else
      table.insert(words, word)
    end
    i = i + chunk_length
  end
  return words
end
]]

return sample_text
