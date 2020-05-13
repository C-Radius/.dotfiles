
"
"   ____      ____           _ _
"  / ___|    |  _ \ __ _  __| (_)_   _ ___
" | |   _____| |_) / _` |/ _` | | | | / __|
" | |__|_____|  _ < (_| | (_| | | |_| \__ \
"  \____|    |_| \_\__,_|\__,_|_|\__,_|___/
"
"Author: C-Radius
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
Plug 'ap/vim-css-color'
Plug 'cloudhead/neovim-fuzzy'
Plug 'C-Radius/vim-one'
Plug 'KabbAmine/vCoolor.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'Shougo/denite.nvim'
Plug 'rafi/awesome-vim-colorschemes'

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

set background=dark " for the dark version
let g:one_allow_italics = 1
" set background=light " for the light version
colorscheme one

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
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
"set cc=80                        "show 80 column"
set guicursor=


"-------------------------------------------------------------------------}}}

"Keybindings
"-------------------------------------------------------------------------{{{
let mapleader=","
let maplocalleader = "\\"

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


"Disable preview of documentation and what not
set completeopt-=preview
"-------------------------------------------------------------------------}}}

"NerdTree
"-------------------------------------------------------------------------{{{
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>
"autocmd VimEnter * NERDTree | wincmd p
"autocmd VimEnter *.rs,*.toml NERDTree | wincmd p
"autocmd VimEnter *.rs,*.toml TagbarToggle
"-------------------------------------------------------------------------}}}

"Undotree
"-------------------------------------------------------------------------{{{
nnoremap <Leader>u :UndotreeToggle<CR>
"-------------------------------------------------------------------------}}}

let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_tranparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>
hi Normal guibg=NONE ctermbg=NONE


"Coc.nvim sample config skeleton
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
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

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"neovim-fuzzy
nnoremap <C-p> :FuzzyOpen<CR>
"Denite
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
                \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
                \ denite#do_map('toggle_select').'j'
endfunction

let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.4

" Change denite default options
call denite#custom#option('default', {
            \ 'split': 'floating',
            \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
            \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
            \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
            \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
            \ })
" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <C-o>
                \ <Plug>(denite_filter_quit)
    inoremap <silent><buffer><expr> <Esc>
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> <Esc>
                \ denite#do_map('quit')
    inoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    inoremap <silent><buffer><expr> <C-t>
                \ denite#do_map('do_action', 'tabopen')
    inoremap <silent><buffer><expr> <C-v>
                \ denite#do_map('do_action', 'vsplit')
    inoremap <silent><buffer><expr> <C-h>
                \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> <Esc>
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> d
                \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <C-o>
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <C-t>
                \ denite#do_map('do_action', 'tabopen')
    nnoremap <silent><buffer><expr> <C-v>
                \ denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> <C-h>
                \ denite#do_map('do_action', 'split')
endfunction

