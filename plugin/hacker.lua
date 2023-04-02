vim.api.nvim_create_user_command("Hack", require("hacker").start, {})

-- call start(true)
vim.api.nvim_create_user_command("HackFollow", function() require("hacker").start(true) end, {})

