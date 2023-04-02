vim.api.nvim_create_user_command("Hack", require("hacker").start, { args = { false } })
vim.api.nvim_create_user_command("HackFollow", require("hacker").start, { args = { true } })
