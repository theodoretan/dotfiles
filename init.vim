""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim config settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:let g:mapleader=" "  " set leader key to <space>

set expandtab					" use spaces instead of tabs
set smarttab					" set smart tab 
set shiftwidth=2			" set width for automatic indentation
set tabstop=2					" set width of tab character
set nu rnu 						" set relative line numbers
set ai								" set auto indent
set si								" set smart indent

syntax on

" easier splitting
nnoremap <leader>sl :vsp<CR>
nnoremap <leader>sj :sp<CR>

" quick save and quit
nnoremap <leader>ss :w<CR>
nnoremap <leader>qq :q<CR>
nnoremap <leader>QQ :q!<CR>
nnoremap <leader>sq :wq<CR>
nnoremap <leader>x :x<CR>

" copy to clipboard
vnoremap yy "*y<CR>

" remove current file
nnoremap <leader>rm :call delete(@%)<CR>

" reload init.vim
nnoremap <leader><C-r> :source ~/.config/nvim/init.vim<CR>

" open file tree
nnoremap <leader>a :Ex<CR>
let g:netrw_liststyle=3   " make netrw tree style

" find word under cursor in file
nmap // /<C-R><C-W><CR>

" Toggle line number on focus
augroup numbertoggle
  autocmd!
  au BufEnter,FocusGained,InsertLeave  * set rnu
  au BufLeave,FocusLost,InsertEnter    * set nornu
augroup END

" update timeout time waiting for characters in sequence
set timeoutlen=1000 ttimeoutlen=10

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" theme settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" make background transparent for dracula theme
let g:dracula_colorterm=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't search file names with ripgrep
command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
  \   1,
  \   {'options': '--delimiter : --nth 2..'})

" Allow getting word in visual selection (only work with word selections)
function! s:getVisualSelection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)

  if len(lines) == 0
    return ""
  endif

  let lines[-1] = lines[-1][:column_end - (&selection == "inclusive" ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]

  return join(lines, "\n")
endfunction

" File search
" nnoremap <leader><space>p :Files<CR>
" nnoremap <leader>p :GFiles<CR>
nnoremap <expr> <leader>p (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<CR>"
" Text search on word under cusor
nnoremap <silent> <leader>fw :Rg <C-R><C-W><CR>
nnoremap <leader>ff :Rg<space>
vnoremap fw <ESC>:Rg <C-R>=<SID>getVisualSelection()<CR><CR>

" Buffer search
nnoremap <leader>t :Buf<CR>

" Tab/Window search
nnoremap <leader>w :Win<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ale settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
\ 'typescript': ['prettier', 'eslint', 'tsserver', 'tslint'],
\ 'ruby': ['rubocop'],
\}
let g:ale_fixers = {
\ 'javascript': ['prettier', 'eslint'],
\ 'typescript': ['prettier', 'tslint'],
\ 'css': ['prettier'],
\ 'scss': ['prettier'],
\ 'rust': ['rustfmt'],
\}
let g:ale_fix_on_save=1
" turn off linting for certain files
let g:ale_pattern_options = {'.*node_modules/.*': {'ale_enabled': 0}}
" remap go to definition
nnoremap <leader>gd :ALEGoToDefinition<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:deoplete#enable_at_startup=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set shortmess+=c
set signcolumn=yes
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

" enter to confirm completion
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gitgutter settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=400

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug install + settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatic install if its not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a dir for plugins
call plug#begin('~/.vim/plugged')

" Make navigation between vim + tmux easier
Plug 'christoomey/vim-tmux-navigator'

" fzf
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'
" Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" linting
Plug 'dense-analysis/ale'

" code completion
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'mhartington/nvim-typescript', { 'for': ['typescript', 'tsx'], 'do': './install.sh' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" git diff
Plug 'airblade/vim-gitgutter'

" lightline for updating the status bar
Plug 'itchyny/lightline.vim'

" Dracula theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Init plugin system
call plug#end()

" needs to be after plug#end() to initialize the runtimepath
colorscheme dracula
