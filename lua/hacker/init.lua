local autocmd = vim.api.nvim_create_autocmd
local module = require("hacker.module")

local M = {}

local content_sample = [[
  function! s:hello()
    echo 'Hello!'
  endfunction

  command! -nargs=0 Hack call s:hello()

  console.log('ok')
--
]]

M.config = {
  content = content_sample,
  filetype = "lua",
}
M.words = {}
M.index = 1

M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.on_input = function()
  local next_word = M.words[M.index]
  module.append_word(0, next_word)
  -- if out of range, reset index to 1
  if M.index == #M.words then
    M.index = 1
  else
    M.index = M.index + 1
  end
end

-- when start, open new buffer, add autocmd to it
M.start = function()
  M.words = module.split_text_to_words(M.config.content)

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
    command = "lua require('hacker').on_input()",
    buffer = buf,
  })
end

return M
