" General ---------------------------------------------------------------------
filetype plugin indent on
let &keywordprg=":Man"
set autoindent
set autoread
set backspace=indent,eol,start
set belloff=all
set bg=dark
set clipboard=unnamed,unnamedplus
set cmdheight=1
set complete=.,w,b,u,t
set completeopt=noinsert,menuone,noselect
set cscopeverbose
set diffopt=internal,filler
set display=lastline
set expandtab
set formatoptions=q
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
set hidden
set history=10000
set incsearch
set laststatus=2
set listchars=tab:>\ ,trail:-,nbsp:+
set maxcombine=6
set mouse=v
set noautowrite
set nobackup
set nocompatible
set noerrorbells
set nofsync
set nohlsearch
set nojoinspaces
set nopaste
set noshowmode
set nostartofline
set noswapfile
"set notitle
set nowrap
set nowritebackup
set number
set pastetoggle=<F3>
set relativenumber
set ruler
"set scroll=13
"set scrolloff=0
set sessionoptions-=options
set shiftwidth=4
set shortmess=filnxtToOf
set showcmd
set sidescroll=1
set signcolumn=yes
set smarttab
set softtabstop=4
set switchbuf=uselast
set tabpagemax=50
set tags=./tags;,tags
set termguicolors
set titleold=
set ttimeout
set ttimeoutlen=50
set ttyfast
set undofile
set updatetime=300
set wildmenu


" Plugins ---------------------------------------------------------------------
call plug#begin('~/.local/share/vim')
    " visuals in general
    Plug 'wojciechkepka/vim-github-dark'
    "Plug 'dikiaap/minimalist'
    Plug 'vim-airline/vim-airline'

    " send-code-to-terminal
    Plug 'hanschen/vim-ipython-cell', { 'for': ['python', 'julia'] }
    "Plug 'jpalardy/vim-slime', { 'for': ['python', 'julia']}

    " lang support
    Plug 'rust-lang/rust.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'JuliaEditorSupport/julia-vim'
call plug#end()


" remaps ----------------------------------------------------------------------
let mapleader = " "

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <silent> <C-S-j> :resize -1<CR>
nnoremap <silent> <C-S-k> :resize +1<CR>
nnoremap <silent> <C-S-h> :vertical resize -1<CR>
nnoremap <silent> <C-S-l> :vertical resize +1<CR>

function! WinZoomToggle() abort
    if ! exists('w:WinZoomIsZoomed') 
        let w:WinZoomIsZoomed = 0
    endif
    if w:WinZoomIsZoomed == 0
        let w:WinZoomOldWidth = winwidth(0)
        let w:WinZoomOldHeight = winheight(0)
        wincmd _
        wincmd |
        let w:WinZoomIsZoomed = 1
    elseif w:WinZoomIsZoomed == 1
        execute "resize " . w:WinZoomOldHeight
        execute "vertical resize " . w:WinZoomOldWidth
        let w:WinZoomIsZoomed = 0
    endif
endfunction
" get full screen one buffer like prefix-z from tmux
nnoremap <leader>z :call WinZoomToggle()<CR>

" Colors, font and syntax -----------------------------------------------------
syntax on
set encoding=utf-8
set guifont=JuliaMono
"let g:gruvbox_italic=0
"let g:gruvbox_contrast_dark = 'hard'
"colorscheme gruvbox
"colorscheme minimalist
colorscheme ghdark
set t_Co=256  " adjusts to gruvbox colorscheme work properly inside a tmux session

autocmd BufNewFile,BufRead *.jl set ft=julia


" TMUX compatibilities --------------------------------------------------------
let g:slime_target = "tmux"
"let g:slime_paste_file = "$HOME/.slime_past"
"let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
    if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799  https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
        set termguicolors
    endif
endif


" COC VIM ---------------------------------------------------------------------
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! CheckBackSpace()
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <S-Tab>
  \ coc#pum#visible() ? coc#pum#prev(1) :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#snippet#prev()\<CR>" :
  \ CheckBackSpace() ? "\<S-Tab>" :
  \ coc#refresh()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
  else
      call feedkeys('K', 'in')
  endif
endfunction

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
