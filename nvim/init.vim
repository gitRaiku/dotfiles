set clipboard+=unnamedplus

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

" let g:loaded_python3_provider=1
let g:python3_host_prog = '/usr/bin/python3'

" Term
tnoremap <S-Esc> <C-\><C-n>
" tnoremap <C-h> <C-\><C-N><C-w>h
" tnoremap <C-j> <C-\><C-N><C-w>j
" tnoremap <C-k> <C-\><C-N><C-w>k
autocmd TermOpen * nnoremap <Return> A<CR>
if exists('g:terminalfunk')
  autocmd TermClose * :q!
else
  tnoremap <Esc> <C-\><C-n>
  normal :TransparentDisable
endif
" autocmd TermOpen * set modifiable=on
set shell=/bin/fish

noremap <Space> <Nop>

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

nnoremap gC :bot :10new<CR>:term<CR>Aexec calc<CR>

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

" Unception
let g:unception_delete_replaced_buffer=v:true
let g:unception_open_buffer_in_new_tab=v:true
let g:unception_enable_flavor_text=v:true
let g:unception_block_while_host_edits=v:false
let g:unception_disable=v:false

" Plugins
call plug#begin('~/.config/nvim/plugins')

Plug 'xiyaowong/transparent.nvim'

Plug 'SirVer/ultisnips'

Plug 'bluz71/vim-moonfly-colors'

" Plug 'cespare/vim-toml'

" Plug 'tikhomirov/vim-glsl'

Plug 'cloudhead/neovim-fuzzy'

Plug 'udalov/kotlin-vim'

Plug 'mickael-menu/zk-nvim'

Plug 'neovim/nvim-lspconfig'

Plug 'samjwill/nvim-unception'

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

function Rer()
  nnoremap UU :sp /home/raiku/Git/Benzaiten/vivado/rv32i.sim/sim_1/behav/xsim/xvlog.log<CR>
  nnoremap UE :sp /home/raiku/Git/Benzaiten/vivado/rv32i.sim/sim_1/behav/xsim/elaborate.log<CR>
endfunction

augroup your_group
  autocmd! 
  autocmd FileType verilog call MakeVerilogReadable()
  autocmd FileType systemverilog call Rer()
  autocmd FileType systemverilog call MakeVerilogReadable()
augroup END

augroup my_group
  autocmd! 
  autocmd FileType svelte set filetype=html
  autocmd FileType sage set filetype=python
augroup END

function MakeUltisnipsUnderstandHVsCPP()
  UltiSnipsAddFiletypes h
endfunction



" augroup betterVerilog
  " autocmd!
  " autocmd FileType verilog
" augroup END

" Lua
lua <<EOF
  require('lspconfig').verible.setup {
    cmd = {'/usr/local/bin/verible-verilog-ls', '--rules_config_search'},
  }
EOF
lua <<EOF
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      update_in_insert = true,
    }
  )
  local opts = { noremap=true, silent=true }
  local function quickfix()
      vim.diagnostic.goto_next()
      vim.lsp.buf.code_action({
          filter = function(a) return a.isPreferred end,
          apply = true
      })
  end
  --[[
  vim.keymap.set('n', '<Space>bs', function() 
    --  os.execute("./build.sh synthesis") 
    local job = vim.fn.jobstart(
    'echo hello', {
        on_exit = function(pula) print(pula) end,
        on_stdout = function(pula) print(pula) end,
        on_stderr =function(pula) print(pula) end
    }
    )
  end, {})
  --]]
EOF
" autocmd BufWritePost *.v,*.sv lua vim.lsp.buf.format({ async = false })
nnoremap <A-S-Return> <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <C-m> :!make run<CR>
