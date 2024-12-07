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
set tw=0

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

noremap x "_x
noremap X "_X

nnoremap <C-c> :noh<CR>

" nnoremap F :set foldmethod=syntax<CR>zc
" vnoremap F <esc>:set foldmethod=manual<CR>gvzf
" noremap f zo
vnoremap F zf

augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.tex,*.v,*.vh,*.c,*.h,*.cpp,*.rs,*.kt,*.kts,*.java,*.md,lograpoarte,*.py,*.txt mkview
  autocmd BufWinEnter *.tex,*.v,*.vh,*.c,*.h,*.cpp,*.rs,*.kt,*.kts,*.java,*.md,lograpoarte,*.py,*.txt silent! loadview
augroup END

" augroup user_colors
  " autocmd!
  " autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
" augroup END

for fpath in split(globpath('~/.config/nvim/scripts/', '*.vim'), '\n')
  exe "source" fpath
endfor

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.config/nvim/plugins')

Plug 'xiyaowong/transparent.nvim'

Plug 'SirVer/ultisnips'

Plug 'bluz71/vim-moonfly-colors'

Plug 'cespare/vim-toml'

Plug 'tikhomirov/vim-glsl'

Plug 'cloudhead/neovim-fuzzy'

Plug 'udalov/kotlin-vim'

Plug 'mickael-menu/zk-nvim'

call plug#end()

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<enter>"
let g:UltiSnipsJumpBackardTrigger="<c-z>"
let g:UltiSnipsEditSplit="context"

" Colourscheme
let g:moonflyCursorColor = 1
let g:moonflyTerminalColors = 0
colorscheme moonfly

" Fuzzy
nnoremap <C-f> :FuzzyOpen<CR>
nnoremap <C-s> :FuzzyGrep<CR>

" Conceals
function! ToggleConcealLevel()
    if &conceallevel == 0
        setlocal conceallevel=2
    else
        setlocal conceallevel=0
    endif
endfunction

nnoremap <silent> <C-y> :call ToggleConcealLevel()<CR>

function MakeVerilogReadable()
  setlocal conceallevel=1
  hi Conceal ctermbg=None ctermfg=14 guifg='#e2637f'
  call matchadd('Conceal', 'begin',    10, -1, {'conceal':'{'})
  call matchadd('Conceal', 'end',      10, -1, {'conceal':'}'})
  " call matchadd('Conceal', 'begin ',    10, -1, {'conceal':'{'})
  " call matchadd('Conceal', 'begin$',    10, -1, {'conceal':'{'})
  " call matchadd('Conceal', 'end ',      10, -1, {'conceal':'}'})
  " call matchadd('Conceal', 'end$',      10, -1, {'conceal':'}'})
endfunction

augroup your_group
  autocmd! 
  autocmd FileType verilog call MakeVerilogReadable()
augroup END

function MakeUltisnipsUnderstandHVsCPP()
  UltiSnipsAddFiletypes h
endfunction

" augroup betterVerilog
  " autocmd!
  " autocmd FileType verilog
" augroup END

" Lua
" lua require('init')
