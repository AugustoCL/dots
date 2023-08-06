" General ---------------------------------------------------------------------
filetype plugin indent on
let &keywordprg=":Man"
set autoindent
set autoread
set backspace=indent,eol,start
set backup
set backupdir=$HOME/.vim/tmp/backup
set belloff=all
set bg=dark
set clipboard=unnamed,unnamedplus
set cmdheight=1
set complete=.,w,b,u,t
set completeopt=noinsert,menuone,noselect
set cscopeverbose
set diffopt=internal,filler
set directory=$HOME/.vim/tmp/swap
set display=lastline
set expandtab
set formatoptions=q
set foldmethod=manual
autocmd FileType python setlocal foldmethod=indent
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
"set smartindent
set softtabstop=4
set swapfile
set switchbuf=uselast
set tabpagemax=50
set tabstop=4
set tags=./tags;,tags
set termguicolors
set titleold=
set ttimeout
set ttimeoutlen=50
set ttyfast
set undodir=$HOME/.vim/tmp/undo
set undofile
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
set updatetime=300
set wildmenu

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif


" Plugins ---------------------------------------------------------------------
call plug#begin('~/.local/share/vim')
    " Appearance
    Plug 'wojciechkepka/vim-github-dark'
    Plug 'fcpg/vim-fahrenheit'
    Plug 'catppuccin/vim', { 'as': 'catppuccin' }
    Plug 'dikiaap/minimalist'
    Plug 'itchyny/lightline.vim'
    Plug 'itchyny/vim-gitbranch'

    " Send-code-to-terminal
    Plug 'jgdavey/tslime.vim'

    " Lang support
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'rust-lang/rust.vim'
    Plug 'JuliaEditorSupport/julia-vim'
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }

    Plug 'jiangmiao/auto-pairs'

    " fuzzy finder integrations
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-commentary'
call plug#end()


" remaps ----------------------------------------------------------------------
let mapleader = " "

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <silent> <C-S-j> :resize -1<CR>
nnoremap <silent> <C-S-k> :resize +1<CR>
nnoremap <silent> <C-S-h> :vertical resize -1<CR>
nnoremap <silent> <C-S-l> :vertical resize +1<CR>
nnoremap <leader>R :so ~/.vimrc<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
nnoremap c "_c
nnoremap C "_C
inoremap <Esc> <Esc>l
inoremap kj <Esc>l
nnoremap <Leader>w :w<CR>

" get full screen one buffer like prefix-z from tmux
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
nnoremap <leader>z :call WinZoomToggle()<CR>

" hide status bar at vim
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <C-w>\ :call ToggleHiddenAll()<CR>

" remember folds
augroup remember_folds
  autocmd!
  autocmd BufWritePost * mkview
  autocmd BufRead * silent! loadview
augroup END

" remove tilda (~) from EndOfBuffer
autocmd BufRead * highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg


" Colors, font and syntax -----------------------------------------------------
syntax on
set encoding=utf-8
set guifont=JuliaMono
if !has('gui_running')
  set t_Co=256
endif

"let g:gruvbox_italic=0
"let g:gruvbox_contrast_dark = 'hard'
"colorscheme gruvbox
"colorscheme minimalist
"let g:gh_color = 'soft'
"colorscheme ghdark
colorscheme fahrenheit
"colorscheme catppuccin_mocha

let g:lightline = {
      \ 'colorscheme': 'fahrenheit',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

autocmd BufNewFile,BufRead *.jl set ft=julia


" TMUX compatibilities --------------------------------------------------------
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_past"
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


" Rust-analyzer ---------------------------------------------------------------
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
\ }

" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F5> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent> K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)

" Search for a pattern followed immediately by a opening block '{'
function! s:is_opening_block(preblock_pattern)
	let view = winsaveview()
	" If we search for the pattern but we are already on it, we're gonna find 
	" the next one (search forward) or the previous one (search backward) but 
	" not the current one.
	" To avoid this, we move one character forward and we're gonna search 
	" backward.
	execute "normal! l"
	" if we're at the end of the line
	if col(".") == view["col"] + 1
		" move to the beginning of next line
		execute "normal! j0"
	endif
	let [lnum, col] = searchpos(a:preblock_pattern . '\zs{\ze', "b")
	call winrestview(view)
	if lnum == line(".") && col == col(".")
		let result = v:true
	else
		let result = v:false
	endif
	return result
endfunction

function! s:extract_name(pattern)
	let view = winsaveview()
	let lnum = search(a:pattern, "b")
	call winrestview(view)
	let line = getline(lnum)
	let name = matchstr(line, a:pattern)
	return name
endfunction

function! s:is_test_function_block()
	const test_prefix_pattern = '#\[test\]\_.\{-}'
	const prefix_pattern = '\<fn\>\s\+'
	const function_name_pattern = '\<\h\w*\>'
	const suffix_pattern = '[<(\s][^{]\+'
	let is_test_function_block = <SID>is_opening_block(test_prefix_pattern . prefix_pattern . function_name_pattern . suffix_pattern)
	if is_test_function_block
		let function_name = <SID>extract_name(prefix_pattern . '\zs\(' . function_name_pattern . '\)')
		return function_name
	endif
	return -1
endfunction

function! s:is_mod_block()
	const prefix_pattern = '\<mod\>\s\+'
	const mod_name_pattern = '\<\h\w*\>'
	const suffix_pattern = '\s\+'
	let is_test_mod_block = <SID>is_opening_block(prefix_pattern . mod_name_pattern . suffix_pattern)
	if is_test_mod_block
		let mod_name = <SID>extract_name(prefix_pattern . '\zs\(' . mod_name_pattern . '\)')
		return mod_name
	endif
	return -1
endfunction

function! s:rust_execute_test()
	const FUNCTION_SEARCH_STATE = "function-search"
	const MOD_SEARCH_STATE = "mod-search"
	const FILE_SEARCH_STATE = "file-search"
	let test_path = []
	let state = FUNCTION_SEARCH_STATE
	let function_found = v:false
	let view = winsaveview()
	let lnum = view['lnum']
	let col = view['col']
	normal! [{
	while lnum != line(".") || col != col(".")
		if state == FUNCTION_SEARCH_STATE
			let function_name = <SID>is_test_function_block()
			if function_name != -1
				let test_path += [function_name]
				let function_found = v:true
				let state = MOD_SEARCH_STATE
			else
				let mod_name = <SID>is_mod_block()
				if mod_name != -1
					let test_path += [mod_name]
					let state = MOD_SEARCH_STATE
				endif
			endif
		elseif state == MOD_SEARCH_STATE
			let mod_name = <SID>is_mod_block()
			if mod_name != -1
				let test_path += [mod_name]
			endif
		endif
		let lnum = line(".")
		let col = col(".")
		normal! [{
	endwhile
	let cargo_arguments = "test --all-features"
	let file_path = []
	for segment in split(expand("%:p:r"), '/')
		" Before 'src', discard every segment of the path
		if segment == "src"
			let cargo_arguments .= " --lib"
			let state = FILE_SEARCH_STATE
		elseif segment == "tests"
			let cargo_arguments .= " --test " . expand("%:t:r")
			break
		elseif state == FILE_SEARCH_STATE
			" Every segment of the path is now a module (folder or files) at the
			" exception of `lib.rs` and `main.rs`
			if segment != "lib" && segment != "main"
				let file_path += [segment]
			endif
		endif
	endfor
	let test_path = file_path + reverse(test_path)
	if function_found
		let cargo_arguments .= " -- --exact "
	else
		let cargo_arguments .= " -- "
	endif
	let cargo_arguments .= join(test_path, "::")
	call winrestview(view)
	" Run cargo command
	execute "Cargo " . cargo_arguments
endfunction

noremap <F6> <Esc>:call <SID>rust_execute_test()<Enter>


" COC VIM ---------------------------------------------------------------------
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <S-Tab>
  \ coc#pum#visible() ? coc#pum#prev(1) :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#snippet#prev()\<CR>" :
  \ CheckBackSpace() ? "\<S-Tab>" :
  \ coc#refresh()

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json,rust,julia setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" tslime remaps --------------------------------------------------------------
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
vmap JK <Plug>SendSelectionToTmuxj
nmap JK <Plug>NormalModeSendToTmux}j
nmap <C-c>r <Plug>SetTmuxVars
let g:tslime_always_current_session=1
let g:tslime_always_current_window=1
let g:tslime_autoset_pane=1


" fzf plugin -----------------------------------------------------------------
" adjust call of Files and Buffers funcions
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
command! -bang -nargs=? -complete=dir Buffers
    \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
" remap functions Files and Buffers
nnoremap <leader>sf :Files<CR>
nnoremap <leader>bf :Buffers<CR>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
