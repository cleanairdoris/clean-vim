"基础配置
set history=1000

syntax enable
syntax on
filetype on
filetype plugin on
filetype indent on

set autoread

set nu
set showmatch
set cursorline "突出显示当前行
" set cursorcolumn " 突出显示当前列

"搜索逐字高亮
set hlsearch
set incsearch

" 关闭兼容模式
set nocompatible

set nobackup "关闭备份模式
set mouse=a

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

set noshowmode  "关闭提示模式

" tab 缩进
set tabstop=4 " 设置Tab长度为4空格
set shiftwidth=4 " 设置自动缩进长度为4空格
set autoindent " 继承前一行的缩进方式，适用于多行注释

"解决插入模式下delete/backspce键失效问题
set backspace=indent,eol,start
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        插件安装
""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
"优化nerdtree
Plug 'jistr/vim-nerdtree-tabs'

Plug 'mhinz/vim-signify'
Plug 'w0rp/ale'
Plug 'Shougo/echodoc.vim'
Plug 'airblade/vim-gitgutter'

Plug 'skywind3000/asyncrun.vim'

"搜索工具
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"补全工具
Plug 'neoclide/coc.nvim' , {'do': 'yarn install --frozen-lockfile'}

Plug 'fatih/vim-go'
Plug 'dgryski/vim-godef'

Plug 'majutsushi/tagbar'
"
"美化UI
Plug 'sickill/vim-monokai'               " monokai主题
Plug 'vim-airline/vim-airline'           " 美化状态栏
Plug 'vim-airline/vim-airline-themes'
Plug 'plasticboy/vim-markdown'           " markdown高亮
Plug 'octol/vim-cpp-enhanced-highlight'  " C++代码高亮
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       插件配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=500

"autocmd vimenter * NERDTree  "自动开启Nerdtree
"wincmd w
"autocmd VimEnter * wincmd w

let g:NERDTreeWinSize = 25 "设定 NERDTree 视窗大小
"开启/关闭nerdtree快捷键
map <F10> :NERDTreeToggle<CR>
"let NERDTreeShowBookmarks=1  " 开启Nerdtree时自动显示Bookmarks
"打开vim时如果没有文件自动打开NERDTree
"autocmd vimenter * if !argc()|NERDTree|endif
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"设置树的显示图标
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore = ['\.pyc$', '\.o', '\.a', '\.so', '\.swp']  " 过滤所有.pyc文件不显示
"let g:NERDTreeShowLineNumbers=1  " 是否显示行号
let g:NERDTreeHidden=0     "不显示隐藏文件
"Making it prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1


"NERDTree-Tabs
let g:nerdtree_tabs_open_on_console_startup=1 

" Asyncrun
let g:asyncrun_open = 8

"""""""""""""""""""""""echodoc
let g:echodoc#type = "echo" " Default value

"""""""""""""""""""""""""""""""" ale
let g:ale_linters = {
            \ 'c': ['gcc', 'cppcheck'],
            \ 'cpp': ['g++', 'cppcheck'],
            \ }
let g:ale_c_gcc_options = '-Wall -O2 -std=c99
            \ -I .
            \ -I /usr/include'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11
            \ -I .
            \ -I /usr/include
            \ -I $HOME/local/gcc-5.4.0/include/c++/5.4.0'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_linters_explicit = 1  " 只显示运行ale_linters的文件
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
let g:ale_echo_msg_format = '[%linter%] %s %code: %%s'
let g:ale_lint_on_text_changed = 'normal'  " 防止YCM不停补全
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

" majutsushi/tagbar 插件打开关闭快捷键
nmap <F9> :TagbarToggle<CR>
let g:tagbar_width=25
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


"==============================================================================
" vim-go 插件
"==============================================================================
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

let g:godef_split=2

"-------------coc.nvim推荐的配置--------------------
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

"在输入一部分字符的情况下，用tab来自动补全
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

" 用Ctrl @来主动触发自动补全
inoremap <silent><expr> <c-@> coc#refresh()

" 回车时，选择自动补全窗口的第一项
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> sn <Plug>(coc-diagnostic-prev)
nmap <silent> sp <Plug>(coc-diagnostic-next)

" 几个非常重要的定义跳转键,gd, gr
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" K用于显示文档
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" rn键用于重命名
nmap <leader>rn <Plug>(coc-rename)

" leader f，默认就是\f，格式化代码
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 修正代码的快捷键，如自动引入
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"-------------coc.nvim推荐的配置结束----------------


"""""""""""""""""""""""美化插件""""""""""""""""""""""""
"" airline
let laststatus = 2
let g:airline_powerline_fonts = 1
let g:airline_theme = "dark"
let g:airline#extensions#tabline#enabled = 1

" 开启24bit的颜色
set termguicolors

"" vim-monokai
colorscheme monokai

"" vim-markdown
" Github风格markdown语法
let g:vim_markdown_no_extensions_in_markdown = 1

"" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
