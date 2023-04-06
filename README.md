# 📟 hacker.nvim for 10x developer

Hollywood hacker experience in your neovim, like [hacker typer](https://hackertyper.net/)


https://user-images.githubusercontent.com/53562817/229345368-2392e84f-f02e-48d5-91dc-ad4116819320.mp4

## 🪄 Features
- Can custom fake code
- Can fake code follow with *current file* with `:HackFollow` or use default fake code with `:Hack`
- Config speed, show popup or not, time to show popup

## 📦 Installation

Install the plugin with your preferred package manager:

### [packer](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "letieu/hacker.nvim",
}
```

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
require("lazy").setup({
    { 
        "letieu/hacker.nvim"
    }
}
```


## 🪄 Options

Use `setup` to override any of the default options

```lua
-- default config
require("hacker").setup {
  content = [[ Code want to show.... ]], -- The code snippet that show when typing
  filetype = "lua", -- filetype of code snippet
  speed = { -- characters insert each time, random from min -> max
    min = 2,
    max = 10,
  },
  is_popup = false, -- show random float window when typing
  popup_after = 5,
}
```

## 🚀 Usage

`Hack` command can be used to open hacker and start hacking

```
:Hack
```

`HackFollow` command can be used to use current file as fake code
```
:HackFollow
```
