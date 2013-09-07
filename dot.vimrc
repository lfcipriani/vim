" Header and Notes {
"
"   vi/vim: dot.vimrc
"   based on http://vi-improved.org/vimrc.php
"
" }

set nocompatible               " be iMproved
 filetype off                   " required!

 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

 " let Vundle manage Vundle
 " required! 
 Bundle 'gmarik/vundle'

 " My Bundles here:
 "
 Bundle 'The-NERD-Commenter'
 " original repos on github
 " Bundle 'tpope/vim-fugitive'
 " Bundle 'Lokaltog/vim-easymotion'
 " Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
 " Bundle 'tpope/vim-rails.git'
 " vim-scripts repos
 " Bundle 'L9'
 " Bundle 'FuzzyFinder'
 " non github repos
 " Bundle 'git://git.wincent.com/command-t.git'
 " git repos on your local machine (ie. when working on your own plugin)
 " Bundle 'file:///Users/gmarik/path/to/plugin'
 " ...

 filetype plugin indent on     " required!
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..


" Pathogen {
    " Use pathogen to easily modify the runtime path to include all
    " plugins under the ~/.vim/bundle directory
    " call pathogen#infect()
" }

" General {
    syntax on
    " filetype plugin indent on

    " vi compatible options {
    set cpoptions=aABcefFmqs
    "             |||||||||+-- Set buffer options when entering the buffer
    "             ||||||||+-- When joining lines, leave the cursor between joined lines
    "             |||||||+-- When a new match is created (showmatch) pause for .5
    "             ||||||+-- :write command updates current file name
    "             |||||+-- :read command updates current file name
    "             ||||+-- Automatically add <CR> to the last line when using :@r
    "             |||+-- Searching continues at the end of the match at the cursor position
    "             ||+-- A backslash has no special meaning in mappings
    "             |+-- :write updates alternative file name
    "             +-- :read updates alternative file name
    set cpoptions+=#
    "              |
    "              +-- A count before "D", "o" and "O" has no effect.
    set cpoptions-=n
    "              +-- column for 'number' does not show wrapped text
    " }

    set nobackup                    " [donot] make backup files
    set backupdir=/tmp              " where to put backup files
    set nowb

    set noswapfile                  " do not use swap files (brave mode on!)
    set directory=/tmp              " directory to place swap files in

    set clipboard+=unnamed          " yy, D, p: share OS clipboard
    set encoding=utf-8 nobomb       " BOM often causes trouble
    set fileformats=unix,dos,mac    " support all three, in this order
    set history=300                 " history size
    set modeline                    " modeline on
  " set timeoutlen=5000             " time in ms to complete a mapped key combination
    set writeany                    " write on readonly files

    " New in 7.3 !
    if version >= 703
    "    set autochdir               " always switch to the current file directory, I dont want this
    endif
    if has('persistent_undo')
        set undofile                " keep a permanent undofile (vide :wundo/:rundo)
        set undodir=/tmp
        " if ! isdirectory(&undodir)
        "     call mkdir(&undodir, 'p')
        " endif
    endif

    set linebreak                   " when wrapping, uses chars listed in breakt
    set breakat=\ ^I!@*-+;:,./?     " when wrapping, break at these characters
    set showbreak=…                 " what to show at the start of a wrapped line

    set iskeyword+=48-57,192-255
    set iskeyword+=_,$,@,%,#        " none of these are word dividers

    set showcmd                 " show command line
    set wildmenu                " turn on command line completion wild style
    set wildmode=list:longest   " turn on wild mode huge list
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png,*~,*.lo
                                " ignore these list file extensions

    set grepprg=ack "TODO: fix this or install ack
    set grepformat=%f:%l:%m

    " what to save via :mksession {
    set sessionoptions=blank,buffers,curdir,folds,globals,options,resize,tabpages,winsize
    "                  |     |       |      |     |       |       |      |        +-- size of windows
    "                  |     |       |      |     |       |       |      +-- tabs opened
    "                  |     |       |      |     |       |       +- size of line/columns
    "                  |     |       |      |     |       +-- options set
    "                  |     |       |      |     +-- globals set
    "                  |     |       |      +-- state of folds
    "                  |     |       +-- current dir
    "                  |     +-- hidden/unloaded buffers
    "                  +-- empty windows
    set viminfo='100,f1,<500,:50,@50,/50,h,%
    "           |    |  |    |   |   |   | +-- save/restore buffer list
    "           |    |  |    |   |   |   +-- disable hlsearch
    "           |    |  |    |   |   +-- search-line history
    "           |    |  |    |   +-- input-line history
    "           |    |  |    +-- command line history
    "           |    |  +-- lines saved by each register
    "           |    +-- store file marks
    "           +-- number of files for which marks are kept
    set viminfo='100,f1,<500,:50,@50,/50,h
    " }
" }

" File Explorer {
    let g:netrw_liststyle=3 " Use tree-mode as default view
    " let g:netrw_browse_split=4 " Open file in previous buffer
    " let g:netrw_preview=1 " preview window shown in a vertically split
" }

" Mappings {
    " Tip: D  : command key
    "      D-S: command+shift key

    let mapleader=","

    " http://items.sjbach.com/319/configuring-vim-right
    " http://nvie.com/posts/how-i-boosted-my-vim/
    " See http://stevelosh.com/blog/2010/09/coming-home-to-vim
    " Inspired by http://sphinx.pocoo.org/rest.html#sections
    " http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file

    " edit files
    nmap <leader>ev :tabe $MYVIMRC<CR>

    " switch buffers with control movements
    map <c-k> :bn<cr>
    map <c-j> :bp<cr>

    " identation in visual mode don't loose selection
    vnoremap > ><CR>gv
    vnoremap < <<CR>gv

    " movement improvements
    map <leader>0 ^

    " Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
    nmap <leader>j mz:m+<cr>`z
    nmap <leader>k mz:m-2<cr>`z
    vmap <leader>j :m'>+<cr>`<my`>mzgv`yo`z
    vmap <leader>k :m'<-2<cr>`>my`<mzgv`yo`z
    
    " Insert blank space above or below
    nnoremap <leader>l :set paste<CR>m`o<Esc>``:set nopaste<CR>
    nnoremap <leader>L :set paste<CR>m`O<Esc>``:set nopaste<CR>

    " iPad mappings {
    onoremap kj <Esc>
    inoremap kj <Esc>`^
    " }

" }

" Commands {

    command! W  :w
    command! WW :browse confirm saveas
    command! WQ :wq
    command! Q  :q
    
    command! Rehash     source $MYVIMRC
    command! Helptags   helptags ~/.vim/doc

    command! Color      echo g:colors_name

    " start/stop sharing OS clipboard
    command! Clipon     set clipboard+=unnamed
    command! Clipoff    set clipboard-=unnamed

" }

" Vim-UI {
    set title           " set window name as titlestring
    " set titlestring=%F\ [%R%H%M%w]\ %{v:servername}
    " let &titlestring=expand("%:p")." - ".v:servername

    if has("gui_running")
        auto BufEnter * let &titlestring=expand("%:p")." - ".v:servername
    endif

    " set ruler           " show cursor line/col position
    " set rulerformat=[col:%c\ lin:%-7.(%l/%L%)]\ %P

    set number              " linenumber
    set numberwidth=5       " linenumber width
    "et relativenumber      " relative number

    set cursorline          " horizontal highlight
    set nocursorcolumn      " vertical highlight

    set virtualedit=block   " allow moving past end of line in block selection mode

    set nostartofline       " keep cursor in same column where moving up/down
    set scrolloff=3         " keep 3 lines scrolling up/down
    set sidescrolloff=10    " keep 10 lines scrolling left/right

    set report=0            " report all changes via ':' commands

    set winaltkeys=no       " wak: no ALT keys for menus

    set incsearch           " Highlight dynamically as they are typed.
    set nohlsearch          " Highlight search terms: off on start

    set errorbells          " Bells error messagens
    set visualbell          " no sound bells

    set nolist              " [no]list invisible chars
    set listchars=tab:▸\ ,trail:·,eol:¬,extends:>,precedes:<
    "             |       |       |     |         +-- line befor left margin: <
    "             |       |       |     +-- line beyond right margin: >
    "             |       |       +-- EOF: _
    "             |       +-- trailing spaces: ....
    "             +-- each tab: >----

    "et formatoptions=rq                    " default: tcq vide 'help fo-table'
    set formatoptions=cqrn
    "                 ||||
    "                 |||+-- recognize numbered lists
    "                 ||+--- insert comment leader after <Enter> in Insert mode
    "                 |+---- allow formatting using gq
    "                 +----- auto-wrap comments
" }

" GUI Settings {

    set bg=dark

    map <leader>c1 :colorscheme ir_black3<CR>
    map <leader>c2 :colorscheme torte    <CR>
    map <leader>c3 :colorscheme desert   <CR>
    map <leader>c0 :echo g:colors_name   <CR>

    " Terminal vim theme
    colorscheme torte

    " Gvim theme
    if has("gui_running")
        if filereadable(expand("~/.vim/colors/ir_black3.vim"))
        colorscheme ir_black3
        endif

        set nocursorcolumn
        set mouse=a
        set mousehide

        set guifont=Monaco:h12  " MacVim
        set guiheadroom=5       " nr of pixels subtracter from screen to fit GUI
        set tabpagemax=100      " tpm: max nro of tab windows
        set gtl=%t gtt=%F       " guitablabel/guitabtooltip

        set colorcolumn=+1,+2,+3,+4,+5
        set columns=178
        set lines=44
        set transp=4

        set browsedir=buffer    " open filebrowser on directory of curent buffer
        set paste  " terminal: do the right thing when executing paste

        " Set font according to system
        "   Ref: http://amix.dk/vim/vimrc.html
        " if MySys() == "mac"
        "     set gfn=Menlo:h14
        "     set shell=/bin/bash
        " elseif MySys() == "windows"
        "     set gfn=Bitstream\ Vera\ Sans\ Mono:h10
        " elseif MySys() == "linux"
        "     set gfn=Monospace\ 10
        "     set shell=/bin/bash
        " endif

    endif

    " Terminal has 256 colors
    " if &t_Co >= 256 || has("gui_running")
    "     colorscheme mustang
    " endif

    " Terminal has colors
    " if &t_Co > 2 || has("gui_running")
    "     syntax on
    " endif

" }

" Buffers {
    " Tip:
    "     :e!       ignore changes, restore original file
    "     :bd  [n]  buf del [number n]
    "     :bd! [n]  buf del, discard changes
    "     <C-^>     switch to alternate file

    set hidden                  " hide buffer instead of closing
    "et nohidden                " close buffer always

    " Ref: http://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want/
" }

" Windows {

    set splitbelow          " sb: split new window below current window
    set splitright          " spr: split new window to the right
    set noequalalways       " ea: resize all windows to same size to fit a new one

    " Tip:
    " CTRL-W =   : equal all windows sizes
    " CTRL-W x   : swap split up/down
    "
    " :split #   : open alternate buf down
    " :vsplit #  : open alternate buf right
    "
    " sf[ind] /work/*/dev
    " sf[ind] /work/**/dev

    " Look MA! No arrow keys in Vim!!!
    map <down>  <C-W>j
    map <up>    <C-W>k
    map <left>  <C-W>h
    map <right> <C-W>l

    " }

" Windows Tabs {
    " Tip: :tabs
    "      :tabfirst
    "      :tablast
    "      :tabonly
    "      :tabf[ind]

    " open file under cursor to new tab: /etc/hosts
    map <leader>tf <C-W>gf

    " switch tabs with control movement
    map <c-h> :tabp<cr>
    map <c-l> :tabn<cr>

" }

" Status Line {
    " My status line
    " --------------
     set laststatus=2   " always show statusline

     set statusline=\                               " one blank

"    set statusline+=\ %f\                          " filename
"    set statusline+=%h%m%r                         " flags

     set statusline+=[
     set statusline+=%n:                            " buffer number
     set statusline+=%{strlen(&ft)?&ft:'none'}      " filetype
"    set statusline+=,%{&encoding}                  " encoding
"    set statusline+=,%{&fileformat}                " file format
     set statusline+=]

     set statusline+=\ [%2.(%c%)\ lin:%-7.(%l/%L%)\ %P] " col lin/tot perc

"    set statusline+=\ %f                               " filename
     set statusline+=\ [%t]                             " filename

"    set statusline+=%0                             " break
"    set statusline+=asc:[%3.(%b%)\ %3.(x%B%)]      " current char (ga)
"    set statusline+=\ [%2.(%c%)\ lin:%-7.(%l/%L%)]\ %P
"    set statusline+=\ [col:%2.(%c%)\ lin:%-7.(%l/%L%)]\ %P
"   if has("perl")
"       set statusline+=\ perl
"   endif
"   if has("ruby")
"       set statusline+=\ ruby
"   endif

" }

" Coding Rules {

    set completeopt=menu,preview,longest    " <C-N>/acp: completion popup menu options

    set gdefault            " global search/replace by default

    set showmatch           " show matching brackets
    set matchtime=5         " ms blinking showmatch

    set ignorecase          " case insensitive
    set infercase           " if there are caps adjust auto-completion
    set smartcase           " if there are caps go insensitive

    " set ts=4 sts=4 sw=4 et   sta   nolist - spaces
    " set ts=8 sts=0 sw=8 noet nosta list   - tabs
    set tabstop=4           " real tabs will show 8 spaces
    set softtabstop=4       " how many spaces in a tabstop
    set shiftwidth=4        " sw: indent size
    set expandtab           " no tabs - space in place of tabstops
    set smarttab            " sta: space in place of tabs in a new line

    set autoindent          " ai: pre-req for si
    set copyindent          " ci: copy same character used in previous indent line
    set smartindent         " si: on
    set shiftround          " round indent to shiftwidth

    set backspace=indent,eol,start      " make backspace a more flexible

    set nrformats=alpha,octal,hex   " C-A/C-X: increment/decrement

    " wrap {
    " set textwidth=78        " tw
    set nowrap sidescroll=1         " [no] wrap long lines
    "et whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
    "             | | | | | | | | |
    "             | | | | | | | | +-- "]" Insert and Replace
    "             | | | | | | | +-- "[" Insert and Replace
    "             | | | | | | +-- "~" Normal
    "             | | | | | +-- <Right> Normal and Visual
    "             | | | | +-- <Left> Normal and Visual
    "             | | | +-- "l" Normal and Visual (not recommended)
    "             | | +-- "h" Normal and Visual (not recommended)
    "             | +-- <Space> Normal and Visual
    "             +-- <BS> Normal and Visual
    " }

" }

" Folding {
    set nofoldenable              " Turn on folding
    set foldmethod=indent       " Fold on the marker
    set foldlevel=100           " Don't autofold anything (but I can still fold manually)
" }

" FileTypes {

    " all files {
        " Strip white space
        " autocmd BufWritePre * :call Preserve("%s/\\s\\+$//e")

        " Come back to last position
        autocmd BufReadPost *   if line("'\"") > 0
                              \ && line("'\"") <= line("$") |
                              \    exe "normal! g'\""       |
                              \ endif

        " no extension: treat as txt file
        autocmd BufRead,BufNewFile *  setfiletype txt
    " }

    " Text {
        autocmd BufNewFile,BufRead *.txt setlocal filetype=txt
        autocmd FileType             txt setlocal tw=78 cc=+1,+2,+3,+4,+5 ts=4 sts=4 sw=4 et
        autocmd FileType             txt setlocal fo=cqrnl2
        "                                            ||||||
        "                                            |||||+-- indent as 2nd line of paragraph
        "                                            ||||+--- long line do not break in insert mod
        "                                            |||+---- recognize numbered lists
        "                                            ||+----- insert comment leader after <Enter> in Insert mode
        "                                            |+------ allow formatting using gq
        "                                            +------- auto-wrap comments
        "
        " formatoptions=tcroqn2l
        " help fo-table
    " }

    " Ruby {
        autocmd BufNewFile,BufRead *.rb  setlocal filetype=ruby
        autocmd FileType           ruby  setlocal ts=2 sts=2 sw=2 et nowrap
    " }

    " LogFiles {
        " goto end of file
        autocmd BufReadPost  *.log      normal G
    " }

    " Makefile {
        autocmd BufRead     [Mm]akefile*    setlocal filetype=make
        autocmd FileType    automake,make   setlocal ts=8 sts=0 sw=8 noet nosta list
    " }

    " Programming settings {
    " http://www.mattrope.com/computers/conf/vimrc.html
    " }

    " Mail {
        autocmd BufRead     letter*     set filetype=mail
        autocmd Filetype    mail        set fo-=l autoindent spell
    " }

    " Notes {
        autocmd BufNewFile,BufRead *.notes     set filetype=notes
        autocmd BufNewFile,BufRead *.notes.txt set filetype=notes
    " }

    " git.git/contrib {
    "   autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
    " }

    " Rehash:
    "   autocmd BufWritePost ~/Work/mv_home/dot.vimrc   so ~/.vimrc

" }

" Unicode {
        " Char  CTRL-V+u    i+CTRL-V+digit
        " ¬       ac        U+00AC          not
        " ▸     25b8        U+25B8          black right triangle
        " ☠     2620        U+2620          skull and bones
        " ❤     2764        U+2764          heavy black heart
" }

" Snippets {
    " :0 put =range(1,15)
    " :for in in range(1,15) | put ='192.168.1.'.i | endfor

    " tab to spaces to tab
    command! TabOn   :set noexpandtab|retab!
    command! TabOff  :set expandtab|retab!

    " http://vimcasts.org/episodes/tidying-whitespace/
    function! Preserve(command)
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        execute a:command
        " Clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction

    "nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
    "nmap _= :call Preserve("normal gg=G")<CR>

    "
    "   nmap <leader>id1 <C-R>=strftime("%c")
    "   nmap <leader>ifp :e <C-R>=expand("%:p:h") .'/' <C-R>
    "   nmap <leader>ifp <C-R>=expand("%:p:h") .'/' <C-R>


    " http://github.com/nvie/vimrc/raw/master/vimrc
    " make p in Visual mode replace the selected text with the yank register
    " vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

    " Pull word under cursor into LHS of a substitute (for quick search and
    " replace)
    " nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

    " Strip all trailing whitespace from a file, using ,w
    " nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

    " Run Ack fast (mind the trailing space here, wouldya?)
    " nnoremap <leader>a :Ack

    " Reselect text that was just pasted with ,v
    " nnoremap <leader>v V`]

    " Re-hardwrap paragraphs of text:
    " nnoremap <leader>q gqip

" }

" Plugins {

" }

" Corrections {
    if version >= 703 " Vim 7.x specific colors
        hi CursorColumn   guifg=NONE        guibg=black       gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=BOLD
        hi ColorColumn    guifg=NONE        guibg=black       gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=BOLD
    endif

" }

