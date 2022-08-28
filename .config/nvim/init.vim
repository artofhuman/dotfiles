call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'               " Vim community settings

" Telescope requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Telescope plugins
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'scrooloose/nerdtree'
Plug 'bogado/file-line'                 " Open file and go to number line posiotion
Plug 'numToStr/Comment.nvim'

" Completion (LSP)
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
" Snippets required by cmp
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'mfussenegger/nvim-dap'

" Plug 'github/copilot.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'               " Support git
Plug 'tpope/vim-rhubarb'                " Allow open code on github
Plug 'rhysd/git-messenger.vim'          " Show git commits in popup
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'           " Fast switch between true/false -/+, etc
Plug 'pechorin/any-jump.vim'

Plug 'pangloss/vim-javascript',  { 'for': 'javascript' }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'   " Support for tmux

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Ruby
" Plug 'vim-ruby/vim-ruby',       { 'for': 'ruby' }
Plug 'tpope/vim-rails',         { 'for': 'ruby' }
Plug 'tpope/vim-endwise',       { 'for': ['ruby'] } " Autoclose end on blocks

Plug 'jremmen/vim-ripgrep' " Rg Search

Plug 'arcticicestudio/nord-vim'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

Plug 'psliwka/vim-smoothie' " smoothie cursor motions

Plug 'janko-m/vim-test'
Plug 'editorconfig/editorconfig-vim'

call plug#end()

filetype plugin indent on
syntax on
set signcolumn=number

set termguicolors
colorscheme nord

" show unprintable chars
set list
set listchars=tab:·\ ,trail:·,extends:»,precedes:«

set number

set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set nowrap
set nolinebreak

set splitright
set splitbelow

set sidescrolloff=10

set mouse=a " support mouse scroll for easy navigation in large files

let mapleader = ","

set statusline=%f%h\ %y\ %m\ %r\ %{&encoding}\
set statusline+=%=Line:%l/%L[%p%%]\ Col:%c\ [%b][0x%B]
set statusline+=\ Buf:%n\
set laststatus=3 " for neovim 0.7.0 show global status line

hi StatusLine ctermbg=white ctermfg=white

" Search
set ignorecase

" no backup files
set nobackup
set noswapfile

set foldmethod=indent
set nofoldenable " don't fold by default
set foldlevel=99
" toggle folds with space
nmap <space> za

set wildmode=full
" Ignore compiled files
set wildignore=*.o,*.obj,*~,*.pyc,*.pyo,*.bak
set wildignore+=*DS_Store*

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Diff settings                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add ignorance of whitespace to diff
set diffopt=filler,iwhite,vertical,context:15

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Keymaps                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

" Save
nmap <leader>s :w<cr>
imap <leader>s <esc>:w<cr>
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Clear search results
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" Перемещение строк
" переместить одну строку
nmap <C-S-k> ddkP
nmap <C-S-j> ddp
" переместить несколько выделенных строк http://www.vim.org/scripts/script.php?script_id=1590
vmap <C-S-k> xkP'[V']
vmap <C-S-j> xp'[V']

nnoremap j gj
nnoremap k gk

" Window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" This allows us to save a file as root with the :w!! command, if we have sudo
" privileges, when we're not currently useing vim as root
cmap w!! w !sudo tee % >/dev/null

" Debug
au FileType python map <Leader>d oimport pdb; pdb.set_trace()<esc>:w<cr>
map <Leader>d obinding.pry #NOTE: debugger<esc>:w<cr>

map <C-T> <Esc>:tabnew<CR>
" Return Visual select block after move left/right
vnoremap < <gv
vnoremap > >gv

" For all text files set 'textwidth' to 80 characters.
autocmd FileType text,txt setlocal tw=80
autocmd FileType python setlocal indentkeys-=<:> " do not indent after type in insert mode
autocmd BufRead,BufNewFile *.md         set ft=mkd tw=80 ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.markdown   set ft=mkd tw=80 ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.wiki       set ft=wiki tw=80 ts=2 sw=2 expandtab

autocmd Filetype gitcommit set tw=68  spell

" Custom functions =============================================================
" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
nmap <leader>w :StripTrailingWhitespaces<CR>

"from https://github.com/jackfranklin/dotfiles/blob/master/vim/vimrc
function! OpenProjectNotes()
  let directory = getcwd()
  let filename = '_projectnotes.txt'
  exec ':vsplit ' . directory . '/' . filename
endfunction
nnoremap <leader>pn :call OpenProjectNotes()<cr>

" Show also matching html parenthesis
set matchpairs+=<:>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               NERD Tree                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't display these kinds of files
let NERDTreeIgnore=['\.pyc$', '\~$']
" Disables display of the 'Bookmarks' label and 'Press ? for help' text
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1

" Toggle the NERD Tree on an off
nnoremap <Bs> :NERDTreeToggle<CR>
" Open the project tree and expose current file in the nerdtree with Ctrl-\
nnoremap <silent> <C-e> :NERDTreeFind<CR>

" This is specific to rails apps, but I will not bind it to a particular
" filetype
function! TwoSpace()
    setlocal ts=2
    setlocal sw=2
endfunction
au FileType ruby call TwoSpace()
au FileType coffee call TwoSpace()
au FileType vim call TwoSpace()
au FileType yml call TwoSpace()
au FileType scss call TwoSpace()
au FileType yaml call TwoSpace()
au FileType javascript call TwoSpace()
au BufNewFile,BufRead *.erb call TwoSpace()

" vim-test
map <Leader>rs :TestNearest<CR>
map <Leader>rt :TestFile<CR>
map <Leader>rl :TestLast<CR>

let test#python#runner = 'pytest'
let test#strategy = "vimux"
let pipenv_prefix = "pytest"

nnoremap - :Switch<cr>

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allow to copy/paste between VIM instances
" "copy the current visual selection to ~/.vbuf
vmap <Leader>y :w! ~/.vbuf<CR>
" "copy the current line to the buffer file if no visual selection
nmap <Leader>y :.w! ~/.vbuf<CR>
" "paste the contents of the buffer file
nmap <Leader>p :r ~/.vbuf<CR>

" lsp
set completeopt=menu,menuone,noselect

" imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
" let g:copilot_no_tab_map = v:true
