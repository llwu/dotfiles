" import plugins
call plug#begin('~/.vim/bundle')
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'luochen1990/rainbow'
Plug 'chriskempson/base16-vim'
if has('nvim')
    Plug 'Shougo/deoplete.nvim'
    Plug 'zchee/deoplete-jedi'
    Plug 'zchee/deoplete-clang'
    Plug 'ternjs/tern_for_vim'
    Plug 'carlitux/deoplete-ternjs'
    Plug 'neomake/neomake'
    Plug 'Shougo/neoinclude.vim'
else
    Plug 'Valloric/YouCompleteMe'
    Plug 'scrooloose/syntastic'
endif
call plug#end()

if has('nvim')
    " deoplete config
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#auto_complete_start_length = 1
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
    let g:tern_request_timeout = 1
    let g:tern#command = ["tern"]
    let g:tern#arguments = ["--persistent"]
    if has('unix')
        if has('mac')
            let g:deoplete#sources#clang#libclang_path='/usr/local/lib/libclang.dylib'
            let g:deoplete#sources#clang#clang_header='/usr/local/lib/clang/'
        else
            let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
            let g:deoplete#sources#clang#clang_header='/usr/lib/clang/'
        endif
    endif
    " neomake config
    let g:neomake_verbose = 0
    autocmd! BufWritePost,BufEnter * Neomake
else
    " ycm config
    let g:ycm_collect_identifiers_from_tags_files=1
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
    let g:ycm_extra_conf_vim_data = ['&filetype']
    let g:ycm_show_diagnostics_ui = 0
    " syntastic config
    let g:syntastic_lua_checkers = ["luac", "luacheck"]
    let g:syntastic_lua_luacheck_args = "--no-unused-args"
    " get modern
    let g:netrw_liststyle=3
    set backspace=2
    set clipboard=autoselect,exclude:.*
endif

" vim-airline config
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme = 'sol'
let g:airline#extensions#tabline#enabled=1
let g:airline_section_z=airline#section#create(['%3p%% ', g:airline_symbols.linenr, '%3l:%3c'])

" ctags config
set tags=./tags;/

" easymotion config
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1

" use fzf like ctrl+p
let g:fzf_action = {'ctrl-s': 'split', 'ctrl-v': 'vsplit'}
nnoremap <C-p> :GFiles<CR>

" per filetype config
set shiftround expandtab softtabstop=4 tabstop=4 shiftwidth=4
autocmd FileType make setlocal noexpandtab
autocmd FileType html,lua setlocal softtabstop=2|setlocal tabstop=2|setlocal shiftwidth=2|setlocal iskeyword+=:

" buffer navigation
set hidden
cnoreabbrev <silent> wq w<bar>bd
cnoreabbrev <silent> q bd
nnoremap <silent> <tab> :bnext<CR>
nnoremap <silent> <s-tab> :bprev<CR>

" copypasta setup
set clipboard+=unnamedplus
set pastetoggle=<F2>

" search behavior
set incsearch
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" vim bash-like command completion
set wildmenu wildmode=list:longest,list:full wildignore=.git,*.swp,*/tmp/*,*.so,*.swp,*.zip,*.o,*.a,*.pyc,*.class,*.jar,*/node_modules/*,*/vendor/*

" A E S T H E T I C
set background=dark
let base16colorspace=256
colorscheme $COLORSCHEME
let g:rainbow_active=1
set nowrap
set nu
call matchadd('ColorColumn', '\(\%80v\|\%100v\)', 100)
set listchars=tab:▸\ ,trail:·
set list
set modeline modelines=5
filetype plugin indent on
syntax on
