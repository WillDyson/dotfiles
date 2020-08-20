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
set foldlevelstart=99
set list listchars=tab:>-,trail:.,extends:>

let g:netrw_liststyle=3

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.config/nvim/plugged')

Plug 'davidhalter/jedi-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'morhetz/gruvbox'
Plug 'mbbill/undotree'
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'vimwiki/vimwiki'

call plug#end()

colorscheme gruvbox

let mapleader=','

" delete without copy buffer
nnoremap <leader>d "_d
xnoremap <leader>d "_d

" resize windows
nnoremap <silent> <leader>= :vertical resize +5<cr>
nnoremap <silent> <leader>- :vertical resize -5<cr>
nnoremap <silent> <leader>s= :resize +5<cr>
nnoremap <silent> <leader>s- :resize -5<cr>

nnoremap \ :Rg<space>
nnoremap <silent> <leader>ut :UndotreeShow<cr>
nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <leader>fb :Buffers<cr>
nnoremap <silent> <leader>fl :BLines<cr>
nnoremap <silent> <leader><space> :noh<cr>
nnoremap <silent> <leader>zz :Goyo<cr>
nnoremap <silent> <leader>zl :Limelight!!<cr>
nnoremap <silent> <leader>wp :VimwikiDiaryPrevDay<cr>
nnoremap <silent> <leader>wP :VimwikiDiaryNextDay<cr>
nnoremap <silent> <leader>gs :Gstatus<CR>

" jremmen/vim-ripgrep
let g:rg_derive_root='true'

" vimwiki/vimwiki
let g:vimwiki_list=[{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext=0

" junegunn/limelight.vim
let g:limelight_conceal_ctermfg=240

" itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" reedes/vim-pencil
let g:pencil#textwidth = 79

augroup pencil
 autocmd!
 autocmd filetype markdown,mkd call pencil#init()
     \ | setlocal spell
 autocmd filetype vimwiki call pencil#init({'wrap': 'soft'})
     \ | setlocal spell
augroup END
