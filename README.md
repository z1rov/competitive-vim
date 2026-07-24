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
| Config folder | `~/.vimfiles` on Windows (hidden), `~/.vim` on Linux |
| System clipboard | `Ctrl+C` to copy, `Ctrl+V` to paste, on both platforms |
| Snippet system | three templates (contest, codeforces, leetcode) inserted through a Vimscript function |
| Platforms | Windows (`installer.ps1`) and Linux (`installer.sh`) |

## Installation

| Platform | Command |
|---|---|
| Windows | `powershell -ExecutionPolicy Bypass -File installer.ps1` |
| Linux | `bash installer.sh` |

Both installers check for `g++` and `vim` on PATH, create the required config folders, download `vim-plug`, copy all configuration files, and install plugins automatically.

On Windows the config folder is created as `%USERPROFILE%\.vimfiles` and marked hidden with `attrib +h`. Since Vim on Windows doesn't look at a dotted folder by default, `vimrc` explicitly points `runtimepath`/`packpath` at it, so colors, plugins, ftplugin, and snippets all load from there.

## Requirements

| Tool | Windows | Linux |
|---|---|---|
| Vim | gVim from vim.org or `winget install vim.vim` | `apt install vim-gtk3` (needed for clipboard support) |
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
| `,` `t` `p` | Normal | Insert the **contest** template |
| `,` `t` `c` | Normal | Insert the **codeforces** template |
| `,` `t` `l` | Normal | Insert the **leetcode** template |
| `,` `1` | Normal | Open `A.cpp` |
| `,` `2` | Normal | Open `B.cpp` |
| `,` `3` | Normal | Open `C.cpp` |
| `,` `4` | Normal | Open `D.cpp` |
| `,` `5` | Normal | Open `E.cpp` |
| `,` `6` | Normal | Open `F.cpp` |
| `,` `7` | Normal | Open `G.cpp` |
| `,` `8` | Normal | Open `H.cpp` |
| `Ctrl+C` | Visual | Copy selection to the system clipboard |
| `Ctrl+X` | Visual | Cut selection to the system clipboard |
| `Ctrl+V` | Normal / Insert / Command | Paste from the system clipboard |
| `:New` | Command | Create the next unused lettered file and insert the contest template |
| `:Template <name>` | Command | Insert a specific template by name (`contest`, `codeforces`, `leetcode`) |

## Templates

| Name | File | Use case |
|---|---|---|
| `contest` | `snippets/contest.cpp` | General template used by `:New` and the lettered files (`A.cpp`...`H.cpp`) |
| `codeforces` | `snippets/codeforces.cpp` | Fast I/O plus a `t` test-case loop, nothing else, so you can start typing right away |
| `leetcode` | `snippets/leetcode.cpp` | A `// Paste Solution Class` marker where you drop LeetCode's `class Solution { ... };` block, plus a `main` that instantiates it |

## Project structure

| Path | Content |
|---|---|
| `vimrc` | Core configuration, plugin declarations, mappings, clipboard setup |
| `colors/competitive.vim` | Custom dark color scheme |
| `plugin/quickfiles.vim` | Quick mappings to switch between lettered problem files |
| `ftplugin/cpp.vim` | C++ indentation and compiler settings |
| `snippets/contest.cpp` | Contest starting template |
| `snippets/codeforces.cpp` | Codeforces starting template |
| `snippets/leetcode.cpp` | LeetCode starting template |
| `installer.ps1` | Windows installer, deploys to hidden `.vimfiles` |
| `installer.sh` | Linux installer |
| `autoload/`, `plugged/` | Populated automatically by vim-plug |
