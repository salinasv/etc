" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

filetype off
syntax on

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Set the line number on the left side of the text
set number

"*************************************************
" Added by me
"*************************************************

"Colorschemes
set background=dark
"" xterm16
"let xterm16_colormap = 'standard'
"let xterm16_brightness = 'default'
"colorscheme xterm16
colorscheme ron
" Menu chingon
set wildmenu

" Compilar desde vim. Ejecuta el makefile en el directorio.
map <F8> :make <CR>

" Instant doc (man)
runtime! ftplugin/man.vim
map <C-k> \K

" Vim-Latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor= "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

" Indentation
set tabstop=4
set shiftwidth=4
"set expandtab	" Spaces instead of tabs

" Show whitespaces red.
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Fold code, it looks nicer.
set foldmethod=syntax

"< hacosta> para esas veces que modificas un archivo pero no tienes los permisos correctos..
command W w !sudo tee % > /dev/null

" hacosta, cotorreo para ctags fresco
"set tags=~/.vim/localtags
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_MayCompleteDot = 1
"let OmniCpp_MayCompleteArrow = 1
"let OmniCpp_MayCompleteScope = 1
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
set completeopt=menu,longest,preview
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"

"impresionar multitudes (abre vimrc cuando uno escribe ",vim")
noremap ,vim :new ~/.vimrc<cr>

"scroll en insert mode
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

"magia paste
set pastetoggle=<f5>

"*************************************************

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " VimOrganizer
  au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
  au BufEnter *.org            call org#SetOrgFileType()

  augroup END

  "" Pidigin setup

  autocmd! BufReadPost,BufNewFile */ChangeLog call <SID>ChangeLogNewsOptions()
  autocmd! BufReadPost,BufNewFile */NEWS call <SID>ChangeLogNewsOptions()
  autocmd! BufReadPost,BufNewFile */pidgin/* call <SID>PidginOptions()
  autocmd! BufReadPost,BufNewFile */libpurple/* call <SID>PidginOptions()
  autocmd! BufReadPost,BufNewFile */*.py call <SID>PythonOptions()

  function! <SID>ChangeLogNewsOptions()
      " These settings affect ChangeLog and NEWS files only
      setlocal sw=8
      setlocal tabstop=8
  endfunction

  function! <SID>PidginOptions()
      " These settings affect ChangeLog and NEWS files only
      setlocal sw=4
      setlocal tabstop=4
  endfunction

  function! <SID>PythonOptions()
      " These settings affect ChangeLog and NEWS files only
      setlocal sw=4
      setlocal tabstop=4
      setlocal expandtab
  endfunction

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
"command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
"	 	\ | wincmd! p | diffthis!
