local autocmd = vim.api.nvim_create_autocmd
local writer = require("hacker.writer")
local ui = require("hacker.ui")
local utils = require("hacker.utils")
local content_sample = require("hacker.sample")

local M = {}

M.config = {
  content = content_sample,
  filetype = "lua",
  speed = {
    min = 2,
    max = 10,
  },
  popup_after = 5,
  is_popup = false,
}

M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.start = function(is_follow, is_auto)
  local content = M.config.content
  local filetype = M.config.filetype

  if is_follow == true then
    content = utils.get_text_from_buf(0)
    if content == nil or content == "" then
      print("No text in current buffer to follow, try :Hacker instead")
      return
    end

    filetype = vim.api.nvim_buf_get_option(0, "filetype")
  end
  local input_count = 0
  local words = utils.split_text_to_chunks(content, M.config.speed)
  local seconds_win

  writer.reset_index()

  local buf = vim.api.nvim_create_buf(false, true)

  ui.open_full_screen_win(buf)

  vim.api.nvim_buf_set_option(buf, "filetype", filetype)

  autocmd({ "TextChangedI" }, {
    buffer = buf,
    callback = function(_)
      input_count = input_count + 1
      writer.on_input(words)

      if M.config.is_popup == false then
        return
      end

      if input_count == M.config.popup_after then
        seconds_win = ui.open_random_float_win(0)
      end

      if input_count == M.config.popup_after + 10 then
        vim.api.nvim_win_close(seconds_win, true)
        input_count = 0
      end
    end,
  })
  if is_auto == true then
    local timer = vim.loop.new_timer()
    local callback_duration = 100
    vim.api.nvim_input("i")
    timer:start(
      callback_duration,
      callback_duration,
      vim.schedule_wrap(function()
        local mode_info = vim.api.nvim_get_mode()
        if mode_info.mode ~= "i" then
          timer:stop()
          return
        end
        vim.api.nvim_input(" ")
      end)
    )
  end
end

return M
