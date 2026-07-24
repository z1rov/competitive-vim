" Author: z1rov
set nocompatible
filetype plugin indent on
syntax on
set number
set norelativenumber
set ruler
set laststatus=2
set showtabline=2
set noshowmode
set cursorline
set wildmenu
set wildmode=longest:full,full
set incsearch
set hlsearch
set ignorecase
set smartcase
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set backspace=indent,eol,start
set mouse=a
set encoding=utf-8
set fileencoding=utf-8
set updatetime=300
set signcolumn=yes
set hidden
set noswapfile
set nobackup
set nowritebackup
set splitbelow
set splitright
set clipboard=unnamed
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guifont=Consolas:h11
let mapleader=","
if has('win32') || has('win64')
  let g:vimhome = expand('~/vimfiles')
  let g:exeext = '.exe'
else
  let g:vimhome = expand('~/.vim')
  let g:exeext = ''
endif
if !empty(glob(g:vimhome . '/autoload/plug.vim'))
  call plug#begin(g:vimhome . '/plugged')
  Plug 'dense-analysis/ale'
  Plug 'jiangmiao/auto-pairs'
  call plug#end()
  let g:ale_linters = {'cpp': ['clangd', 'gcc']}
  let g:ale_fixers = {'cpp': ['clang-format']}
  let g:ale_fix_on_save = 1
  let g:ale_completion_enabled = 1
  let g:ale_cpp_clangd_options = '--header-insertion=never'
  let g:ale_sign_error = 'EE'
  let g:ale_sign_warning = 'WW'
  let g:ale_lint_on_text_changed = 'normal'
  let g:ale_lint_on_insert_leave = 1
  let g:ale_virtualtext_cursor = 1
  set omnifunc=ale#completion#OmniFunc
  let g:auto_pairs_shortcut_toggle = ''
else
  echohl WarningMsg
  echom 'vim-plug is missing, run the installer before using PlugInstall'
  echohl None
endif
colorscheme competitive
autocmd BufNewFile,BufRead *.cpp set filetype=cpp
nnoremap <F9> :call CompileAndRun()<CR>
nnoremap <leader>tt :below 10split \| terminal<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>ff :find<Space>
nnoremap <leader>gg :vimgrep //gj **/*.cpp<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
nnoremap <leader>tp :call InsertTemplate()<CR>
command! New call NewProblemFile()
function! InsertTemplate()
  if line('$') == 1 && getline(1) == ''
    execute '0read ' . g:vimhome . '/snippets/template.cpp'
    normal! Gdd
  else
    execute '-1read ' . g:vimhome . '/snippets/template.cpp'
  endif
  normal! Gzz
endfunction
function! NewProblemFile()
  let l:letters = 'ABCDEFGH'
  let l:i = 0
  while l:i < len(l:letters)
    let l:name = l:letters[l:i] . '.cpp'
    if !filereadable(l:name)
      execute 'edit ' . l:name
      call InsertTemplate()
      return
    endif
    let l:i += 1
  endwhile
endfunction
function! CompileAndRun()
  write
  let l:exe = expand('%:r') . g:exeext
  let l:cmd = 'g++ -std=c++17 -O2 -Wall -Wshadow -DLOCAL -o ' . shellescape(l:exe) . ' ' . shellescape(expand('%'))
  let l:output = system(l:cmd)
  if v:shell_error != 0
    echohl ErrorMsg
    echo l:output
    echohl None
  else
    if !empty(l:output)
      echohl WarningMsg
      echo l:output
      echohl None
    endif
    if has('win32') || has('win64')
      execute 'silent !start cmd /k ' . shellescape('.\' . l:exe)
    else
      execute 'silent !x-terminal-emulator -e bash -c ' . shellescape(shellescape(l:exe) . '; exec bash')
    endif
    redraw!
  endif
endfunction
