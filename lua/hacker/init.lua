local autocmd = vim.api.nvim_create_autocmd
local writer = require("hacker.writer")
local ui = require("hacker.ui")
local utils = require("hacker.utils")
local content_sample = require("hacker.sample")

local M = {}

local words = {}



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
  words = utils.split_text_to_chunks(M.config.content, M.config.speed)
  writer.reset_index()

  local buf = vim.api.nvim_create_buf(false, true)
  ui.open_win(buf)

  vim.api.nvim_buf_set_option(buf, "filetype", M.config.filetype)

  autocmd({ "TextChangedI" }, {
    buffer = buf,
    callback = function(_)
      writer.on_input(words)
    end,
  })
end

return M
