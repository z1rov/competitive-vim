# Author: z1rov

Write-Host "       ___                           _         "
Write-Host " ____ <  /________ _   __     _   __(_)___ ___ "
Write-Host "/_  / / / ___/ __ \ | / /____| | / / / __ `__ \"
Write-Host " / /_/ / /  / /_/ / |/ /_____/ |/ / / / / / / /"
Write-Host "/___/_/_/   \____/|___/      |___/_/_/ /_/ /_/ "
Write-Host ""

$root = $PSScriptRoot
$vimhome = "$HOME\.vimfiles"

Write-Host "[~] checking dependencies"

$gpp = Get-Command g++ -ErrorAction SilentlyContinue
if ($gpp) {
  Write-Host "[+] g++ found"
} else {
  Write-Host "[-] g++ not found, install MinGW-w64 or MSYS2 and add it to PATH"
}

$vimCmd = Get-Command gvim -ErrorAction SilentlyContinue
if (-not $vimCmd) {
  $vimCmd = Get-Command vim -ErrorAction SilentlyContinue
}
if ($vimCmd) {
  Write-Host "[+] vim found"
} else {
  Write-Host "[-] vim not found, install it before continuing"
}

Write-Host "[~] creating vimfiles folders"
New-Item -ItemType Directory -Force -Path "$vimhome\autoload" | Out-Null
New-Item -ItemType Directory -Force -Path "$vimhome\plugged" | Out-Null
New-Item -ItemType Directory -Force -Path "$vimhome\colors" | Out-Null
New-Item -ItemType Directory -Force -Path "$vimhome\plugin" | Out-Null
New-Item -ItemType Directory -Force -Path "$vimhome\ftplugin" | Out-Null
New-Item -ItemType Directory -Force -Path "$vimhome\snippets" | Out-Null
attrib +h "$vimhome"
Write-Host "[+] folders ready"

Write-Host "[~] downloading vim-plug"
try {
  Invoke-WebRequest -Uri "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" -OutFile "$vimhome\autoload\plug.vim"
  Write-Host "[+] vim-plug downloaded"
} catch {
  Write-Host "[-] vim-plug download failed, check your connection"
}

Write-Host "[~] copying configuration files"
Copy-Item -Path "$root\vimrc" -Destination "$HOME\_vimrc" -Force
Copy-Item -Path "$root\colors\*" -Destination "$vimhome\colors\" -Recurse -Force
Copy-Item -Path "$root\plugin\*" -Destination "$vimhome\plugin\" -Recurse -Force
Copy-Item -Path "$root\ftplugin\*" -Destination "$vimhome\ftplugin\" -Recurse -Force
Copy-Item -Path "$root\snippets\*" -Destination "$vimhome\snippets\" -Recurse -Force
Write-Host "[+] configuration files copied"

if ($vimCmd -and $vimCmd.Name -eq "gvim.exe") {
  Write-Host "[~] installing plugins"
  & gvim -c "PlugInstall" -c "qa"
  Write-Host "[+] done"
} else {
  Write-Host "[~] open vim manually and run :PlugInstall"
}
