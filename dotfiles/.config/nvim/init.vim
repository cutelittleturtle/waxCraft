" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:

if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim/

" Plugins dein declarations {

" path to where to store plugins:
if dein#load_state('~/.vim/bundle')
  call dein#begin('~/.vim/bundle')

  " path to plugin manager:
  call dein#add('~/.vim/bundle/repos/github.com/Shougo/dein.vim/')

  " User Interface {
  call dein#add('bling/vim-bufferline')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('LnL7/vim-nix')
  call dein#add('luochen1990/rainbow')
  call dein#add('airblade/vim-gitgutter') " column sign for git changes
  call dein#add('rhysd/conflict-marker.vim') " conflict markers for vimdiff
  "}

  " Generic tools {
  call dein#add('mileszs/ack.vim') " get ack cmd in vim
  call dein#add('tpope/vim-fugitive') " Git wrapper for vim
  call dein#add('tpope/vim-repeat') " allows better action repeat with .
  call dein#add('tpope/vim-surround') " change surrounding easily cs([
  call dein#add('jiangmiao/auto-pairs') " auto pair
  call dein#add('kien/ctrlp.vim') " Fuzzy file finder
  call dein#add('godlygeek/tabular') " tabularize
  call dein#add('majutsushi/tagbar')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('mbbill/undotree')
  call dein#add('Konfekt/FastFold')
  call dein#add('vim-scripts/restore_view.vim')
  set viewoptions=cursor,slash,unix
  " let g:skipview_files = ['*\.vim']
  call dein#add('easymotion/vim-easymotion')
  "}

  " Autocomplete {
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('ervandew/supertab') " tab handler for better autocompletion

  "call dein#add('Shougo/neoinclude.vim') " include completion framework
  call dein#add('Shougo/neco-vim') " vim completion framework
  call dein#add('Shougo/neco-syntax') " syntax source for neocomplete

  call dein#add('SirVer/ultisnips') " snippets engine handle
  call dein#add('honza/vim-snippets') " those are the snippets

  call dein#add('zchee/deoplete-jedi') " python completion framework
  call dein#add('python-mode/python-mode')
  call dein#add('davidhalter/jedi-vim')

  call dein#add('tell-k/vim-autopep8')
  "}

  call dein#end()
  call dein#save_state()
endif
"}

" Plugins configuration{

" User Interface {
  let g:bufferline_echo = 0 " buffer line at top

  " Airline config
  " see for patching terminal fonts :
  " https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation
  let g:airline_powerline_fonts=1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 1
  function! AirlineInit()
      let g:airline_section_a = airline#section#create(['mode'])
      let g:airline_section_b = airline#section#create_left(['%f'])
      let g:airline_section_c = airline#section#create(['%{getcwd()}'])
      let g:airline_section_x = airline#section#create([])
      let g:airline_section_y = airline#section#create([])
  endfunction
  autocmd VimEnter * call AirlineInit()
  autocmd VimEnter * AirlineRefresh

  let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
" }

  " Ack
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"
  nmap <leader>a :Ack ""<Left>
  nmap <leader>A :Ack <C-r><C-w>

  " Deoplete
  let g:deoplete#enable_at_startup = 1

  " Supartab
  let g:SuperTabMappingForward = '<S-Tab>'
  let g:SuperTabMappingBackward = '<Tab>'

  " Tabular
  map <leader>a :Tabularize /

  " Easymotion {
  let g:EasyMotion_do_mapping = 1
  let g:EasyMotion_smartcase = 1
  " bd for bidirectional :
  map <nowait><leader>f <Plug>(easymotion-bd-w)

  map <nowait><Leader>l <Plug>(easymotion-lineforward)
  map <nowait><Leader>j <Plug>(easymotion-j)
  map <nowait><Leader>k <Plug>(easymotion-k)
  map <nowait><Leader>h <Plug>(easymotion-linebackward)

  " beginning of words :
  map <nowait><leader>z <Plug>(easymotion-w)
  map <nowait><leader>Z <Plug>(easymotion-b)

  " end of words :
  map <nowait><leader>e <Plug>(easymotion-e)
  map <nowait><leader>E <Plug>(easymotion-ge)
  "}

  " Autocomplete
  call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])

  " Fix deoplete & ultisnips problem with <tab> completion :
  let g:UltiSnipsExpandTrigger = "<S-Tab>" " default to <tab> that override tab deoplete completion
  "let g:UltiSnipsListSnippets = "<c-tab>"
  "let g:UltiSnipsJumpForwardTrigger = "<c-j>"
  "let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

  " Python {
  let g:pymode_indent = 1 " pep8 indent
  let g:pymode_folding = 1
  let g:pymode_motion = 1
  " doc
  let g:pymode_doc = 1
  let g:pymode_doc_bind = 'K'
  " syntax
  let g:pymode_syntax = 1
  let g:pymode_syntax_all = 1
  let g:pymode_syntax_slow_sync = 1 " slower syntax sync
  " Python code checking :
  let g:pymode_lint = 1
  let g:pymode_lint_on_write = 1
  let g:pymode_lint_checkers = ['pep8', 'pyflakes'] " pep8 code checker
  let g:pymode_lint_ignore = ["E501", "W0611",] " ignore warning line too long

  " Code completion :
  let g:pymode_rope = 0 " enable rope which is slow
  "let g:pymode_rope_completion = 1 " enable completion
  "let g:pymode_rope_lookup_project = 0 " do not lookup in parent directories which is slow
  "let g:pymode_rope_autoimport = 0

  " use all other features of jedi but completion
  let g:jedi#completions_enabled = 0
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#goto_assignments_command = ''  " dynamically done for ft=python.
  let g:jedi#goto_definitions_command = ''  " dynamically done for ft=python.
  let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
  let g:jedi#smart_auto_mappings = 1
  let g:jedi#auto_close_doc = 1

  " Autopep8
  let g:autopep8_disable_show_diff=1 " disable show diff windows
  let g:autopep8_ignore="E501" " ignore line too long
  nnoremap <leader>p :Autopep8<CR>
  vnoremap <leader>p :Autopep8<CR>
  " }
"}

" User Interface {
filetype plugin indent on
syntax enable
set background=dark
colorscheme solarized

set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
set number " display line number column
set ruler          " Show the cursor position all the time
set cursorline     " Highlight the line of the cursor
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3    " Have some context around the current line always on screen
set virtualedit=onemore             " Allow for cursor beyond last character
set hidden         " Allow backgrounding buffers without writin them, and remember marks/undo for backgrounded buffers
set foldenable                  " Auto fold code
set splitright " split at the right of current buffer (left default behaviour)
set splitbelow " split at the below of current buffer (top default behaviour)

" columns
set colorcolumn=80 " Show vertical bar at column 80
sign define dummy
execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
highlight SignColumn        cterm=none ctermbg=none
highlight SignifySignAdd    cterm=bold ctermbg=none ctermfg=64
highlight SignifySignDelete cterm=none ctermbg=none ctermfg=136
highlight SignifySignChange cterm=none ctermbg=none ctermfg=124
highlight Folded                       ctermbg=none
highlight foldcolumn                   ctermbg=none ctermfg=none

" cmdline
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

" Whitespace
set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set list " show the following:
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" Backup
" Initialize directories {
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories, add the following to
    " your .vimrc.before.local file:
    "   let g:spf13_consolidated_directory = <full path to desired directory>
    "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
    if exists('g:spf13_consolidated_directory')
        let common_dir = g:spf13_consolidated_directory . prefix
    else
        let common_dir = parent . '/.' . prefix
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()
" }

set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set backup                  " Backups are nice ...
if has('persistent_undo')
  set undofile                " So is persistent undo ...
  set undolevels=1000         " Maximum number of changes that can be undone
  set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

" Searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

" Clipboard
if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

" Autocmd
if has("autocmd")
  " Delete empty space from the end of lines on every save
  au BufWritePre * :%s/\s\+$//e

  " Make sure all markdown files have the correct filetype set and setup
  " wrapping and spell check
  function! s:setupWrappingAndSpellcheck()
      set wrap
      set wrapmargin=2
      set textwidth=80
      set spell
  endfunction
  au BufRead,BufNewFile *.{md,md.erb,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrappingAndSpellcheck()

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " Python
  au BufRead,BufNewFile *.py setlocal filetype=python
  au BufRead,BufNewFile *.py setlocal shiftwidth=4
  au BufRead,BufNewFile *.py setlocal tabstop=4
  au BufRead,BufNewFile *.py setlocal softtabstop=4
  au BufRead,BufNewFile *.py setlocal textwidth=79

  " other
  au BufNewFile,BufRead *.cuf set filetype=fortran
  au BufNewFile,BufRead *.nml set filetype=fortran
  au BufNewFile,BufRead *.namelist set filetype=fortran
  au BufNewFile,BufRead *.nix set filetype=nix
  au BufNewFile,BufRead *.sh set filetype=sh
  au BufNewFile,BufRead *.vimrc* set filetype=vim
  au BufNewFile,BufRead *.vim set filetype=vim
  au BufNewFile,BufRead *.cmake set filetype=cmake
  au BufNewFile,BufRead CMakeLists.txt set filetype=cmake

  " Git
  au Filetype gitcommit setlocal spell textwidth=72

  " Switch to the current file directory when a new buffer is opened
  au BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

endif

"}

" Behaviour fixes {

" Times choices:
set ttimeoutlen=10
set timeoutlen=300

map <nowait> <Esc> <C-c>
" quick escape from command line with esc :
cmap <nowait> <Esc> <C-c>

" Nvim Terminal
" Make escape work in the Neovim terminal.
tnoremap <Esc> <C-\><C-n>

" Unmapping F1 calling help in vim :
map <F1> <nop>
map <A-F1> <nop>

" Avoid vim history cmd to pop up with q:
nnoremap q: <Nop>
" Avoid qq recording
nnoremap q <Nop>

" }

" Key (re)Mappings {
let mapleader=","

" clear the search highlight
nnoremap <leader>; :nohl<cr>

" select all of current paragraph with enter:
nnoremap <return> vip

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Buffers {
" --> About buffers switch
" Little snippet to get all alt key mapping functional :
" works for alt-a .. alt-z
for i in range(97,122)
  let c = nr2char(i)
  exec "map \e".c." <A-".c.">"
  exec "map! \e".c." <A-".c.">"
endfor

map <nowait> <A-a> :bp<cr>
map <nowait> <A-z> :bn<cr>
map <nowait> <A-e> :cn<cr>

" buffer delete without closing windows :
nmap <silent> <A-r> :bp\|bd #<CR>
"}

" Folding binds : {
" --> About folding open and close :
nnoremap <Space> za
vnoremap <Space> za

" --> Folding : closing all opened foldings :
nnoremap wm zm
vnoremap wm zm

" --> Folding : movements (next / prec) :
nnoremap wj zj
vnoremap wj zj
nnoremap wk zk
vnoremap wk zk
" }

" qwerty --> azerty beginning of the next word eased by this bind :
" the <nowait> prevent a delay when typing z (for za for example)
noremap <nowait> z w
noremap <nowait> Z b
noremap <nowait> e e
noremap <nowait> E ge


" copy to clipboard :
vnoremap <Leader>y "+y

" source config
if !exists('*ActualizeInit')
  function! ActualizeInit()
    call dein#recache_runtimepath()
    source ${HOME}/.config/nvim/init.vim
  endfunction
endif
map <F12> :call ActualizeInit()<cr>

" Profile vim {
function! StartProfiling()
  execute ":profile start profile.log"
  execute ":profile func *"
  execute ":profile file *"
  let b:profiling=1
endfunction

function! EndProfiling()
  execute ":profile pause"
  let b:profiling=0
endfunction

let b:profiling=0
function! ToggleProfiling()
  if b:profiling == 0
    call StartProfiling()
  else
    call EndProfiling()
  endif
endfunction
"}
map <F10> :call ToggleProfiling()<cr>

" Settings for python-mode
"map <Leader>b oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
map <Leader>i ofrom IPython import embed; embed() # Enter Ipython<C-c>
"}


" Function to write in a vim buffer the output of vim commands :
"   - Execute 'cmd' while redirecting output.
"   - Delete all lines that do not match regex 'filter' (if not empty).
"   - Delete any blank lines.
"   - Delete '<whitespace><number>:<whitespace>' from start of each line.
"   - Display result in a scratch buffer.
function! s:Filter_lines(cmd, filter)
  let save_more = &more
  set nomore
  redir => lines
  silent execute a:cmd
  redir END
  let &more = save_more
  new
  setlocal buftype=nofile bufhidden=hide noswapfile
  put =lines
  g/^\s*$/d
  %s/^\s*\d\+:\s*//e
  if !empty(a:filter)
    execute 'v/' . a:filter . '/d'
  endif
  0
endfunction
silent command! -nargs=? Scriptnames call s:Filter_lines('scriptnames', <q-args>)<cr>
silent command! -nargs=? Syntaxlist call s:Filter_lines('syntax list', <q-args>)<cr>
silent command! -nargs=? VerboseHighlight call s:Filter_lines('verbose highlight', <q-args>)<cr>
silent command! -nargs=? CurrentHighlight call s:Filter_lines('highlight', <q-args>)<cr>
silent command! -nargs=? GetPluginsList call s:Filter_lines('PluginList', <q-args>)<cr>

set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction
