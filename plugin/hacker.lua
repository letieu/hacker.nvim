vim.api.nvim_create_user_command("Hack", require("hacker").start(false))
vim.api.nvim_create_user_command("HackFollow", require("hacker").start(true))
