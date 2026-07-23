#!/bin/bash
# Author: z1rov

cat << 'EOF'
       ___                           _         
 ____ <  /________ _   __     _   __(_)___ ___ 
/_  / / / ___/ __ \ | / /____| | / / / __ `__ \
 / /_/ / /  / /_/ / |/ /_____/ |/ / / / / / / /
/___/_/_/   \____/|___/      |___/_/_/ /_/ /_/ 

EOF

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[~] checking dependencies"

if command -v g++ >/dev/null 2>&1; then
  echo "[+] g++ found"
else
  echo "[-] g++ not found, install it with your package manager"
fi

if command -v vim >/dev/null 2>&1; then
  echo "[+] vim found"
else
  echo "[-] vim not found, install it before continuing"
fi

echo "[~] creating vim folders"
mkdir -p "$HOME/.vim/autoload"
mkdir -p "$HOME/.vim/plugged"
mkdir -p "$HOME/.vim/colors"
mkdir -p "$HOME/.vim/plugin"
mkdir -p "$HOME/.vim/ftplugin"
mkdir -p "$HOME/.vim/snippets"
echo "[+] folders ready"

echo "[~] downloading vim-plug"
if curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >/dev/null 2>&1; then
  echo "[+] vim-plug downloaded"
else
  echo "[-] vim-plug download failed, check your connection"
fi

echo "[~] copying configuration files"
cp "$ROOT/vimrc" "$HOME/.vimrc"
cp -r "$ROOT/colors/." "$HOME/.vim/colors/"
cp -r "$ROOT/plugin/." "$HOME/.vim/plugin/"
cp -r "$ROOT/ftplugin/." "$HOME/.vim/ftplugin/"
cp -r "$ROOT/snippets/." "$HOME/.vim/snippets/"
echo "[+] configuration files copied"

if command -v vim >/dev/null 2>&1; then
  echo "[~] installing plugins"
  vim -c "PlugInstall" -c "qa"
  echo "[+] done"
else
  echo "[~] install vim, then open it and run :PlugInstall"
fi
