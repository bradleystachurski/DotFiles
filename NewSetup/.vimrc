set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" emmet-vim plugin
Plugin 'mattn/emmet-vim'

" The NERD tree plugin
Plugin 'scrooloose/nerdtree'

" vim-javascript and vim-jsx plugins
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" Auto pairs for parentheses, etc
Plugin 'jiangmiao/auto-pairs'

" Ctrl-p latest repo
Plugin 'ctrlpvim/ctrlp.vim'

" auto completion
" Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'

" vim-surround
Plugin 'tpope/vim-surround'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" Plugin for vim-solidity syntax highlighting
Plugin 'tomlion/vim-solidity'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" CtrlP custom ignore settings
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" movement maps
nmap L $
nmap H ^

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" . scan the current buffer, b scan other loaded buffers that are in the
" buffer list, u scan the unloaded buffers that are in the buffer list, w scan
" buffers from other windows, t tag completion
set complete=.,b,u,w,t,]

" Keyword list
set complete+=k~/.vim/keywords.txt

" Set relative line numbers
set relativenumber " Use relative numbers. Current line is still in status bar.
au BufReadPost,BufNewFile * set relativenumber

" Set some junk (from Paul Irish's dotfiles)
set autoindent " Copy indent from last line when starting new line

" Syntax highlighting {{{
set t_Co=256
set background=dark
syntax on
colorscheme despacio
" }}}

" Transparanet background
hi Normal guibg=NONE ctermbg=NONE

" NERDTree show hidden files
let NERDTreeShowHidden=1

" autopen NERDTree and focus cursor in new document
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" auto close NERTDTree when closing vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
   let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
   let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif"
