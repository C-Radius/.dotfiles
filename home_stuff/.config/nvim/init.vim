
"
"   ____      ____           _ _
"  / ___|    |  _ \ __ _  __| (_)_   _ ___
" | |   _____| |_) / _` |/ _` | | | | / __|
" | |__|_____|  _ < (_| | (_| | | |_| \__ \
"  \____|    |_| \_\__,_|\__,_|_|\__,_|___/
"
"Author: C-Radius
"Last Mod: 22/05/2020

"Environment variables
let g:polyglot_disabled = ['markdown']
let $NVIM_PYTHON_LOG_FILE="/tmp/nvlog"  "Set locaiton for nvlog file.

"ENABLE PYTHON SUPPORT (pacman -S python-neovim python2-neovim)
"-------------------------------------------------------------------------
if !has('win32')
    let g:python_host_prog='/usr/bin/python2'
    let g:python3_host_prog='/usr/bin/python3'
endif
"-------------------------------------------------------------------------
"Setting up vimplug - the vim plugin bundler
"-------------------------------------------------------------------------{{{
let iCanHazVimPlug=1

if has('win32')
    let vim_plug_exists=expand('~/AppData/Local/nvim/autoload/plug.vim')
else
    let vim_plug_exists=expand('~/.config/nvim/autoload/plug.vim')
endif

if !filereadable(vim_plug_exists)
    echo "Installing Vimplug.."
    echo ""
    if has('win32')
        :exe "!curl -fLo ". $HOME . "/AppData/Local/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        :exe "source " . $HOME . "/AppData/Local/nvim/autoload/plug.vim"
    else
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        source ~/.config/nvim/autoload/plug.vim
    endif

    let iCanHazVimPlug=0
endif
filetype off

if has('win32')
    call plug#begin('~/AppData/Local/nvim/plugged')
else
    call plug#begin('~/.config/nvim/plugged')
endif

Plug 'mattn/webapi-vim'
Plug 'dylanaraps/wal.vim'
Plug 'ap/vim-css-color'
Plug 'cloudhead/neovim-fuzzy'
Plug 'C-Radius/vim-one'
Plug 'vim-airline/vim-airline'
Plug 'KabbAmine/vCoolor.vim'
Plug 'jiangmiao/auto-pairs' "Let's see how life is without auto pairs
Plug 'cohama/lexima.vim' "Let's see how life is without auto pairs
Plug 'machakann/vim-sandwich'
Plug 'easymotion/vim-easymotion'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'ap/vim-css-color'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'gglanzani/ultisnips-snippets'
Plug 'neomake/neomake'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'rafi/awesome-vim-colorschemes'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'cespare/vim-toml'
"Plug 'sakhnik/nvim-gdb'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc-highlight'
Plug 'sharkdp/fd'
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim'

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

let g:one_allow_italics = 1
set background=dark
colorscheme one

let g:airline_theme='wal'
"Settings parameters for coc-neovim
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes
"---------------------------------

"General
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms set winminheight=0              " Windows can be 0 line high
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
set ts=4
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow
set laststatus=1                "Airline configuration to be visible all the time.
set encoding=utf-8              "Configuration for airline so it's symbols show properly.
set ttimeoutlen=50              "Configuration for airline so that there's no wait between insert and normal mode changing.
set mouse=a
set noswapfile
set hidden
set keymap=greek_utf-8          "This enables greek in insert mode by hitting ctrl + 6
set iminsert=0                  "Make the default layout in insert mode to be english
set imcmdline
set imsearch=-1
"set cc=80                        "show 80 column"
set guicursor=
"-------------------------------------------------------------------------}}}
"Keybindings
"-------------------------------------------------------------------------{{{
let mapleader=","


nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"Shortcut to switch buffers
noremap bn :bn<CR>
noremap bp :bp<CR>

"Use Ctrl + c in insert mode to enter normal mode.
inoremap <C-c> <Esc>
inoremap jj <Esc>

"Clear search results
noremap <leader><Space> :noh<cr>:call clearmatches()<cr>

"Run neomake
noremap <leader>n :Neomake<cr>

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
    "au BufRead,BufNewFile,BufWrite *.vim set foldmethod=marker
    "au BufRead,BufNewFile,BufWrite *.txt set foldmethod=marker
    "au BufRead,BufNewFile,BufWrite *.cpp set foldmethod=syntax
    "au BufRead,BufNewFile,BufWrite *.py set foldmethod=indent
    "au BufRead,BufNewFile,BufWrite *.lua set foldmethod=marker
    "au BufRead,BufNewFile,BufWrite *.rs set foldmethod=syntax
augroup END

"lsl Configuration
augroup filetypedetect
    au BufRead,BufNewFile *.lsl setfiletype lsl
    au BufRead,BufNewFile *.lsl set cindent
augroup END

filetype plugin on

autocmd filetype lsl setlocal omnifunc=syntaxcomplete#Complete
autocmd filetype lsl setlocal completeopt=longest,menuone
"-------------------------------------------------------------------------}}}

"Plugin Configuration
"-------------------------------------------------------------------------{{{

"Disable preview of documentation and what not
set completeopt-=preview
"-------------------------------------------------------------------------}}}

"NerdTree
"-------------------------------------------------------------------------{{{
let g:NERDTreeWinPos = "right"
augroup NerdTree
    autocmd!
    autocmd FileType nerdtree setlocal norelativenumber | setlocal nonumber
augroup end 
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
"autocmd VimEnter * NERDTree | wincmd p
"autocmd VimEnter *.rs,*.toml NERDTree | wincmd p
"autocmd VimEnter *.rs,*.toml TagbarToggle
"-------------------------------------------------------------------------}}}

"Undotree
"-------------------------------------------------------------------------{{{
nnoremap <leader>u :UndotreeToggle<CR>
"-------------------------------------------------------------------------}}}

"Coc.nvim configuration.
"-------------------------------------------------------------------------{{{
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


"Telescope------------------------------------------------------------------
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
