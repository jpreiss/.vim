" VIM, not VI
set nocompatible
filetype off

let g:os = substitute(system('uname'), '\n', '', '')

" Run per-type scripts after detecting file type.
" TODO: Why aren't we also enabling filetype indent?
filetype plugin on

" Disable bells.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Appearance.
set t_Co=256  " Expect 256-color terminal.
syntax on     " Enable syntax highlighting.
set number    " Show line numbers.
set ruler     " Show cursor position in lower right.
set wrap      " Wrap long lines.
set linebreak " Wrap at word boundaries instead of characters.
set list      " Highlight tabs and trailing spaces.
set list listchars=tab:»·,trail:·
set background=dark

" Indentation policy.
" TODO: Should we be seeting softtabstop and/or smartindent too?
set autoindent " Match indentation when opening new lines.
set tabstop=4  " If not detected from file content, use 4-spaces...
set shiftwidth=4
let g:yaifa_shiftwidth=4
let g:yaifa_tabstop=4

" General editor policy.
set backspace=2  " Use typical backspace behavior.
set nojoinspaces " Do not insert double-spaces when wrapping with gq.
set autochdir    " Automatically cd to file directory.
set nobackup     " Don't write backup files. Version control is enough...
set nowritebackup
set noswapfile

" When running !commands, use bash with .bashrc.
set shell=/bin/bash\ --rcfile\ ~/.bashrc

" Replace (paste) without yanking replaced text.
vnoremap <leader>p "_dP

" Hide all GUI chrome in gvim.
set guioptions-=m
set guioptions-=T
set guioptions-=r

" Always use spaces for Python and retab on save. (Disabled!)
" autocmd FileType python set expandtab
" autocmd BufWrite *.py retab

" Syntax highlighting extension interpretation rules.
au BufNewFile,BufRead *.launch set filetype=xml
au BufNewFile,BufRead *.tikz set filetype=tex
au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown

" Set ctrl , and ctrl . to resize vertical windows.
noremap <F11> :vertical resize -5<cr>
noremap <F12> :vertical resize +5<cr>

" Airline config.
let g:airline_theme='lucius'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= '|'
let g:airline_left_sep = '|'

" Vimtex config.
let g:tex_flavor = 'latex'

" UltiSnips config.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:ultisnips_python_style="google"

" EasyAlign config.
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Autoextend and gq support for Doxygen comment style.
autocmd FileType cpp set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://

" OS-specific stuff.
if has('macunix')
    set guifont=Monaco:h12
endif

" Mac terminals don't have access to Python 3 by default.
if (has('macunix') && has('gui')) || has('linux')
    packadd! ultisnips
    packadd! vim-snippets
    packadd! vimwiki
    let g:vimwiki_list = [{
        \ 'path': '~/vimwiki/',
        \ 'path_html': '~/vimwiki/html/',
        \ 'index': 'main',
        \ 'template_default': 'default',
        \ 'custom_wiki2html': 'vimwiki_markdown',
        \ 'html_filename_parameterization': 1,
        \ 'ext': '.md',
        \ 'syntax': 'markdown'}]
endif

" TODO: wildignore? set hidden?


function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

set laststatus=2
set statusline=
set statusline+=%{SyntaxItem()}

color enough
