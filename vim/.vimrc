" vim plugin manager
runtime vim-pathogen/autoload/pathogen.vim

if has('nvim')
    execute pathogen#infect('bundle/{}', 'bundle.nvim/{}')

    " deoplete config
    let g:deoplete#enable_at_startup=1
    let g:deoplete#enable_smart_case=1
    let g:deoplete#auto_complete_start_length=1
    let g:deoplete#sources#jedi#show_docstring=1
    autocmd InsertLeave,CompleteDone * if pumvisible()==0 | pclose | endif
    inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
    let g:tern_request_timeout=1
    let g:tern#command=["tern"]
    let g:tern#arguments=["--persistent"]
    if has('unix')
        if has('mac')
            let g:deoplete#sources#clang#libclang_path=
                \'/usr/local/Cellar/llvm/HEAD/lib/libclang.dylib'
            let g:deoplete#sources#clang#clang_header=
                \'/usr/local/Cellar/llvm/HEAD/lib/clang'
        else
            let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
            let g:deoplete#sources#clang#clang_header='/usr/lib/clang/'
        endif
    endif

    " neomake config
    let g:neomake_verbose=0
    autocmd! BufWritePost,BufEnter * Neomake
else
    execute pathogen#infect('bundle/{}', 'bundle.vim/{}')

    " ycm config
    let g:ycm_collect_identifiers_from_tags_files=1
    let g:ycm_confirm_extra_conf=0
    let g:ycm_global_ycm_extra_conf=
        \'~/.vim/bundle.vim/YouCompleteMe/third_party/
        \ycmd/cpp/ycm/.ycm_extra_conf.py'
    let g:ycm_extra_conf_vim_data=['&filetype']
    let g:ycm_show_diagnostics_ui=0

    " syntastic config
    let g:syntastic_lua_checkers=["luac", "luacheck"]
    let g:syntastic_lua_luacheck_args="--no-unused-args"

    " modernize behavior
    let g:netrw_liststyle=3
    set backspace=2
    set clipboard=autoselect,exclude:.*
endif

" plugin settings
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme=substitute($COLORSCHEME, "-", "_", "")
let g:airline#extensions#tabline#enabled=1
let g:airline_section_z=airline#section#create(['%3p%% ',
    \ g:airline_symbols.linenr, '%3l:%3c'])

" plugin bindings
let g:fzf_action={'ctrl-s': 'split', 'ctrl-v': 'vsplit'}

" filetype settings
set shiftround expandtab softtabstop=4 tabstop=4 shiftwidth=4
autocmd FileType make,gitconfig setlocal noexpandtab
autocmd FileType html
    \ setlocal softtabstop=2 | setlocal tabstop=2 | setlocal shiftwidth=2
autocmd FileType lua setlocal iskeyword+=:
autocmd FileType markdown,mkd,md,tex,text setlocal spell spelllang=en_us

" vim bindings
let mapleader = "\<Space>"
set pastetoggle=<F2>
nnoremap <silent> Q :cquit<CR>
nnoremap <silent> <Leader>x :qa<CR>
nnoremap <silent> <Leader>r :set readonly!<CR>
nnoremap <silent> <Leader>n :set relativenumber!<CR>
nnoremap <silent> <Leader>g :Goyo<CR>
nnoremap <silent> <Leader>c :q<CR>
nnoremap <silent> <Leader>o :GFiles<CR>
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>q :bp\|bd #<CR>
nnoremap <silent> gb :<C-U>call SwitchToBuffer()<CR>
nnoremap ' :<C-u>marks<CR>:normal! `
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
nnoremap <silent> <S-l> :bnext<CR>
nnoremap <silent> <S-h> :bprev<CR>
inoremap jk <Esc>
function! SwitchToBuffer()
  if v:count > 0
    exec v:count . "b"
    return
  endif
  :b #
endfunction

" vim settings
set timeoutlen=420
set laststatus=2 " always display status lines
set tags=./tags;/ " ctags search up to root
set hidden " allow switching buffers without saving
set wildmenu wildmode=list:longest,list:full wildignore=
    \.git,*.swp,*/tmp/*,*.so,*.swp,*.zip,*.o,*.a,
    \*.pyc,*.class,*.jar,*/node_modules/*,
    \*/vendor/* " bash-like command completion
set incsearch " incremental search
set clipboard=unnamed " use system keyboard

" A E S T H E T I C settings
set background=dark
let base16colorspace=256
colorscheme $COLORSCHEME
let g:rainbow_active=1
let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['darkblue', 'darkyellow', 'darkcyan', 'darkmagenta'],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold']
\}
set nowrap
set relativenumber number
set foldmethod=indent
autocmd BufWinEnter * call matchadd('ColorColumn', '\(\%80v\|\%100v\)', 100)
set listchars=tab:▸\ ,trail:·
set list
set modeline modelines=5
filetype plugin indent on
syntax on

" performance
set lazyredraw
set synmaxcol=128
syntax sync minlines=256
