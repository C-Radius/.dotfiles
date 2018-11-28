"Author: Deus Deceit
"Last Mod: 25/10/2018

"Environment variables
let $NVIM_PYTHON_LOG_FILE="/tmp/nvlog"  "Set locaiton for nvlog file.

"ENABLE PYTHON SUPPORT (pacman -S python-neovim python2-neovim)
"-------------------------------------------------------------------------
let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'

"-------------------------------------------------------------------------
"Setting up vimplug - the vim plugin bundler
"-------------------------------------------------------------------------{{{
let iCanHazVimPlug=1

let vim_plug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vim_plug_exists)
    echo "Installing Vimplug.."
    echo ""
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    source ~/.config/nvim/autoload/plug.vim

    let iCanHazVimPlug=0
endif

filetype off

call plug#begin('~/.config/nvim/plugged')

Plug 'fxn/vim-monochrome'
Plug 'rakr/vim-one'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'equalsraf/neovim-gui-shim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet-snippets', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'neomake/neomake'
Plug 'majutsushi/tagbar'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'

call plug#end()

filetype on

if iCanHazVimPlug==0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :PlugInstall
endif
"-------------------------------------------------------------------------}}}

"Set options
"-------------------------------------------------------------------------{{{
set nocompatible
set path+=**
set t_Co=256
filetype on
filetype plugin on

if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
colorscheme one "monochrome
set background=dark


set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list                        "
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set nowrap                      " Wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow
set laststatus=2                "Airline configuration to be visible all the time.
set encoding=utf-8                "Configuration for airline so it's symbols show properly.
set ttimeoutlen=50                "Configuration for airline so that there's no wait between insert and normal mode changing.
set mouse=a
set noswapfile
set hidden
set keymap=greek_utf-8          "This enables greek in insert mode by hitting ctrl + 6
set iminsert=0                  "Make the default layout in insert mode to be english
set imcmdline
set imsearch=-1
set cc=80                        "show 80 column"
set guicursor=
"-------------------------------------------------------------------------}}}

"Keybindings
"-------------------------------------------------------------------------{{{
let mapleader=","
let maplocalleader = "\\"

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"Shortcut to switch buffers
noremap gB :bp<CR>
noremap gb :bn<CR>

"Use Ctrl + c in insert mode to enter normal mode.
inoremap <C-c> <Esc>

"Clear search results
noremap <leader><Space> :noh<cr>:call clearmatches()<cr>

"Neovim terminal keybindings
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <A-Space> <Esc>
tnoremap <A-Space><A-Space> <C-\><C-n>
tnoremap <Esc> <C-\><C-n>
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
"-------------------------------------------------------------------------}}}

"Auto Commands
"-------------------------------------------------------------------------{{{
"Line numbers
"Automatically switch line number style
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"Fold method for individual files
augroup foldmethod_detec
    au BufRead,BufNewFile,BufWrite *.vim set foldmethod=marker
    au BufRead,BufNewFile,BufWrite *.txt set foldmethod=marker
    au BufRead,BufNewFile,BufWrite *.cpp set foldmethod=syntax
    au BufRead,BufNewFile,BufWrite *.py set foldmethod=indent
    au BufRead,BufNewFile,BufWrite *.lua set foldmethod=marker
augroup END

"lsl Configuration
augroup filetypedetect
     au BufRead,BufNewFile *.lsl setfiletype lsl
augroup END

filetype plugin on

autocmd filetype lsl setlocal omnifunc=syntaxcomplete#Complete
autocmd filetype lsl setlocal completeopt=longest,menuone
"-------------------------------------------------------------------------}}}

"Plugin Configuration
"-------------------------------------------------------------------------{{{

    "airline
    "-------------------------------------------------------------------------{{{
    let g:airline_theme='one'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'default'
    let g:airline_powerline_fonts = 1
    "-------------------------------------------------------------------------}}}

    """Use bear to make compile_commands.json
    """eg:
    """~> qmake -spec linux-clang ..
    """~> bear make

    "Neomake
    "-------------------------------------------------------------------------{{{
    " When writing a buffer (no delay).
    call neomake#configure#automake('w')
    " When writing a buffer (no delay), and on normal mode changes (after 750ms).
    call neomake#configure#automake('nw', 750)
    " When reading a buffer (after 1s), and when writing (no delay).
    call neomake#configure#automake('rw', 1000)
    " Full config: when writing or reading a buffer, and on changes in insert and
    " normal mode (after 1s; no delay when writing).
    call neomake#configure#automake('nrwi', 500)

    let g:airline#extensions#neomake#enabled=1
    "-------------------------------------------------------------------------}}}

    "Deoplete
    "-------------------------------------------------------------------------{{{
    let g:deoplete#enable_at_startup = 1

    "Disable preview of documentation and what not
    set completeopt-=preview
    "deoplete-rust
    let g:deoplete#sources#rust#racer_binary="/home/deus/.cargo/bin/racer"
    let g:deoplete#sources#rust#rust_source_path='/home/deus/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
    let g:deoplete#sources#rust#show_duplicates=1

    nmap <buffer> gd <plug>DeopleteRustGoToDefinitionDefault
    nmap <buffer> K  <plug>DeopleteRustShowDocumentation
    "-------------------------------------------------------------------------}}}

    "Tagbar
    "-------------------------------------------------------------------------{{{
    nmap <silent> <Leader>t :TagbarToggle<CR>
    "-------------------------------------------------------------------------}}}

    "NerdTree
    "-------------------------------------------------------------------------{{{
    nnoremap <silent> <Leader>e :NERDTreeToggle<CR>
    autocmd VimEnter *.rs,*.toml NERDTree | wincmd p
    autocmd VimEnter *.rs,*.toml TagbarToggle
    "-------------------------------------------------------------------------}}}

    "Neosnippet
    "-------------------------------------------------------------------------{{{
    " Plugin key-mappings.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    let g:neosnippet#enable_completed_snippet = 1

    imap <C-j>     <Plug>(neosnippet_expand_or_jump)
    smap <C-j>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-j>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    "imap <expr><TAB>
    " \ pumvisible() ? "\<C-n>" :
    " \ neosnippet#expandable_or_jumpable() ?
    " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For conceal markers.
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif
    "-------------------------------------------------------------------------}}}

"-------------------------------------------------------------------------}}}
