set nocompatible              " be iMproved, required
set number
filetype off                  " required
"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'dense-analysis/ale'
Plugin 'vim-language-dept/css-syntax.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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
set clipboard=unnamed
" encoding
set encoding=utf-8

" Colors:
set t_Co=256
syntax on

"colorscheme atom-dark-256

" Folding:
set foldmethod=indent
set foldlevel=99

" Search
set hlsearch

" keymaps
nnoremap <space> za

" python indentation:
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4|
    \ set textwidth=79|
    \ set expandtab|
    \ set autoindent|
    \ set fileformat=unix

" bash indentation:
au BufNewFile,BufRead *.sh
    \ set tabstop=2 |
    \ set softtabstop=4 |
    \ set shiftwidth=4|
    \ set textwidth=79|
    \ set expandtab|
    \ set autoindent|
    \ set fileformat=unix
set tabstop=4
"
" set vim highlight groups transparent:
hi Boolean ctermbg=NONE
hi Comment ctermbg=NONE
hi Constant ctermbg=NONE
hi Character ctermbg=NONE
hi Conditional ctermbg=NONE
hi Delimiter ctermbg=NONE
hi Directory ctermbg=NONE
hi Error ctermbg=NONE
hi ErrorMsg ctermbg=NONE
hi Float ctermbg=NONE
hi Function ctermbg=NONE
hi Identifier ctermbg=NONE
hi Ignore ctermbg=NONE
hi Keyword ctermbg=NONE
hi NonText guifg=#44cc44 guibg=NONE ctermbg=none
hi Normal guibg=NONE ctermbg=NONE
hi Number ctermbg=NONE
hi Operator ctermbg=NONE
hi PreProc ctermbg=NONE
hi Question ctermbg=NONE
hi Special ctermbg=NONE
hi SpecialKey ctermbg=NONE
hi SpellRare ctermbg=NONE
hi Statement ctermbg=NONE
hi StorageClass ctermbg=NONE
hi TabLine ctermbg=NONE
hi TabLineFill ctermbg=NONE
hi TabLineSel ctermbg=NONE
hi Title ctermbg=NONE 
hi Todo ctermbg=NONE
hi Type ctermbg=NONE
hi Underlined ctermbg=NONE
hi String ctermbg=NONE
hi LineNr ctermbg=NONE
hi vimGlobal ctermbg=NONE
hi vimNormCmds ctermbg=NONE
hi WildMenu ctermbg=NONE
