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
VIMHOME="$HOME/.vim"

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

echo "[~] checking clipboard support"
if vim --version 2>/dev/null | grep -q '+clipboard'; then
  echo "[+] clipboard support found"
else
  echo "[-] vim was built without +clipboard, install vim-gtk3 or gvim for Ctrl+C/Ctrl+V to work"
fi

echo "[~] creating vim folders"
mkdir -p "$VIMHOME/autoload"
mkdir -p "$VIMHOME/plugged"
mkdir -p "$VIMHOME/colors"
mkdir -p "$VIMHOME/plugin"
mkdir -p "$VIMHOME/ftplugin"
mkdir -p "$VIMHOME/snippets"
echo "[+] folders ready"

echo "[~] downloading vim-plug"
if curl -fLo "$VIMHOME/autoload/plug.vim" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >/dev/null 2>&1; then
  echo "[+] vim-plug downloaded"
else
  echo "[-] vim-plug download failed, check your connection"
fi

echo "[~] copying configuration files"
cp "$ROOT/vimrc" "$HOME/.vimrc"
cp -r "$ROOT/colors/." "$VIMHOME/colors/"
cp -r "$ROOT/plugin/." "$VIMHOME/plugin/"
cp -r "$ROOT/ftplugin/." "$VIMHOME/ftplugin/"
cp -r "$ROOT/snippets/." "$VIMHOME/snippets/"
echo "[+] configuration files copied"

if command -v vim >/dev/null 2>&1; then
  echo "[~] installing plugins"
  vim -c "PlugInstall" -c "qa"
  echo "[+] done"
else
  echo "[~] install vim, then open it and run :PlugInstall"
fi
