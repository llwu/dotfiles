" vim plugin manager
runtime vim-pathogen/autoload/pathogen.vim

if has('nvim')
    execute pathogen#infect('bundle/{}', 'bundle.nvim/{}')

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
    execute pathogen#infect('bundle/{}', 'bundle.vim/{}')

    " ycm config
    let g:ycm_collect_identifiers_from_tags_files=1
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle.vim/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
    let g:ycm_extra_conf_vim_data = ['&filetype']
    let g:ycm_show_diagnostics_ui = 0

    " syntastic config
    let g:syntastic_lua_checkers = ["luac", "luacheck"]
    let g:syntastic_lua_luacheck_args = "--no-unused-args"

    " modern behavior
    let g:netrw_liststyle=3
    set backspace=2
    set clipboard=autoselect,exclude:.*
endif

" vim-airline style
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme = substitute($COLORSCHEME, "-", "_", "")
let g:airline#extensions#tabline#enabled=1
let g:airline_section_z=airline#section#create(['%3p%% ', g:airline_symbols.linenr, '%3l:%3c'])

" ctags search up to root
set tags=./tags;/

" use fzf like ctrl+p
let g:fzf_action = {'ctrl-s': 'split', 'ctrl-v': 'vsplit'}
nnoremap <C-p> :GFiles<CR>

" per filetype style
set shiftround expandtab softtabstop=4 tabstop=4 shiftwidth=4
autocmd FileType make setlocal noexpandtab
autocmd FileType html
    \ setlocal softtabstop=2 | setlocal tabstop=2 | setlocal shiftwidth=2
autocmd FileType lua setlocal iskeyword+=:
autocmd FileType markdown,mkd,md,text,tex,plaintex
    \ set spell spelllang=en_us | Goyo | call pencil#init()

" buffer navigation
set hidden
cnoreabbrev <silent> wq w<bar>bd
cnoreabbrev <silent> q bd
nnoremap <silent> <tab> :bnext<CR>
nnoremap <silent> <s-tab> :bprev<CR>

" clipboard integration
set clipboard^=unnamed,unnamedplus
set pastetoggle=<F2>

" search behavior
set incsearch
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" bash-like command completion
set wildmenu wildmode=list:longest,list:full wildignore=.git,*.swp,*/tmp/*,*.so,*.swp,*.zip,*.o,*.a,*.pyc,*.class,*.jar,*/node_modules/*,*/vendor/*

" A E S T H E T I C
set background=dark
let base16colorspace=256
colorscheme $COLORSCHEME
let g:rainbow_active=1
set nowrap
set relativenumber number
call matchadd('ColorColumn', '\(\%80v\|\%100v\)', 100)
set listchars=tab:▸\ ,trail:·
set list
set modeline modelines=5
filetype plugin indent on
syntax on
