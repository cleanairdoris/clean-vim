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
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'ycm-core/YouCompleteMe'
Plug 'ludovicchabant/vim-gutentags'     "自动生成tag

Plug 'mhinz/vim-signify'
Plug 'w0rp/ale'
Plug 'Shougo/echodoc.vim'
Plug 'airblade/vim-gitgutter'

Plug 'skywind3000/asyncrun.vim'

"go语言相关
" 查看当前代码文件中的变量和函数列表的插件，
" 可以切换和跳转到代码中对应的变量和函数的位置
" 大纲式导航, Go 需要 https://github.com/jstemmer/gotags 支持
Plug 'majutsushi/tagbar'
" go 主要插件
Plug 'fatih/vim-go', { 'tag': '*' }
" go 中的代码追踪，输入 gd 就可以自动跳转
Plug 'dgryski/vim-godef'

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

"""""""""""""""""""""""""""""""" YCM配置
" 全局YCM配置文件路径
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0  " 不提示是否载入本地ycm_extra_conf文件
let g:ycm_min_num_of_chars_for_completion = 2  " 输入第2个字符就罗列匹配项
" Ctrl+J跳转至定义、声明或文件
nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>|
" 语法关键字、注释、字符串补全
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
" 从注释、字符串、tag文件中收集用于补全信息
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
" 禁止快捷键触发补全
let g:ycm_key_invoke_completion = '<c-z>'  " 主动补全(默认<c-space>)
noremap <c-z> <NOP>
" 输入2个字符就触发补全
let g:ycm_semantic_triggers = {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }
let g:ycm_show_diagnostics_ui=0  " 禁用YCM自带语法检查(使用ale)
set completeopt-=preview
let g:ycm_add_preview_to_completeopt=0   " 禁用YCM 函数原型预览
" 防止YCM和Ultisnips的TAB键冲突，禁止YCM的TAB
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

let g:ycm_filetype_whitelist = {
            \ "c":1,
            \ "cpp":1,
            \ "go":1,
            \ "python":1,
            \ "sh":1,
            \ "zsh":1,
            \ }

"""""""""""""""""""""""echodoc
let g:echodoc#type = "echo" " Default value


"""""""""""""""""""""""""""""gutentags配置
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project', '.vscode', '.idea']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

"""""""""""""""""""""""""""""""" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

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
