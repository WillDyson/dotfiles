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
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
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
set cmdheight=2
set list listchars=tab:>-,trail:.,extends:>,nbsp:*
set signcolumn=yes
set updatetime=500
set mouse=a

colorscheme gruvbox

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

let g:netrw_liststyle=3

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
augroup end

augroup vimwikigroup
    autocmd!
    autocmd filetype vimwiki call pencil#init({'wrap': 'soft'})
    autocmd filetype vimwiki setlocal spell
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
nnoremap <silent> <leader>gs :Gstatus<cr>
nnoremap <silent> <leader>gm :Gcommit<cr>
nnoremap <silent> <leader>gp :Gpush<cr>
nnoremap <silent> <leader>gb :GBrowse<cr>
nnoremap <silent> <leader>ga :diffget //2<cr>
nnoremap <silent> <leader>g\ :diffget //3<cr>

" }}}

" jremmen/vim-ripgrep {{{

let g:rg_derive_root='true'

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

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

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
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <Leader>cwe <Plug>(coc-metals-expand-decoration)
nmap <leader>crn <Plug>(coc-rename)
xmap <leader>cfm  <Plug>(coc-format-selected)
nmap <leader>cfm  <Plug>(coc-format-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" }}}
