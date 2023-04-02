# 🗺️ hacker.nvim

Hollywood hacker experience in your neovim


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
{
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
