set clipboard+=unnamedplus

set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cgk,cp936,latin-1
set fileformat=unix
set fileformats=unix,dos,mac
filetype on
syntax on

set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set foldenable
set foldmethod=manual
set foldlevel=99
set ignorecase
set smartcase
set lazyredraw
set mouse=

set updatetime=300
set shortmess+=c

set viewoptions-=options

set wrap linebreak

set number

set shell=/bin/sh

noremap <Space> <Nop>
let mapleader=" "

noremap j gj
noremap k gk
noremap J j
noremap K k
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-m> :tabn<CR>
noremap <C-n> :tabpr<CR>
noremap <C-space> :tabc<CR>:tabp<CR>


noremap x "_x
noremap X "_X

nnoremap <C-c> :noh<CR>

" nnoremap F :set foldmethod=syntax<CR>zc
" vnoremap F <esc>:set foldmethod=manual<CR>gvzf
" noremap f zo
vnoremap F zf

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

for fpath in split(globpath('/home/arch/.config/nvim/scripts/', '*.vim'), '\n')
  exe "source" fpath
endfor


" Plugins
call plug#begin('/home/arch/.config/nvim/plugins')

Plug 'SirVer/ultisnips'

Plug 'cespare/vim-toml'

Plug 'bluz71/vim-moonfly-colors'

Plug 'tikhomirov/vim-glsl'

Plug 'cloudhead/neovim-fuzzy'

Plug 'udalov/kotlin-vim'

call plug#end()

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<enter>"
let g:UltiSnipsJumpBackardTrigger="<c-z>"
let g:UltiSnipsEditSplit="context"

" Colourscheme
colorscheme moonfly
let g:moonflyCursorColor = 1
let g:moonflyTerminalColors = 1

" Fuzzy
nnoremap <C-f> :FuzzyOpen<CR>
nnoremap <C-s> :FuzzyGrep<CR>


" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" End Plugins
