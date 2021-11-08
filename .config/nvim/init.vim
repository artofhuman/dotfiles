" set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'               " Vim community settings

" Telescope requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Telescope plugins
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'scrooloose/nerdtree'              " Files explorer
Plug 'bogado/file-line'                 " Open file and go to number line posiotion
Plug 'numToStr/Comment.nvim'

" Completion (LSP)
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'

"
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

Plug 'vim-scripts/matchit.zip'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'               " Support git
Plug 'tpope/vim-rhubarb'                " Allow open code on github
Plug 'rhysd/git-messenger.vim'          " Show git commits in popup
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'           " Fast switch between true/false -/+, etc
Plug 'christoomey/vim-tmux-navigator'   " Support for tmux
Plug 'pechorin/any-jump.vim'

Plug 'pangloss/vim-javascript',  { 'for': 'javascript' }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }
Plug 'benmills/vimux'

" Ruby
Plug 'vim-ruby/vim-ruby',       { 'for': 'ruby' }
Plug 'tpope/vim-rails',         { 'for': 'ruby' }
Plug 'tpope/vim-endwise',       { 'for': ['ruby'] } " Autoclose end on blocks
Plug 'tpope/vim-haml',          { 'for': 'haml' }
Plug 'slim-template/vim-slim',  { 'for': 'slim' }

"Plug 'psf/black',               { 'for': 'python' }

"Lisp
Plug 'vim-scripts/paredit.vim',     { 'for': ['scheme'] }

"Plug 'elixir-editors/vim-elixir',   { 'for': 'elixir' }
"Plug 'c-brenn/phoenix.vim',         { 'for': 'elixir' }
"Plug 'slashmili/alchemist.vim',     { 'for': 'elixir' }

" Golang
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }

Plug 'jremmen/vim-ripgrep' " Rg Search

" Theme
Plug 'arcticicestudio/nord-vim'
Plug 'gruvbox-community/gruvbox'

" Murkdown
Plug 'tpope/vim-markdown',      { 'for': 'markdown' }

Plug 'janko-m/vim-test'         " Run tests from vim

" Plug 'airblade/vim-gitgutter'   " Show git changes in sign columns
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'editorconfig/editorconfig-vim'

call plug#end()

filetype plugin indent on
syntax on

set signcolumn=yes

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Colorscheme                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if (has("termguicolors"))
  set termguicolors
endif

syntax enable
colorscheme nord
" let g:molokai_original = 1

" highlight the cursor line and don't underscore it
" set cursorline
"set colorcolumn=80

set viminfo+=! " Support for yankring
set guicursor= " Disable cursor shapes (always be block)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Buffer options                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden              " hide buffers when they are abandoned"
set autoread            " auto reload changed files

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Display options                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set title               " show file name in window title"
set novisualbell        " mute error bell

set list                " show unprintable chars
set listchars=tab:·\ ,trail:·,extends:»,precedes:«
"set relativenumber
set number
set nolazyredraw

set backspace=indent,eol,start
set undolevels=100

" Indicates a fast terminal connection.  More characters will be sent to
" the screen for redrawing, instead of using insert/delete line
" commands.  Improves smoothness of redrawing when there are multiple
" windows and the terminal does not support a scrolling region.
" Also enables the extra writing of characters at the end of each screen
" line for lines that wrap.  This helps when using copy/paste with the
" mouse in an xterm and other terminals.
set ttyfast
"set lazyredraw

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Indention                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
" Turn off line breaks
set nowrap
set nolinebreak

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Localiztion                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set langmenu=none               " always use English menu"
set termencoding=utf-8          " default encoding
set fileencodings=utf-8,cp1251,koi8-r,cp866 " list encodings for completion
set fileformats=unix,dos,mac    " list file formats

" Jump N lines when running out of the screen
set scrolljump=7
set scrolloff=10
set sidescrolloff=10
set sidescroll=1

set splitright
set splitbelow

" Map leader to ,
let mapleader = ","

" Paste mode toggle on <,p>
set pastetoggle=<leader>p

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Status Line                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%f%h\ %y\ %m\ %r\ %{&encoding}\

set statusline+=%=Line:%l/%L[%p%%]\ Col:%c\ [%b][0x%B]
set statusline+=\ Buf:%n\

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Search settings                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Включаем подсветку выражения, которое ищется в тексте
set hlsearch
" Останавливать поиск при достижении конца файла
set nowrapscan
" Игнорировать регистр букв при поиске
set ignorecase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Backups                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set noswapfile
set nowb

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Folding                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=indent
set nofoldenable                " don't fold by default
set foldlevel=99
" toggle folds with space
nmap <space> za

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Completion                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make cmdline tab completion similar to bash
" enable <ctrl-n> and <ctrl-p> to scroll thru matches
set wildmode=list:longest
set wildignore=*.o,*.obj,*~,*.pyc,*.pyo,*.bak
set wildignore+=*DS_Store*
set wildignore+=*.png,*.jpg,*.gif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Diff settings                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add ignorance of whitespace to diff
set diffopt=filler,iwhite,vertical,context:15
let g:html_diff_one_file = 1

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

" Resize windows with arrow keys
nnoremap <D-Up> <C-w>+
nnoremap <D-Down> <C-w>-
nnoremap <D-Left> <C-w><
nnoremap <D-Right>  <C-w>>

" Window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" This allows us to save a file as root with the :w!! command, if we have sudo
" privileges, when we're not currently useing vim as root
cmap w!! w !sudo tee % >/dev/null

" Diff this
"nnoremap <leader>dd :windo diffthis<CR>

" Debug
au FileType python map <Leader>d oimport pdb; pdb.set_trace()<esc>:w<cr>
map <Leader>d obinding.pry #NOTE: debugger<esc>:w<cr>

map <C-T> <Esc>:tabnew<CR>
" Return Visual select block after move left/right
vnoremap < <gv
vnoremap > >gv

" For all text files set 'textwidth' to 80 characters.
autocmd FileType text,txt setlocal tw=80

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
nmap ,w :StripTrailingWhitespaces<CR>

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
" Make nerdtree look nice
" Disables display of the 'Bookmarks' label and 'Press ? for help' text
let NERDTreeMinimalUI = 1
" Tells the NERD tree to use arrows instead of + ~ chars when displaying directories
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30

let NERDTreeShowHidden=1

" Toggle the NERD Tree on an off
nnoremap <Bs> :NERDTreeToggle<CR>
" Open the project tree and expose current file in the nerdtree with Ctrl-\
nnoremap <silent> <C-e> :NERDTreeFind<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               NERD Commenter                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

let g:nerdtree_tabs_open_on_gui_startup = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Vim test
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <Leader>rs :TestNearest<CR>
map <Leader>rt :TestFile<CR>
map <Leader>rl :TestLast<CR>

let test#python#runner = 'pytest'
let test#strategy = "vimux"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Switch                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

nnoremap <silent> <c-w> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-w> :exe "tabn ".g:lasttab<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allow to copy/paste between VIM instances
" "copy the current visual selection to ~/.vbuf
vmap <Leader>y :w! ~/.vbuf<CR>
" "copy the current line to the buffer file if no visual selection
nmap <Leader>y :.w! ~/.vbuf<CR>
" "paste the contents of the buffer file
nmap <Leader>p :r ~/.vbuf<CR>

let g:syntastic_javascript_checkers = ['eslint']

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

""""""""" TAB
set shortmess+=c
set hidden

" set nobackup
" set nowritebackup


lua << EOF
-- LSP Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = false,
  }
)
EOF

lua << EOF
require('Comment').setup()
EOF

