" Enable line numbers
set number

" Enable relative line numbers
set relativenumber

" Enable syntax highlighting
syntax enable

" Set auto-indentation
set smartindent
set tabstop=4
set shiftwidth=2
set expandtab

" Highlight search results as you type
set incsearch

" Enable mouse support
set mouse=a

" Highlight matching parentheses
set showmatch

" Display matching brackets/parentheses
set showmatch

" Enable line wrapping
set wrap

" Show line and column number in the status line
set ruler

" Enable line and column number in command mode
set rulerformat=%l,%v

" Highlight current line
set cursorline

" Enable line continuation
set backspace=indent,eol,start

" Display matching parentheses
set showmatch

set scrolloff=10
" Enable clipboard support (requires Vim to be compiled with +clipboard)
set clipboard=unnamedplus

" Enable file type detection
filetype plugin indent on

" Enable auto-command syntax for specific file types
augroup filetypedetect
    autocmd BufRead,BufNewFile *.html set filetype=html
    autocmd BufRead,BufNewFile *.css set filetype=css
    " Add more file type detections as needed
augroup END

set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf


" enable folding
set foldenable " enable folding
set foldlevelstart=10 " open most of the folds by default/ if set to 0, all folds will be closed
set foldnestmax=10 " folds can be neste. Setting a max value protect you from too many folds
set foldmethod=manual " defines the type of folding

let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>

set laststatus=2
" set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)
 vnoremap <C-c> :w !xclip -selection clipboard<CR><CR>

 " Split Windows 
 nnoremap <leader>sv: vsplit<CR>
 nnoremap <leader>ss: split<CR>

" Show full file path 
 nnoremap <leader>pa :echo expand('%:p')<CR>

 " Toggle Netrw 
function! ToggleNetrw()
    if exists("t:netrw_open") && t:netrw_open
        let t:netrw_open = 0
        silent! exec "bd NERD_tree_1"  " Close netrw if open
    else
        let t:netrw_open = 1
        silent! exec "Lexplore"  " Open netrw
    endif
endfunction

nnoremap <leader>e :call ToggleNetrw()<CR>

 " Select all 
 nnoremap <C-a> ggVG

 " system clipboard 
 vnoremap <leader>yy "+y 

 "half page up and center 
 nnoremap <C-u> <C-u>zz

 "half page down and center 
 nnoremap <C-d> <C-d>zz

 " keep search result centers 
 nnoremap n nzzzv
 nnoremap N Nzzzv

 " Open tmux_sessionized 
nnoremap <C-f> :silent !tmux neww /usr/local/bin/tmux_sessionizer<CR>
