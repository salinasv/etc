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

" Just don't accept less than 256 colors
set t_Co=256

if has("gui_running")
    "set guifont=Inconsolata\ Regular:h14
	set guifont=DejaVu\ Sans\ Mono:h12
endif

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

" executes .vimrc from working dir
set exrc
set secure " Don't alow shell or write commands to be executed from vimrc.

" Prefer python3
set pyxversion=3
if has('python3')
elseif has(python)
endif

" YouCompleteMe configuration
let g:ycm_python_binary_path = "/usr/local/bin/python3"
let g:ycm_server_python_interpreter = "/usr/local/bin/python3"

" YouCompleteMe mapping
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoTo<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>

if has('osx')
	" Fix dead keys on normal mode
	" OSX US_Intl keyboard break ", just remap it to ""
	nnoremap "" "
endif

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

" Vundle config
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator' " Used to generate config files for .ycm and color_coded
Plugin 'roxma/nvim-yarp' "needed by denite
Plugin 'roxma/vim-hug-neovim-rpc'  "needed by denite
Plugin 'Shougo/denite.nvim'
Plugin 'fatih/vim-go'
" Colorschemes
Plugin 'flazz/vim-colorschemes'
Plugin 'felixhummel/setcolors.vim'

call vundle#end()

"Colorschemes
set background=dark
"SetColors all
colorscheme wombat256

"Denite
noremap <silent><localleader>f :<C-u>Denite buffer file/rec<CR>
	" Define mappings
	autocmd FileType denite call s:denite_my_settings()
	function! s:denite_my_settings() abort
	  nnoremap <silent><buffer><expr> <CR>
	  \ denite#do_map('do_action')
	  nnoremap <silent><buffer><expr> d
	  \ denite#do_map('do_action', 'delete')
	  nnoremap <silent><buffer><expr> p
	  \ denite#do_map('do_action', 'preview')
	  nnoremap <silent><buffer><expr> q
	  \ denite#do_map('quit')
	  nnoremap <silent><buffer><expr> i
	  \ denite#do_map('open_filter_buffer')
	  nnoremap <silent><buffer><expr> <Space>
	  \ denite#do_map('toggle_select').'j'
	endfunction

	autocmd FileType denite-filter call s:denite_filter_my_settings()
	function! s:denite_filter_my_settings() abort
	  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
	endfunction

" vim-go setup
let g:go_highlight_build_constraints = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_parameters = 1
" Fix fmt folding all everytime the file is saved
let g:go_fmt_experimental = 1
let g:go_auto_type_info = 0
"let g:go_updatetime=100 "enable if auto_type_info is enabled

autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>i <Plug>(go-info)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
" GoAlternate + splits
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" easier navigation through quicfix list. From vim-go tutorial
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
noremap <leader>a :cclose<CR>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
"command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
"	 	\ | wincmd! p | diffthisc
