local autocmd = vim.api.nvim_create_autocmd
local module = require("hacker.module")
local ui = require("hacker.ui")
local content_sample = require("hacker.sample")

local M = {}

local words = {}
local index = 1


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
