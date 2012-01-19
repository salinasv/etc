imap <buffer> \it <Plug>Tex_InsertItemOnThisLine

set textwidth=75

" Let's use the vim-latex alt-keys instead of accessing the gui menu.
set winaltkeys=no

" Use pdf
let g:Tex_DefaultTargetFormat = 'pdf'
" A comma seperated list of formats which need multiple compilations to be
" correctly compiled.
let g:Tex_MultipleCompileFormats = 'pdf,dvi'
