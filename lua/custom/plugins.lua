-- ################################################## 插件管理 ##################################################
local status, _ = pcall(require, 'packer')
if not status then
    return
end

local nvim = vim
local packer = require('packer')

-- packer.nvim 配置在 nvim.opt 上使用, 不需要该配置注释即可
nvim.cmd([[packadd packer.nvim]])

-- 插件列表
local plugins = {
    -- neovim控件管理插件
    {
        package = { 'wbthomason/packer.nvim' }
    },

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
        package = { 'akinsho/bufferline.nvim', tag = 'v2.*', requires = 'kyazdani42/nvim-web-devicons' },
        configs = 'configs.bufferline.init',
    },

    -- 文件树
    {
        package = { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' },
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
        package = { 'akinsho/toggleterm.nvim', tag = '*' },
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

    -- lsp美化
    {
        package = { 'tami5/lspsaga.nvim' },
        configs = 'configs.lspsaga.init',
    },

    -- 代码补全
    {
        package = {
            'hrsh7th/nvim-cmp',
            requires = {
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
        package = { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } },
        configs = 'configs.nvim-dap-ui.init',
    },

    -- 代码折叠
    {
        package = { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' },
        configs = 'configs.nvim-ufo.init',
    },

    -- golang插件
    {
        package = { 'ray-x/go.nvim' },
        configs = 'configs.go.init',
    },

    -- 文件搜索框架
    {
        package = { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = 'nvim-lua/plenary.nvim' },
        configs = 'configs.telescope.init'
    },

    -- 颜色显示
    {
        package = { 'norcalli/nvim-colorizer.lua' },
        configs = 'configs.nvim-colorizer.init',
    },

    -- 状态栏样式
    {
        package = { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } },
        configs = 'configs.lualine.init',
    },

    -- 弹窗提示
    {
        package = { 'rcarriga/nvim-notify' },
        configs = 'configs.nvim-notify.init',
    },

    -- 各中弹窗交互, (命令行弹窗, 信息提示弹窗, 项目加载进度)
    {
        package = { 'folke/noice.nvim', requires = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' } },
        configs = 'configs.noice.init',
    },

    -- git操作, 行号显示
    {
        package = { 'lewis6991/gitsigns.nvim' },
        configs = 'configs.gitsigns.init',
    },

    -- git文件对比
    {
        package = { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' },
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
        -- package = { 'mg979/vim-visual-multi' },
        -- configs = 'configs.vim-visual-multi.init',
        -- command = 'packadd! vim-visual-multi',
    },

}

-- 启用插件
local function startup()
    local startup_plugins = {}

    for _, plugin in pairs(plugins) do
        if plugin == nil or plugin.package == nil then
            goto continue
        end

        -- 添加需要启用的插件
        table.insert(startup_plugins, plugin.package)

        if plugin.configs == nil or plugin.configs == '' then
            goto continue
        end

        -- 加载插件配置
        require(plugin.configs)

        :: continue ::
    end

    return packer.startup({
        startup_plugins,
        config = {},
        rocks = {},
    })
end

return startup()
