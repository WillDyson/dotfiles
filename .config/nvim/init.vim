" ~~ init ~~
" 1. Create ~/.nvim/undodir
" 2. Install ripgrep and nodejs
" 3. Setup junegunn/vim-plug
" 4. Install plugins and coc extensions

set nocompatible
filetype plugin on
syntax on

" Plugins {{{

call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'dhruvasagar/vim-table-mode'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'purescript-contrib/purescript-vim'
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'

call plug#end()

" }}}

" Basic settings {{{

set hidden
set nobackup
set nowritebackup
set noerrorbells
set tabstop=4 softtabstop=4
set expandtab
set shiftwidth=4
set smartindent
set nowrap
set smartcase
set nobackup
set undodir=~/.nvim/undodir
set undofile
set incsearch
set noshowmode
set splitbelow
set splitright
set scrolloff=5
set foldlevelstart=99
set cmdheight=2
set list listchars=tab:>-,trail:.,extends:>,nbsp:*
set signcolumn=yes
set updatetime=500
set ignorecase
set smartcase

colorscheme gruvbox

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

if !empty(glob("$HOME/.config/nvim/local.vim"))
  source $HOME/.config/nvim/local.vim
endif

" }}}

" Filetype settings {{{

augroup vimscriptgroup
    autocmd!
    autocmd filetype vim setlocal foldmethod=marker
    autocmd filetype vim setlocal foldlevel=0
augroup end

augroup markdowngroup
    autocmd!
    autocmd filetype markdown,mkd call pencil#init({'wrap': 'soft'})
    autocmd filetype markdown,mkd setlocal spell
    autocmd filetype markdown,mkd let b:coc_suggest_disable = 1 
augroup end

augroup vimwikigroup
    autocmd!
    autocmd filetype vimwiki call pencil#init({'wrap': 'soft'})
    autocmd filetype vimwiki setlocal spell
    autocmd filetype vimwiki let b:coc_suggest_disable = 1 
augroup end

augroup scalagroup
    autocmd!
    au BufRead,BufNewFile *.sc setlocal filetype=scala
augroup end

" }}}

" Mappings {{{

let mapleader=','

nnoremap <silent> <leader>ve :edit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>
nnoremap <leader>d "_d
xnoremap <leader>d "_d
nnoremap <silent> <leader><space> :noh<cr>
nnoremap <silent> <leader>= :vertical resize +15<cr>
nnoremap <silent> <leader>- :vertical resize -15<cr>
nnoremap <silent> <leader>s= :resize +15<cr>
nnoremap <silent> <leader>s- :resize -15<cr>
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
inoremap jk <esc>

" gt and gT for movement
nnoremap tc :tabnew<cr>

nnoremap \ :Rg<space>

nnoremap <silent> <leader>ut :UndotreeShow<cr>

nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <leader>fg :GFiles<cr>
nnoremap <silent> <leader>fb :Buffers<cr>
nnoremap <silent> <leader>fl :BLines<cr>
nnoremap <silent> <leader>fh :Helptags<cr>
nnoremap <silent> <leader>fm :Marks<cr>

nnoremap <silent> <leader>zz :Goyo<cr>
nnoremap <silent> <leader>zl :Limelight!!<cr>

nnoremap <silent> <leader>wp :VimwikiDiaryPrevDay<cr>
nnoremap <silent> <leader>wP :VimwikiDiaryNextDay<cr>

nnoremap <silent> <leader>gs :Git status<cr>
nnoremap <silent> <leader>gm :Git commit<cr>
nnoremap <silent> <leader>gp :Git push<cr>
nnoremap <silent> <leader>gb :GBrowse<cr>
nnoremap <silent> <leader>ga :diffget //2<cr>
nnoremap <silent> <leader>g\ :diffget //3<cr>

nnoremap <leader>nm :NERDTreeFocus<CR>
nnoremap <leader>nn :NERDTree<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

" }}}

" jremmen/vim-ripgrep {{{

let g:rg_derive_root='true'

" }}}

" preservim/nerdtree {{{

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

augroup nerdtreegroup
    autocmd!

    " Start NERDTree when Vim starts with a directory argument.
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

    " Exit Vim if NERDTree is the only window left.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
augroup end

" }}}

" vimwiki/vimwiki {{{

let g:vimwiki_list=[{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext=0

augroup vimwikigroup
    autocmd!
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end

" }}}

" junegunn/limelight.vim {{{

let g:limelight_conceal_ctermfg=240

" }}}

" itchyny/lightline.vim {{{

let g:lightline = {
      \ 'colorscheme': 'srcery_drk',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" }}}

" neoclide/coc.nvim {{{

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <Leader>cwe <Plug>(coc-metals-expand-decoration)
nmap <leader>crn <Plug>(coc-rename)
xmap <leader>cfm  <Plug>(coc-format-selected)
nmap <leader>cfm  <Plug>(coc-format-selected)
nmap <leader>cfM  <Plug>(coc-format)
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

nnoremap <silent><nowait> <leader>cA  :<C-u>CocAction<cr>
nnoremap <silent><nowait> <leader>ci  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <leader>cj  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <leader>ck  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <leader>cp  :<C-u>CocListResume<CR>

" Find symbol of current document.
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

" }}}
