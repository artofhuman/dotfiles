"
set nocompatible

" vundle init (github.com/gmarik/vundle)
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required!
Bundle 'gmarik/vundle'

" Define bundles
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'

Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'scrooloose/nerdcommenter'

Bundle 'neocomplcache'
Bundle 'snipMate'
Bundle 'honza/snipmate-snippets'

Bundle 'michaeljsmith/vim-indent-object'
Bundle 'matchit.zip'
"Bundle 'git://github.com/Townk/vim-autoclose.git'
Bundle 'vim-scripts/mru.vim.git'
Bundle 'Lokaltog/vim-powerline.git'

Bundle 'scrooloose/syntastic'

Bundle 'sukima/xmledit'
Bundle 'pangloss/vim-javascript'

" Python/Django ==============================
Bundle 'git://github.com/klen/python-mode.git'
"Bundle 'git://github.com/davidhalter/jedi-vim'

" Ruby ======================================
"Bundle 'git://github.com/astashov/vim-ruby-debugger.git'
Bundle 'vim-ruby/vim-ruby'
" Bundle 'tpope/vim-rvm'
Bundle 'tpope/vim-rails'
Bundle 'astashov/vim-ruby-debugger'
" Bundle 'danchoi/ri.vim'
" Bundle 'duwanis/tomdoc.vim'

" PHP =======================================
Bundle 'shawncplus/phpcomplete.vim'

" JSON ======================================
" Bundle 'git://github.com/leshill/vim-json.git'

Bundle 'Tagbar'
Bundle 'ervandew/supertab.git'

" Debug ======================================
Bundle 'joonty/vdebug.git'

" Theme ======================================
Bundle 'git://github.com/altercation/vim-colors-solarized.git'
Bundle 'git://github.com/chriskempson/vim-tomorrow-theme.git'
Bundle 'croaky/vim-colors-github'
Bundle 'tomasr/molokai'
Bundle "daylerees/colour-schemes", { "rtp": "vim-themes/" }
Bundle 'jpo/vim-railscasts-theme'

" Murkdown ===================================
Bundle 'tpope/vim-markdown'

" General options =============================================================

" Не бибикать!
set visualbell " Use visual bell instead of beeping
set t_vb=

syntax on
filetype on
filetype plugin on
filetype indent on

" Не показывать парную скобку
"let loaded_matchparen=1 " перестает прыгать на парную скобку, показывая где она. +100 к скорости
"set noshowmatch " Не показывать парные <> в HTML

set ttyfast
set encoding=utf-8
" Кодировка по-умолчанию
set termencoding=utf-8
" Список кодировок файлов для автоопределения
set fileencodings=utf-8,cp1251,koi8-r,cp866
" Список форматов файлов
set fileformats=unix,dos,mac

" Reload files changed outside vim
set autoread

set backspace=indent,eol,start
set history=1000
set undolevels=100

" Indentation
set autoindent
set smartindent
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Выключаем перенос строк
set nowrap
set nolinebreak

" Jump N lines when running out of the screen
set scrolljump=7
set scrolloff=10
set sidescrolloff=10
set sidescroll=1

set cursorline
set number
set numberwidth=3
set ruler
set nolazyredraw

set splitright
set splitbelow

" Hide buffers when not displayed
set hidden

" Show incomplete cmds down the bottom
set showcmd
" Show current mode down the bottom
set showmode

" Включить подсветку невидимых символов
set list
set listchars=tab:·\ ,trail:·,extends:»,precedes:«

" Использовать <,> в качестве <leader>-кнопки
let mapleader = ","

" Show ↪ at the beginning of wrapped lines
if has("linebreak")
    let &sbr = nr2char(8618).' '
endif

set textwidth=0
if version >= 703
    " mark the ideal max text width
    set colorcolumn=+1
end

" Paste mode toggle on <,p>
set pastetoggle=<leader>p

if has('unnamedplus')
    set clipboard=unnamedplus
endif
" Splits ===============================

" Создаем пустой сплит относительно текущего
nmap <Leader><left>  :leftabove  vnew<CR>
nmap <Leader><right> :rightbelow vnew<CR>
nmap <Leader><up>    :leftabove  new<CR>
nmap <Leader><down>  :rightbelow new<CR>

" Status line ==================================================================
" Включаем отображение дополнительной информации в статусной строке
set laststatus=2
set statusline=%f%h\ %y\ %m\ %r\ %{&encoding}\

" The statusline flag for syntastic plugin
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set statusline+=%=Line:%l/%L[%p%%]\ Col:%c\ [%b][0x%B]
set statusline+=\ Buf:%n\

" Search settings =============================================================
" При поиске перескакивать на найденный текст в процессе набора строки
set incsearch
" Включаем подсветку выражения, которое ищется в тексте
set hlsearch
" Останавливать поиск при достижении конца файла
set nowrapscan
" Игнорировать регистр букв при поиске
set ignorecase

" Backups ======================================================================
set nobackup
set noswapfile
set nowb

" Folds ========================================================================
set foldmethod=indent
" dont fold by default
set nofoldenable

" Completion ===================================================================
" Make cmdline tab completion similar to bash
" enable <ctrl-n> and <ctrl-p> to scroll thru matches
set wildmenu
set wildmode=list:longest
set wildignore=*.o,*.obj,*~,*.pyc,*.pyo,*.bak
set wildignore+=*DS_Store*
set wildignore+=*.png,*.jpg,*.gif

" Diff settings ================================================================
" Add ignorance of whitespace to diff
set diffopt=filler,iwhite,vertical,context:15
let g:html_diff_one_file = 1

" GUI ==========================================================================
set background=dark

" tell the term has 256 colors
set t_Co=256
if has('gui_running')
     let g:solarized_termcolors=256
     set background=dark
     colorscheme railscasts
    set guifont=Monaco:h12
    " Automatically resize splits when resizing MacVim window
    autocmd VimResized * wincmd =
else
     let g:solarized_termcolors=16
     set background=dark
      colorscheme Tomorrow-Night
endif

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
" Turn off any bells
set novisualbell
set t_vb=
set gcr=a:blinkon0

" Disable the scrollbars (NERDTree)
set guioptions-=r
set guioptions-=L

" Disable the macvim toolbar
set guioptions-=T

" Macvim settings
if has("gui_macvim")
    set transp=0
    set formatoptions-=tc
    let macvim_hig_shift_movement=1
    set gcr=n:blinkon0
endif

if has("gui_win32") || has("gui_win32s")
    set guifont=Consolas:h12
endif

" Support for yankring
set viminfo+=!

" Keymaps ======================================================================
" Ctrl+s
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Очистить подсветку последнего найденного выражения
"nmap <silent> <F3> :nohlsearch<CR>
"imap <F3> <Esc>:nohlsearch<CR>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" Add a GUID to the current line
imap <c-J>d <C-r>=substitute(system("uuidgen"), '.$', '', 'g')<CR>

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
nnoremap <silent> ,cf :let @* = expand("%:~")<CR>
nnoremap <silent> ,cn :let @* = expand("%:t")<CR>

" Позволяем передвигаться с помощью hjkl в Insert mode зажав <ctrl>
imap <c-h> <c-o>h
imap <c-j> <c-o>j
imap <c-k> <c-o>k
imap <c-l> <c-o>l

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
nnoremap <leader>dd :windo diffthis<CR>

map <C-T> <Esc>:tabnew<CR>
" Return Visual select block after move left/right
vnoremap < <gv
vnoremap > >gv


" Autocmds =====================================================================
" Auto change the directory to the current file I'm working on
" autocmd BufEnter * lcd %:p:h

" Customisations based on filetype
autocmd BufNewFile,BufRead *.rss.*.atom setfiletype xml

" For all text files set 'textwidth' to 80 characters.
autocmd FileType text,txt setlocal tw=80

autocmd BufRead,BufNewFile *.md         set ft=mkd tw=80 ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.markdown   set ft=mkd tw=80 ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.wiki       set ft=wiki tw=80 ts=2 sw=2 expandtab

autocmd Filetype gitcommit set tw=68  spell

autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=htmldjango.html " For SnipMate

au BufNewFile,BufRead *.html set ft=htmldjango.html " For SnipMate and Zen coding
au BufNewFile,BufRead *.html set foldmethod=syntax "

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

" Show also matching html parenthesis
set matchpairs+=<:>

" Python heightlight
let python_highlight_all = 1 " Подвсветка

" Plugins settings =============================================================

" === Vundle ====================================
let g:vundle_default_git_proto = 'git'

" === NERD Tree =================================
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
nnoremap <silent> <C-\> :NERDTreeFind<CR>

" === NERD Tree tabs ============================
" Auto open nerd tree on startup
"let g:nerdtree_tabs_open_on_gui_startup = 1
" Focus in the main content window
let g:nerdtree_tabs_focus_on_files = 1

" === NERD Commenter ============================
map <leader>/ <plug>NERDCommenterToggle<CR>
" === CtrlP ======================================
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|debian$'

" Additional mapping for buffer search
nnoremap <leader>b :CtrlPBuffer<cr>

" === Neocomplcache ==============================
" A beter autocomplete system!
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_smart_case = 1

" default # of completions is 100, that's crazy
let g:neocomplcache_max_list = 5

" words less than 3 letters long aren't worth completing
let g:neocomplcache_auto_completion_start_length = 3

" Map standard <Ctrl-N> completion to <Ctrl-Space>
inoremap <C-Space> <C-n>

let g:neocomplcache_force_overwrite_completefunc = 1

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

" === Syntastic ==================================
" mark syntax errors with :signs
let g:syntastic_enable_signs=1
" automatically jump to the error when saving the file
let g:syntastic_auto_jump=0
" show the error list automatically
let g:syntastic_auto_loc_list=0
" don't care about warnings
let g:syntastic_quiet_warnings=0

" === Tagbar =====================================
let g:tagbar_iconchars = ['▾', '▸']
nnoremap <Leader><Bs> :TagbarToggle<cr>
let g:tagbar_ctags_bin = 'ctags'

" === Python-mode ================================
let g:pymode_syntax = 0
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_always_show_complete_menu = 1
let g:pymode_virtualenv = 1
let g:pymode_lint_cwindow = 0
let g:pymode_indent = 0
let g:pymode_lint_cheker = "pylint,pep8"

"=== vim-jedi ===================================
"let g:jedi#popup_select_first = 0


"=== Vdebug ====================================
"let g:vdebug_option["break_on_open"] = 0

"== Murkdown ==================================
" Markdown files end in .md
au BufRead,BufNewFile *.md set filetype=markdown

" Enable spellchecking for Markdown
au BufRead,BufNewFile *.md setlocal spell

" Automatically wrap at 80 characters for Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

" Ruby Hax {{{
" Prawn files are includes for a pdf rendering library
au BufNewFile,BufRead *.prawn set filetype=ruby

" This is specific to rails apps, but I will not bind it to a particular
" filetype
function! TwoSpace()
    setlocal ts=2
    setlocal sw=2
endfunction
au FileType ruby call TwoSpace()
au FileType coffee call TwoSpace()
au FileType vim call TwoSpace()
au BufNewFile,BufRead *.erb call TwoSpace()

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>
" Use it for ruby projects
map <silent> <Leader>rt :!bundle list --paths=true \| xargs ctags --extra=+f --exclude=.git --exclude=log -R *<CR><CR>
" Open tag in vertical split
" map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"=== ctags =====================================
map <F7> :vsp<CR>:exec("tag ".expand("<cword>"))<CR>

" Ruby debug
let g:ruby_debugger_progname = 'mvim'
let g:ruby_debugger_default_script = 'script/rails s'
