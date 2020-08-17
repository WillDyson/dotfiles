" ~~ init ~~
" setup junegunn/vim-plug
" create ~/.nvim/undodir
" install ripgrep

set nocompatible
filetype plugin on
syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set expandtab
set shiftwidth=4
set smartindent
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.nvim/undodir
set undofile
set incsearch
set noshowmode
set splitbelow
set splitright
set scrolloff=5

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" toggle word-wrap for text
function! s:ToggleWrap()
    let l:wrapWidth=79

    if &textwidth==l:wrapWidth
        set textwidth=0
        echom "Word-wrap disabled"
    else
        let &textwidth=l:wrapWidth
        echom "Word-wrap enabled (gp to redo text, gqip for paragraphs)"
    endif
endfunction
command! ToggleWrap :call s:ToggleWrap()

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'mbbill/undotree'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'davidhalter/jedi-vim'
Plug 'junegunn/goyo.vim'

call plug#end()

colorscheme gruvbox

let mapleader=','

nnoremap <leader>d "_d
xnoremap <leader>d "_d
nnoremap <silent> <leader>= :vertical resize +5<cr>
nnoremap <silent> <leader>- :vertical resize -5<cr>
nnoremap <silent> <leader>s= :resize +5<cr>
nnoremap <silent> <leader>s- :resize -5<cr>
nnoremap <silent> <leader>tw :ToggleWrap<cr>

nnoremap <leader>\ :Rg<space>
nnoremap <silent> <leader>ut :UndotreeShow<cr>
nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <leader>fb :Buffers<cr>
nnoremap <silent> <leader>fl :BLines<cr>
nnoremap <silent> <leader><space> :noh<cr>
nnoremap <silent> <leader>z :Goyo<cr>

" jremmen/vim-ripgrep
let g:rg_derive_root='true'

" vimwiki/vimwiki
let g:vimwiki_list=[{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext=0
