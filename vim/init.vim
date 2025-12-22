" Modern Vim configuration using vim-plug
" Auto-install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Essential plugins
Plug 'tpope/vim-sensible'           " Sensible defaults
Plug 'tpope/vim-surround'           " Surround text objects
Plug 'tpope/vim-repeat'             " Repeat plugin commands
Plug 'tpope/vim-commentary'         " Comment/uncomment
Plug 'tpope/vim-fugitive'           " Git integration

" UI enhancements
Plug 'morhetz/gruvbox'              " Modern colorscheme
Plug 'vim-airline/vim-airline'      " Status line
Plug 'vim-airline/vim-airline-themes'

" File navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'             " Fuzzy finder
Plug 'preservim/nerdtree'           " File tree

" Code intelligence
Plug 'dense-analysis/ale'           " Async linting
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP support

" Language support
Plug 'sheerun/vim-polyglot'         " Language pack
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Productivity
Plug 'jiangmiao/auto-pairs'         " Auto-close brackets
Plug 'christoomey/vim-tmux-navigator' " Tmux integration

call plug#end()

" Basic settings
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set ignorecase smartcase
set hlsearch incsearch
set hidden
set updatetime=300
set signcolumn=yes

" Colorscheme
set termguicolors
colorscheme gruvbox
set background=dark

" Key mappings
let mapleader = "\<space>"

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" File navigation
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>r :Rg<CR>

" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" CoC configuration
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)