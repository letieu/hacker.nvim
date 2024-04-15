# 📟 hacker.nvim for 10x developer
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

Hollywood hacker experience in your neovim, like [hacker typer](https://hackertyper.net/)

![ezgif-3-16e07cbd78](https://github.com/letieu/hacker.nvim/assets/53562817/bbf2b680-3863-47b1-9008-96b5d472769a)


## 🪄 Features
- Let code write itself
- Write code with headless mode
- Custom fake code
- Fake code follow with *current file* with `:HackFollow` or use default fake code with `:Hack`
- Config speed, show popup or not, time to show popup
- Make you look like a 10x developer
- With this plugin, ChatGPT just a baby toy

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

## 🚀 Usage

`Hack` command can be used to open hacker and start hacking

```
:Hack
```

`HackFollow` command can be used to use current file as fake code
```
:HackFollow
```

`HackAuto`, `HackFollowAuto` command can be used to run on **auto type** mode
```
:HackAuto
:HackFollowAuto
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


## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/NStefan002"><img src="https://avatars.githubusercontent.com/u/100767853?v=4?s=100" width="100px;" alt="Stefan Novaković"/><br /><sub><b>Stefan Novaković</b></sub></a><br /><a href="https://github.com/letieu/hacker.nvim/commits?author=NStefan002" title="Code">💻</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!