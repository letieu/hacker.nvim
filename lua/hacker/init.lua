local autocmd = vim.api.nvim_create_autocmd
local module = require("hacker.module")

local M = {}

local words = {}
local index = 1

local content_sample = [[
  function! s:hello()
    echo 'Hello!'
  endfunction

  command! -nargs=0 Hack call s:hello()

  console.log('ok')
--
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
}

M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.start = function()
  words = module.split_text_to_words(M.config.content)

  local buf = vim.api.nvim_create_buf(false, true)

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

  -- set the filetype
  vim.api.nvim_buf_set_option(buf, "filetype", M.config.filetype)

  autocmd({ "TextChangedI" }, {
    buffer = buf,
    callback = function(_)
      on_input()
    end,
  })
end

return M
