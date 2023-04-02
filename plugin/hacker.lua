vim.api.nvim_create_user_command("Hack", 
  function()
    require("hacker").start(false)
  end
, {})

vim.api.nvim_create_user_command("HackFollow", 
  function()
    require("hacker").start(true)
  end
  , {})
