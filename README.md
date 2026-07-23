```
       ___                           _         
 ____ <  /________ _   __     _   __(_)___ ___ 
/_  / / / ___/ __ \ | / /____| | / / / __ `__ \
 / /_/ / /  / /_/ / |/ /_____/ |/ / / / / / / /
/___/_/_/   \____/|___/      |___/_/_/ /_/ /_/ 
```

A minimal Vim setup for competitive programming in C++, built for Windows and Linux, no WSL required.

## Overview

| Feature | Detail |
|---|---|
| Editor | Vim 8+ or gVim, classic Vim, no Neovim required |
| Plugin manager | vim-plug |
| Linting and completion | ALE with clangd and gcc |
| Formatting | clang-format on save |
| Color scheme | custom dark theme, `competitive` |
| Snippet system | single contest template inserted through a Vimscript function |
| Platforms | Windows (`installer.ps1`) and Linux (`installer.sh`) |

## Installation

| Platform | Command |
|---|---|
| Windows | `powershell -ExecutionPolicy Bypass -File installer.ps1` |
| Linux | `bash installer.sh` |

Both installers check for `g++` and `vim` on PATH, create the required config folders, download `vim-plug`, copy all configuration files, and install plugins automatically.

## Requirements

| Tool | Windows | Linux |
|---|---|---|
| Vim | gVim from vim.org or `winget install vim.vim` | `apt install vim` or equivalent |
| C++ compiler | MinGW-w64 or MSYS2 | `apt install g++` or equivalent |
| clangd and clang-format | LLVM installer | `apt install clangd clang-format` |
| curl | included in Windows 10/11 | included in most distributions |

## Managing plugins

| Action | Command |
|---|---|
| Install plugins | handled automatically by the installer, or run `:PlugInstall` manually inside Vim |
| Update plugins | `:PlugUpdate` |
| Remove unused plugins | `:PlugClean` |
| Check plugin status | `:PlugStatus` |

## Shortcuts

| Mapping | Mode | Action |
|---|---|---|
| F9 | Normal | Save and compile with `g++ -std=c++17 -O2 -Wall -Wshadow` |
| F8 | Normal | Open a terminal split and run the compiled executable |
| `,` `t` `t` | Normal | Open a general-purpose terminal split |
| Tab | Normal | Next buffer |
| Shift + Tab | Normal | Previous buffer |
| `,` `f` `f` | Normal | Start `:find` file search |
| `,` `g` `g` | Normal | Start `:vimgrep` search across `.cpp` files |
| `,` `t` `p` | Normal | Insert the contest template at the cursor |
| `,` `1` | Normal | Open `A.cpp` |
| `,` `2` | Normal | Open `B.cpp` |
| `,` `3` | Normal | Open `C.cpp` |
| `,` `4` | Normal | Open `D.cpp` |
| `,` `5` | Normal | Open `E.cpp` |
| `,` `6` | Normal | Open `F.cpp` |
| `,` `7` | Normal | Open `G.cpp` |
| `,` `8` | Normal | Open `H.cpp` |
| `:New` | Command | Create the next unused lettered file and insert the template |

## Project structure

| Path | Content |
|---|---|
| `vimrc` | Core configuration, plugin declarations, mappings |
| `colors/competitive.vim` | Custom dark color scheme |
| `plugin/quickfiles.vim` | Quick mappings to switch between lettered problem files |
| `ftplugin/cpp.vim` | C++ indentation and compiler settings |
| `snippets/template.cpp` | Contest starting template |
| `installer.ps1` | Windows installer |
| `installer.sh` | Linux installer |
| `autoload/`, `plugged/` | Populated automatically by vim-plug |
