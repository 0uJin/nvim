-- ################################################## 系统选项 ##################################################
local nvim = vim

-- ================================================== 基础设置 ==================================================
-- 关闭兼容vi模式
nvim.opt.compatible = false
-- 禁止生成临时文件
nvim.opt.swapfile = false
-- neovim与MacOS共享剪切板
nvim.opt.clipboard = 'unnamed'
-- 关联操作等待时间设置为1秒
nvim.opt.timeoutlen = 1000
-- 终端模式下, 关联操作等待时间设置为0秒
nvim.opt.ttimeoutlen = 0
-- 光标停留触发时间
nvim.opt.updatetime = 1000

-- ================================================== 编码设置 ==================================================
nvim.opt.fileencodings = 'ucs-bom,utf-8,cp936'
nvim.opt.fileencoding = 'utf-8'
nvim.opt.encoding = 'utf-8'

-- ==================================================== 显示 ====================================================
-- 显示正在输入的命令
nvim.opt.showcmd = true
-- 显示行数
nvim.opt.number = true
-- 单行过长换行显示
nvim.opt.wrap = false
-- 突出当前行
nvim.opt.cursorline = true
-- 检查拼写是否错误
nvim.opt.spell = false
-- 显示相对行号
nvim.opt.relativenumber = true
-- 代码折叠方式
nvim.opt.foldmethod = 'manual'
-- 代码折叠边栏显示层数, 0: 不显示
nvim.opt.foldcolumn = '0'
-- 边栏宽度
nvim.opt.numberwidth = 1
-- 启动时自动折叠代码
nvim.opt.foldenable = false
-- vim顶(底)部显示行数
nvim.opt.scrolloff = 10
-- 修改diff对比不同时所填充的字符(由-更改为╱)
nvim.opt.fillchars = 'diff:╱'
-- 设置分割窗口排布, vertical: 垂直分割, horizontal: 水平分割
nvim.opt.diffopt = 'internal,filler,closeoff,vertical'
-- 光标样式
nvim.opt.guicursor = 'n-v-c-sm:block,i-ci:ver25,r-cr-o:hor20'

-- ================================================== 历史记录 ==================================================
-- 开启撤销文件
nvim.opt.undofile = true
-- 撤销文件保存位置
nvim.opt.undodir = nvim.fn.stdpath("config") .. '/cache/'
-- 撤销次数
nvim.opt.undolevels = 8172
-- 缓冲区大小
nvim.opt.undoreload = 8172
-- 开启时回到上次编辑的位置
nvim.cmd([[ autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])

-- ================================================== 搜索查询 ==================================================
-- / 搜索, 忽略大小写(仅全小写时有效)
nvim.opt.ignorecase = true
-- /搜索, 大小写组合搜索时会精确查找目标(配合上一配置使用)
nvim.opt.smartcase = true

-- ==================================================== tab键 ===================================================
-- 自动缩进
nvim.opt.autoindent = true
-- 以C语言的方式缩进
nvim.opt.cindent = true
-- 用space替代tab的输入
nvim.opt.expandtab = true
-- 设置tab键的空格数
nvim.opt.tabstop = 4
-- 设置自动缩进的空格数量
nvim.opt.shiftwidth = 4
-- tab键的实际占有空格数，统一缩进
nvim.opt.softtabstop = 4

-- ================================================== 鼠标操作 ==================================================
-- 设置鼠标模式, '': 关闭, 'a': 全模式下可用
nvim.opt.mouse = ''
-- 视图模式下光标选中的起始位置, inclusive: 包含当前光标, exclusive: 不包含当前光标
nvim.opt.selection = 'inclusive'
nvim.opt.selectmode = 'mouse,key'
