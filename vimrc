set nocompatible

call plug#begin('~/.vim/plugged')

"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
"Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree'

" Handling of braces, quotes and parantheses
Plug 'Raimondi/delimitMate'

" Better folding in Python
Plug 'tmhedberg/SimpylFold', { 'for': ['py']}

" Why do I have this?
"Plug 'SirVer/ultisnips'

" Seem to be a shitty version of NerdTree?
Plug 'Shougo/unite.vim'

" Goes without saying.. :)
Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp']}

" Why the fuck would I run three completers, come on
"Plug 'Shougo/neocomplete.vim'

" Obviously important for C#
Plug 'OmniSharp/omnisharp-vim', { 'for': ['cs']}
Plug 'ervandew/supertab', { 'for': ['cs']}

" Dispatch seems important...
Plug 'tpope/vim-dispatch'

" Again, seems important - don't know why I have it alongside Omnisharp
" though. DISABLING!
" Nope, nevermind - seems like Omnisharp uses it internally.
Plug 'vim-syntastic/syntastic'

Plug 'vim-airline/vim-airline'

Plug 'pangloss/vim-javascript'

Plug 'rakr/vim-one'

" Now this seems useless... Disabling!
"Plug 'OrangeT/vim-csharp'

call plug#end()

syntax on

let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'

set shell=/bin/bash
set mouse=a
set softtabstop=4
set expandtab
set tabstop=4
set shiftwidth=4
set backspace=2
set foldmethod=syntax
set cino=N-s
set showmode
set ruler
set ignorecase
set smartcase
set incsearch
set ai
set si
set nu
set nowrap
let mapleader = ','
set langmenu=en_US.UTF-8
language en_US.UTF-8
" set colorcolumn=80

set termguicolors
colorscheme one
let g:airline_theme='one'

"inoremap {      {}<Left>
"inoremap {<CR>  {<CR>}<Esc>O
"inoremap {{     {
"inoremap {}     {}
"nnoremap <C-J> i<CR><Esc>k$
"nnoremap zx     zxzczO
"nnoremap zo     zO
"nnoremap zc     zC
"nnoremap zC     zc
"nnoremap cO     co

" Open CPP and H file in a new tab, Vsplit
:command -nargs=1 -complete=file FPP   tabe <args>.cpp | vsplit | wincmd H | e <args>.h
:command -nargs=1 -complete=file NPP   tabe <args>.cpp | vsplit | wincmd H | e <args>.h | NERDTree | wincmd l
:command -nargs=1 -complete=file FPM   tabe <args>.m   | vsplit | wincmd H | e <args>.h
:command -nargs=1 -complete=file FC    tabe <args>.c   | vsplit | wincmd H | e <args>.h

let NERDTreeIgnore=['third_party','LICENSE','build.*','cmake','assets','docs']
:command -nargs=0 NT NERDTree
:command -nargs=0 NTT tabnew | NERDTree

" (Trailing) whitespace displayment and management
:highlight ExtraWhitespace ctermbg=darkred guibg=darkred
:match ExtraWhitespace /\s\+\%#\@<!$/
:command SW %s /\s\+$//g
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:au InsertLeave * match ExtraWhitespace /\s\+$/


" +--------------------------------------------------+ "
" |                 YouCompleteMe                    | "
" +--------------------------------------------------+ "
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

" THIS REALLY ONLY WORKS WITH THE UBUNTU COLOR SCHEME
" -- nope, it actually looks OK in other schemes as well
:highlight YcmErrorLine         ctermbg=lightred        ctermfg=white   guibg=pink      guifg=black
:highlight YcmErrorSection      ctermbg=darkred         ctermfg=red     guibg=red       guifg=white
:highlight YcmWarningLine       ctermbg=lightyellow     ctermfg=white   guibg=pink      guifg=black
:highlight YcmWarningSection    ctermbg=darkyellow      ctermfg=white   guibg=yellow    guifg=black



" +--------------------------------------------------+ "
" |            Custom Language Triggers              | "
" +--------------------------------------------------+ "
au BufReadPost *.cpp :syntax region overwrite_cBlock start="\(namespace .* \)\@<={" end="}" contains=ALLBUT,cBlock

au BufReadPost *.cs :set foldmarker={,}
au BufReadPost *.cs :set foldmethod=marker
au BufReadPost *.cs :set foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
au BufReadPost *.cs :set foldcolumn=4
au BufReadPost *.cs :set foldlevelstart=2
au BufReadPost *.cs :imap <C-Space> <C-x><C-o>
au BufReadPost *.cs :imap <C-@> <C-Space>

au BufReadPost *.tex :set makeprg=xelatex\ %

nnoremap <F5> :make<CR>



" +--------------------------------------------------+ "
" |                   SuperTab                       | "
" +--------------------------------------------------+ "
let g:SuperTabDefaultCompletionType = "<c-n>"


" +--------------------------------------------------+ "
" |                  OmniSharp                       | "
" |  Shamelessly ripped off from the official github | "
" |            and modified slightly.                | "
" +--------------------------------------------------+ "
filetype plugin on
set completeopt-=preview

let g:OmniSharp_server_type = 'v1'
let g:OmniSharp_server_type = 'roslyn'
let g:OmniSharp_selector_ui = 'unite'
let g:OmniSharp_prefer_global_sln = 1
let g:OmniSharp_timeout = 1
let g:Omnisharp_start_server = 1
let g:Omnisharp_stop_server = 0

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch

"Super tab settings - uncomment the next 4 lines
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1

"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview
" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono)
" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" you need it with the :OmniSharpDocumentation command.
let g:omnicomplete_fetch_documentation=0

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set splitbelow

" Get Code Issues and syntax errors
"let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" If you are using the omnisharp-roslyn backend, use the following
let g:syntastic_cs_checkers = ['code_checker']
augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    " autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=250
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

" Enable snippet completion, requires completeopt-=preview
" let g:OmniSharp_want_snippet=1
