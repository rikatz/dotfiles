" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Using plug -> https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'SirVer/ultisnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/tagbar' " This needs exuberant-ctags to be installed
Plug 'vim-airline/vim-airline' " The bars
Plug 'vim-airline/vim-airline-themes'
Plug 'frazrepo/vim-rainbow' " Brackets code
Plug 'sonph/onehalf', { 'rtp': 'vim' } "My theme
"Plug 'scrooloose/syntastic'
Plug 'jiangmiao/auto-pairs' " Auto pair for {. [, etc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" For SML things
Plug 'jez/vim-better-sml'
call plug#end()


"NETRW NAVIGATE WITH CONTROL+W P
let g:netrw_banner = 0
let g:netrw_liststyle = 3 "Tree mode
let g:netrw_browse_split = 3 " Open new files in a new tab
let g:netrw_altv = 1
let g:netrw_winsize = 15

function! VexploreToggle()
  if exists("g:netrw_buffer") && bufexists(g:netrw_buffer)
        exe "bd".g:netrw_buffer | unlet g:netrw_buffer
    else
        Vexplore | let g:netrw_buffer=bufnr("%")
  endif
endfunction

nnoremap <F5> :call VexploreToggle()<CR>


syntax on
set t_Co=256
set cursorline
colorscheme onehalfdark
let g:airline_theme='onehalfdark'
let g:rainbow_active = 1

" Copied from Fatih dotfiles
set noerrorbells             " No beeps
set nocompatible
set number                   " Show line numbers
set noshowcmd                " Remove because of vim-airline
set noshowmode 		     " Remove this because of vim-airline
set shortmess+=F
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set autowrite 				 " Save before make, next, etc etc

set completeopt=menu,menuone " What are the options here?

" TagBar == F8
nmap <F8> :TagbarToggle<CR>

" Copied from @thockin dotfiles, per file formating
" go
au FileType go setl tabstop=4
au FileType go setl shiftwidth=4
au FileType go setl formatoptions-=t  " No textwidth formatting
au FileType go setl number
au FileType go setl nolist

" yaml
au FileType yaml setl indentkeys-=<:>
au FileType yaml setl tabstop=2
au FileType yaml setl shiftwidth=2
au FileType yaml setl expandtab
au FileType yaml setl number

" sh
au FileType sh setl expandtab
au FileType sh setl tabstop=4
au FileType sh setl shiftwidth=4
au FileType sh setl list


filetype off
filetype plugin indent on

set ttyfast


" ======= VIM GO ========
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

"\b == GoBuild or GoTestCompile (depending on the function above)
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
"\c == GoCoverageToggle
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
"\t = Test file
autocmd FileType go nmap <leader>l  <Plug>(go-metalinter)
 \r == GoRun
autocmd FileType go nmap <leader>r  <Plug>(go-run)
"\t = Test file
autocmd FileType go nmap <leader>t  <Plug>(go-test)
"\d = GoDef on a splitted window
autocmd FileType go nmap <leader>d  <Plug>(go-def-vertical)

"\a == Close QuickFix Window
nnoremap <leader>a :cclose<CR>
" Ctrl n / m to move around the quickfix list
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
"\a == Close Location Window
nnoremap <leader>z :lclose<CR>
" Ctrl n / m to move around the location list
map <C-b> :lnext<CR>
map <C-v> :lprevious<CR>

" Previos Tab / Next Tab
nnoremap H gT
nnoremap L gt
" Tab New & Tab Close
nnoremap <C-Insert> :tabnew<CR>
nnoremap <C-Home> :tabclose<CR>


let g:go_test_timeout = '10s' " Max Text Wait = 10s
" Formatters 
let g:go_fmt_command = "gofmt" 
let g:go_imports_mode="gopls"
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_imports_autosave=1

let g:go_snippet_engine = "ultisnips"

" Highlights
let g:go_highlight_types = 1 " Colors for types
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_auto_type_info = 1 "Show function signature in statusbar
let g:go_highlight_interfaces = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

" Stop using extra spaces! (highlights may help to correct this!)
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1

set updatetime=100 " Update time for the above is 100ms, otherwise status bar is annoying to wait
let g:go_gopls_complete_unimported = 1

let g:go_template_autocreate = 0 " The hello world in new files is boring...

" :A, :AV, :AS, :AT - GoAlternate(VerticalSplit, HorizontalSplit, Tab)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

