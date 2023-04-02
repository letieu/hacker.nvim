local autocmd = vim.api.nvim_create_autocmd
local module = require("hacker.module")
local ui = require("hacker.ui")

local M = {}

local words = {}
local index = 1

local content_sample = [[
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

local on_input = function()
  local next_word = words[index]
  module.append_word(0, next_word)

  -- if out of range, reset index to 1
  if index == #words then
    index = 1
  else
    index = index + 1
  end
end

M.config = {
  content = content_sample,
  filetype = "lua",
  speed = {
    min = 2,
    max = 5,
  },
}

M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.start = function()
  words = module.split_text_to_chunks(M.config.content, M.config.speed)

  local buf = vim.api.nvim_create_buf(false, true)
  ui.open_win(buf)

  vim.api.nvim_buf_set_option(buf, "filetype", M.config.filetype)

  autocmd({ "TextChangedI" }, {
    buffer = buf,
    callback = function(_)
      on_input()
    end,
  })
end

return M
