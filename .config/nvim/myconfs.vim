" ----------
" My VIM configurations
" author: Éverton Arruda <root@earruda.eti.br>
" website: http://earruda.eti.br
"
" Inspired by: http://gitorious.org/magic-dot-files/magic-dot-files
" ----------

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Editing preferences
syntax on
set ts=4                " Defines tab stop to 4 spaces
set ai                  " Defines Auto-Indentation
set sw=4                " Number of spaces for each step of auto-ident
set number              " Shows the line numeration
set expandtab           " Changes shifttab for spaces
set softtabstop=4       " let backspace delete indent
set pastetoggle=<F2>    " Turns paste mode on or off. Used to paste text in vim
"set background=light
colorscheme monokai

" Searching preferences
set hlsearch           " highlight the last used search pattern
set incsearch          " Incomplete search, show results while typing
set ignorecase         " Case-insensitive search
set smartcase          " case-sensitive if search contains an uppercase char
" Change colors of highlighted word on search
"highlight Search ctermbg=blue ctermfg=white

" Clear search highlight with ',h' keys in normal mode
nmap ,h :nohlsearch<CR>

" Copy visual selection to clipboard
vnoremap ,y "+y

" Paste from clipboard
vnoremap ,p "+p

" Force write command
command SW w !sudo tee %

" Persistent undo
if has('persistent_undo')
    set undofile                " so is persistent undo ...
    set undolevels=1000         " max number of changes that can be undone
    set undoreload=10000        " max lines to save for undo on a buffer reload
    set undodir=/home/$USER/.vim-undo-files     " where to save undo histories
endif

" Highlight collumn 81 for some types of file
highlight ColumnMarker ctermbg=magenta guibg=red ctermfg=white
autocmd FileType sh,c,cpp,java,php  call matchadd('ColumnMarker', '\%81v', 100)
autocmd FileType vim                call matchadd('ColumnMarker', '\%81v', 100)
autocmd FileType javascript,python  call matchadd('ColumnMarker', '\%81v', 100)

" Highlight trailing whitespaces and tabs
highlight TrailingWhiteSpace ctermbg=red guibg=red ctermfg=white
highlight Tabs ctermbg=red guibg=red ctermfg=white
autocmd BufEnter * call matchadd('TrailingWhiteSpace', '\s\+$', 100)
autocmd BufEnter * call matchadd('Tabs', '\t', 100)
autocmd BufLeave * call clearmatches()

" Hightlight autocompletion window - modifying colors
"highlight Pmenu ctermbg=DarkGrey ctermfg=LightGrey
"highlight PmenuSel ctermbg=DarkBlue ctermfg=White

" Highlight cursor line and cursor line number
if exists('colors_name') && colors_name == 'monokai'
    set cursorline
    highlight CursorLineNr ctermbg=236 guibg=#383a3e
    "highlight CursorLine cterm=NONE ctermbg=Black
endif

" Commenting blocks of code.
autocmd FileType c,cpp,java,php,javascript      let b:commentLeader = '// '
autocmd FileType sh,ruby,python,conf,fstab      let b:commentLeader = '# '
autocmd FileType tex                            let b:commentLeader = '% '
autocmd FileType mail                           let b:commentLeader = '> '
autocmd FileType vim                            let b:commentLeader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:commentLeader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:commentLeader,'\/')<CR>//e<CR>:nohlsearch<CR>

if has("autocmd")
    filetype plugin indent on
endif
