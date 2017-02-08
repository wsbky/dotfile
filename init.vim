" ======================= "
" Neovim Setting          "
" ~/.config/nvim/init.vim "
" ======================= "

" !!



" -----雑多-----

" {{{ 

" インデントの設定
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set expandtab

" 行番号を表示
set number

" タイトルを表示
set title

" ルーラーを表示
set ruler

" 入力中のコマンドを表示
set showcmd

" for VimFiler
set modifiable
set write

" vi 互換を使用しない
set nocompatible

" スクロール
set scrolloff=5

" バックスペース
set backspace=indent,eol,start

" match 
set showmatch
set matchtime=3

" mouse mode
set mouse=a

" 折り返し
set wrap

" 補完時
set infercase
set ignorecase
set smartcase

" 検索結果をハイライト
set hlsearch

" 補完強化
set wildmenu

" インクリメンタルサーチ
set incsearch

" 不可視文字を表示
set list

" 保存を確認
set confirm

" use powerline font
let g:Powerline_symbols = 'fancy'


" -----------------------------------------------

" マッピング
inoremap jj <Esc>

nnoremap ; :

inoremap <C-0> <Home>
inoremap <C-\> <End>

" Tab で対応の括弧にジャンプ
nnoremap <C-m><Tab> %
vnoremap <C-m><Tab> %

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
if has('nvim')
  nnoremap <BS> <C-W>h
endif

nnoremap <C-t> :terminal<CR>

nnoremap <C-u><C-f> :<C-u>Unite<Space>file<CR>
nnoremap <C-u><C-b> :<C-u>Unite<Space>buffer<CR>
nnoremap <C-u><C-f><C-b> :<C-u>Unite<Space>file<Space>buffer<CR>
nnoremap <C-u><C-f><C-n> :<C-u>Unite<Space>file<file

nnoremap <F3> :noh<CR>

nnoremap <C-i> :call dein#install()<CR>

nnoremap <C-m><C-a> ggvG$d

" }}} 
" -----------------------------------------------

"Python3 support
let g:python3_host_prog = '/Users/koichi/.pyenv/shims/python3'
" -----プラグイン-----

" {{{


" --dein.vim--
" {{{

" プラグインのインストール場所
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " toml の場所
  let s:toml = '$XDG_CONFIG_HOME/nvim/dein.toml'
  let s:lazy_toml = '$XDG_CONFIG_HOME/nvim/deinlazy.toml'

  " read toml
  call dein#load_toml(s:toml,{'lazy':0})
  call dein#load_toml(s:lazy_toml,{'lazy':1})

  call dein#end()
  call dein#save_state()
endif

" 自動インストール
if dein#check_install()
  call dein#install()
endif

" 自動で削除
function! s:deinClean()
  if len(dein#check_clean())
    call map(dein#check_clean(), 'delete(v:val, "rf")')
  else
    echo '[ERR] no disabled plugins'
  endif
endfunction
command! DeinClean :call s:deinClean()f

filetype plugin indent on
" }}}

"color scheme
let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized

" --deoplete--
" {{{
" Use deoplete.
let g:deoplete#enable_at_startup = 1
" }}}


" --Snippet--
" {{{
" Plugin key-mappings
imap <C-,>     <Plug>(neosnippet_expand_or_jump)
smap <C-,>     <Plug>(neosnippet_expand_or_jump)
xmap <C-,>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" }}}

" --lightline.vim--
" {{{
set laststatus=2
" for power users.
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '' , 'right': '' },
      \ 'subseparator': { 'left': '' , 'right': '' }
      \ }

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? ' '.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0


" let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ 'active': {
"      \   'left': [ [ 'mode', 'paste' ],
"      \             [ 'fugitive', 'filename' ] ]
"      \ },
"     \ 'component_function': {
"      \   'fugitive': 'LightlineFugitive',
"      \   'readonly': 'LightlineReadonly',
"      \   'modified': 'LightlineModified',
"      \   'filename': 'LightlineFilename'
"      \ },
"      \ 'separator': { 'left': '' , 'right': '' },
"      \ 'subseparator': { 'left': '' , 'right': '' }
"      \ }

" function! LightlineModified()
"   if &filetype == "help"
"     return ""
"   elseif &modified
"     return "+"
"   elseif &modifiable
"    return ""
"   else
"     return ""
"   endif
" endfunction
" 
" function! LightlineReadonly()
"   if &filetype == "help"
"     return ""
"   elseif &readonly
"     return ' '
"   else
"     return ""
"   endif
" endfunction
" 
" function! LightlineFugitive()
"   return exists('*fugitive#head') ? fugitive#head() : ''
" endfunction
" 
" function! LightlineFilename()
"   return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
"        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
"        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
" endfunction
" 
" function! LightlineFugitive()
"   if exists("*fugitive#head")
"     let branch = fugitive#head()
"     return branch !=# '' ? ' '.branch : ''
"   endif
"   return ''
" endfunction
" }}}

" --quickrun.vim--
" {{{
let g:quickrun_config = {
\ "_" :{
\   "runner" : "vimproc",
\   "runner/vimproc/updatetime" : 60,
\   "outputter/buffer/split" : ":botright",
\   "outputter/buffer/close_on_empty" : 1
\ },
\ "tex" : {
\   'command' : 'latexmk',
\   "outputter/buffer/split" : ":botright 8sp",
\   'outputter/error/error' : 'quickfix',
\   'hook/cd/directory': '%S:h',
\   'exec': '%c %s'
\ },
\ "watchdogs_checker/_" : {
\   "hook/copen/enable_exist_data" : 1,
\ },
\ "watchdogs_checker/ghc-mod" : {
\   "command" : "ghc-mod",
\ },
\ "haskell/watchdogs_checker" : {
\   "type" : "watchdogs_checker/ghc-mod"
\ },
\}
" vim-watchdogs を呼び出し
call watchdogs#setup(g:quickrun_config)
" \   "exec" : '%c %o --hlintOpt="--language=XmlSyntax" check %s:p',
" }}}
"

" --vim-watchdogs--
"{{{
" 関数に設定を渡す
call watchdogs#setup(g:quickrun_config)
" 書込後にシンタックスチェックする
let g:watchdogs_check_BufWritePost_enable = 1
"}}}



" --unite.vim--
" {{{

" insert モードで開始
let g:unite_enable_start_insert=1
" enable history/yank function
let g:unite_source_history_yank_enable = 1
" Prefix key
nmap <Space> [unite]

" buffer
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" show current directory
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" registers
nnoremap <silent> [unite]r :<C-u>Unite register<CR>
" histories/yanks
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
" 最近開いたファイル
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
" outline
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
" bookmark
nnoremap <silent> [unite]k :<C-u>Unite bookmark<CR>
" add bookmark
nnoremap <silent> [unite]d :<C-u>UniteBookmarkAdd<CR>
" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
nnoremap <silent> [unite]f :VimFiler<CR>

" unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
	" insert モードのときjjでノーマルモードに移動
	imap <buffer> jj <Plug>(unite_insert_leave)
endfunction
" }}}

" python3 plugins
call remote#host#RegisterPlugin('python3', '/home/shougo/.nvim/rplugin/python3/snake.py', [
      \ {'sync': 1, 'name': 'SnakeStart', 'type': 'command', 'opts': {}},
     \ ])
call remote#host#RegisterPlugin('python3', '/home/shougo/work/deoplete.nvim/rplugin/python3/deoplete.py', [
      \ {'sync': 1, 'name': 'DeopleteInitializePython', 'type': 'command', 'opts': {}},
     \ ])
