let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'
"let g:node_host_prog = $HOME.'/.nvm/versions/node/v16.0.0/bin/neovim-node-host'

" vim plugin manager
runtime vim-pathogen/autoload/pathogen.vim

if has('nvim')
    execute pathogen#infect('bundle/{}', 'bundle.nvim/{}')

    " deoplete config
    let g:deoplete#enable_at_startup=1
    let g:deoplete#enable_smart_case=1
    let g:deoplete#sources#jedi#show_docstring=1
    call deoplete#custom#source('emoji', 'filetypes',
        \ ['markdown', 'gitcommit', 'rst', 'text', 'pandoc'])
    " autocmd InsertLeave,CompleteDone * if pumvisible()==0 | pclose | endif
    inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
    let g:tern_request_timeout=1
    let g:tern#command=["tern"]
    let g:tern#arguments=["--persistent"]
    if has('unix')
        if !empty(glob('/usr/local/Cellar/llvm/HEAD/lib/libclang.dylib'))
            let g:deoplete#sources#clang#libclang_path=
                \'/usr/local/Cellar/llvm/HEAD/lib/libclang.dylib'
        elseif !empty(glob('/usr/lib/libclang.so'))
            let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
        elseif !empty(glob('/usr/lib64/llvm/libclang.so'))
            let g:deoplete#sources#clang#libclang_path='/usr/lib64/llvm/libclang.so'
        endif

        if !empty(glob('/usr/local/Cellar/llvm/HEAD/lib/clang'))
            let g:deoplete#sources#clang#clang_header=
                \'/usr/local/Cellar/llvm/HEAD/lib/clang'
        elseif !empty(glob('/usr/lib/clang'))
            let g:deoplete#sources#clang#clang_header='/usr/lib/clang/'
        endif
    endif

    " neomake config
    let g:neomake_verbose=0
    let g:neomake_warning_sign={'text': '!'}  " avoid unicode for old mosh
    let g:neomake_error_sign={'text': 'x'}
    let g:neomake_info_sign={'text': 'i'}
    if executable('clang-check')
        let g:neomake_c_enabled_makers = ['clangcheck']
        let g:neomake_cpp_enabled_makers = ['clangcheck']
    endif
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
endif

" plugin settings
let g:airline_powerline_fonts=1
let g:airline_theme=split(substitute($COLORSCHEME, "-", "_", ""), "-")[0]
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#filetypes = '\vhelp|markdown|rst|org|text|pandoc'
let g:airline_section_z=airline#section#create(['%3p%% ',
    \ g:airline_symbols.linenr, '%3l:%3c'])

" plugin bindings
let g:fzf_action={'ctrl-s': 'split', 'ctrl-v': 'vsplit'}

" filetype settings
set shiftround expandtab softtabstop=4 tabstop=4 shiftwidth=4
autocmd FileType make,gitconfig setlocal noexpandtab
autocmd FileType html,javascript,typescript,typescript.tsx
    \ setlocal softtabstop=2 | setlocal tabstop=2 | setlocal shiftwidth=2
autocmd FileType lua setlocal iskeyword+=:
autocmd FileType markdown,mkd,md,tex,text setlocal spell spelllang=en_us
autocmd FileType qf set nobuflisted
autocmd WinEnter * if &previewwindow | set nobuflisted | endif

" vim bindings
let mapleader = "\<Space>"
set pastetoggle=<F2>
nnoremap <silent> Q :cquit<CR>
nnoremap <silent> <Leader>x :qa<CR>
nnoremap <silent> <Leader>f :OverCommandLine<CR>%s/
nnoremap <silent> <Leader>r :let buf=bufnr('%')<CR>:bufdo e<CR>:syntax on<CR>:execute ":buffer ". buf<CR>
nnoremap <silent> <Leader>n :set relativenumber!<CR>
nnoremap <silent> <Leader>g :Goyo<CR>
nnoremap <silent> <Leader>pp :Pandoc! --css=~/pandoc-templates/marked/github.css<CR>
nnoremap <silent> <Leader>c :q<CR>
nnoremap <silent> <Leader>o :GFiles<CR>
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>q :bp\|bd #<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>t :BTags<CR>
nnoremap ' :<C-u>marks<CR>:normal! `
nnoremap <silent> <C-L> :nohlsearch<CR>:mode<CR><C-L>
inoremap jk <Esc>
cnoreabbrev emojify %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

" application settings
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

" vim settings
set timeoutlen=420
set laststatus=2 " always display status lines
set hidden " allow switching buffers without saving
set wildmenu wildmode=list:longest,list:full wildignore=
    \.git,*.swp,*/tmp/*,*.so,*.swp,*.zip,*.o,*.a,
    \*.pyc,*.class,*.jar,*/node_modules/*,
    \*/vendor/* " bash-like command completion
set incsearch " incremental search
set tags=./tags;,tags;

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
set secure modeline modelines=5
filetype plugin indent on
syntax on

" performance
set lazyredraw
set synmaxcol=128
syntax sync minlines=256
