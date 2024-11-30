-- ################################################## 插件管理 ##################################################
local nvim = vim
local plugins_path = nvim.fn.stdpath("data") .. '/site/pack/lazy/start'
local lazypath = plugins_path .. '/lazy.nvim'

if not (nvim.uv or nvim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = nvim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if nvim.v.shell_error ~= 0 then
        nvim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        nvim.fn.getchar()
        os.exit(1)
    end
end
nvim.opt.rtp:prepend(lazypath)

-- 确保在设置'mapleader'和'maplocalleader'之前加载lazy.nvim插件,使映射正确
nvim.g.mapleader = " "
nvim.g.maplocalleader = "\\"

-- 插件列表
local plugins = {
    -- Neovim的Lua库，它提供了开发Neovim插件所需的基本Lua函数
    {
        package = { 'nvim-lua/plenary.nvim' }
    },

    -- 图标
    {
        package = { 'kyazdani42/nvim-web-devicons' },
        configs = 'configs.nvim-web-devicons.init',
    },

    -- tab页签样式
    {
        package = { 'akinsho/bufferline.nvim', dependencies = 'kyazdani42/nvim-web-devicons' },
        configs = 'configs.bufferline.init',
    },

    -- 文件树
    {
        package = { 'kyazdani42/nvim-tree.lua', dependencies = 'kyazdani42/nvim-web-devicons' },
        configs = 'configs.nvim-tree.init',
    },

    -- 更鲜艳的代码显示
    {
        -- package = { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
        package = { 'nvim-treesitter/nvim-treesitter' },
        configs = 'configs.nvim-treesitter.init',
    },

    -- 浮窗终端
    {
        package = { 'akinsho/toggleterm.nvim' },
        configs = 'configs.toggleterm.init',
    },

    -- lsp配置, 核心插件
    {
        package = { 'neovim/nvim-lspconfig' },
        configs = 'configs.nvim-lspconfig.init',
    },

    -- lsp自动安装
    {
        package = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
        configs = 'configs.mason.init',
    },

    -- 代码补全
    {
        package = {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'onsails/lspkind-nvim', -- 为补全添加类似 vscode 的图标
                'hrsh7th/cmp-nvim-lsp', -- 替换内置 omnifunc，获得更多补全
                'hrsh7th/cmp-buffer',   -- 缓冲区补全
                'hrsh7th/cmp-path',     -- 路径补全
                'hrsh7th/cmp-cmdline',  -- 命令补全
                'hrsh7th/vim-vsnip',    -- vsnip 引擎，用于获得代码片段支持
                'hrsh7th/cmp-vsnip',    -- 适用于 vsnip 的代码片段源
            }
        },
        configs = 'configs.nvim-cmp.init',
    },

    -- 函数参数提示
    {
        package = { 'ray-x/lsp_signature.nvim' },
        configs = 'configs.lsp_signature.init',
    },

    -- 代码注释
    {
        package = { 'numToStr/Comment.nvim' },
        configs = 'configs.comment.init',
    },

    -- 代码调试
    {
        package = { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' } },
        configs = 'configs.nvim-dap-ui.init',
    },

    -- 代码折叠
    {
        package = { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },
        configs = 'configs.nvim-ufo.init',
    },

    -- 代码格式化
    {
        package = { 'jose-elias-alvarez/null-ls.nvim' },
        configs = 'configs.null-ls.init',
    },

    -- golang插件
    {
        package = { 'ray-x/go.nvim' },
        configs = 'configs.go.init',
    },

    -- 文件搜索框架
    {
        package = { 'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim' },
        configs = 'configs.telescope.init'
    },

    -- 颜色显示
    {
        package = { 'norcalli/nvim-colorizer.lua' },
        configs = 'configs.nvim-colorizer.init',
    },

    -- 状态栏样式
    {
        package = { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons', opt = true } },
        configs = 'configs.lualine.init',
    },

    -- 弹窗提示
    {
        package = { 'rcarriga/nvim-notify' },
        configs = 'configs.nvim-notify.init',
    },

    -- 各中弹窗交互, (命令行弹窗, 信息提示弹窗, 项目加载进度)
    {
        package = { 'folke/noice.nvim', dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' } },
        configs = 'configs.noice.init',
    },

    -- git操作, 行号显示
    {
        package = { 'lewis6991/gitsigns.nvim' },
        configs = 'configs.gitsigns.init',
    },

    -- git文件对比
    {
        package = { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
        configs = 'configs.diffview.init',
    },

    -- 文本快速定位
    {
        package = { 'ggandor/leap.nvim' },
        configs = 'configs.leap.init',
    },

    -- -- 修复CursorHold不生效bug
    -- {
    --     package = { 'antoinemadec/FixCursorHold.nvim', config = function() nvim.g.cursorhold_updatetime = 1000 end },
    -- },

    -- 多光标选择
    {
        package = { 'mg979/vim-visual-multi' },
        configs = 'configs.vim-visual-multi.init',
    },

    -- 数值快速转换, ture <---> false, == <---> != , 等...
    {
        package = { 'AndrewRadev/switch.vim' },
        configs = 'configs.switch.init',
    },

    -- UI组件
    {
        package = { 'MunifTanjim/nui.nvim' },
        configs = 'configs.nui.init',
    }

}

-- 执行命令
local function exec_command(plugin)
    if plugin.command == nil or plugin.command == '' then
        return
    end

    nvim.cmd(plugin.command) -- 执行命令
end

-- 加载插件配置
local function require_configs(plugin)
    if plugin.configs == nil or plugin.configs == '' then
        return
    end

    require(plugin.configs) -- 加载插件配置
end

-- 启用插件
local function startup()
    local startup_plugins = {}

    for _, plugin in pairs(plugins) do
        if plugin == nil or plugin.package == nil then
            goto continue
        end

        -- 添加需要启用的插件
        table.insert(startup_plugins, plugin.package)

        -- 加载插件配置
        require_configs(plugin)

        -- 执行命令
        exec_command(plugin)

        :: continue ::
    end

    -- 更改默认按键
    local view_config = require("lazy.view.config")
    -- 更改全部安装快捷键: 'I' -> 'O'
    view_config.commands.install.key = 'O'
    -- 更改安装快捷键: 'i' -> 'i'
    view_config.commands.install.key_plugin = 'o'

    return require("lazy").setup({
        -- 更改插件安装路径
        root = plugins_path,
        -- 插件列表
        spec = startup_plugins,
        -- 自动检查插件的更新
        checker = { enabled = false },
    })
end

return startup()
