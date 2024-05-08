local status, _ = pcall(require, 'cmp_nvim_lsp')
if not status then
    return
end

local nvim = vim
-- 诊断样式定制 <start> (lspsaga存在时,该配置无效)
local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
}

for _, sign in ipairs(signs) do
    nvim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

local config = {
    -- 诊断的虚拟文本
    virtual_text = false,
    -- show signs
    signs = {
        active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
}
nvim.diagnostic.config(config)

-- <end> (lspsaga存在时,该配置无效)

-- 代码停留高亮
local function lsp_highlight_document(client)
    -- set updatetime=1000, 代码停留触发时间
    if client.server_capabilities.documentHighlightProvider then
        nvim.api.nvim_exec(
            [[
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold * silent! lua document_highlight()
        autocmd CursorHoldI * silent! lua document_highlight()
        autocmd CursorMoved * silent! lua clear_references()
        autocmd CursorMovedI * silent! lua clear_references()
      augroup END
    ]],
            false
        )
    end
end

local function is_allowed_highlight()
    local current_bufnr = nvim.api.nvim_get_current_buf()
    if current_bufnr == nil then
        return false
    else
        -- 不允许高亮的文件类型
        local unallowed_filetypes = { 'NvimTree', 'TelescopePrompt', 'json', 'yaml', 'ini', 'sql', 'markdown' }
        local filetype = nvim.api.nvim_buf_get_option(current_bufnr, 'filetype')
        for _, unallowed_filetype in ipairs(unallowed_filetypes) do
            if filetype == unallowed_filetype then
                return false
            end
        end
    end
    return true
end

function document_highlight()
    if is_allowed_highlight() then
        nvim.lsp.buf.document_highlight()
    end
end

function clear_references()
    if is_allowed_highlight() then
        nvim.lsp.buf.clear_references()
    end
end

-- 按键映射
local opts = { noremap = true, silent = true }
local function set_keymap(bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- 根据选中的[参数]、[函数]跳转(打开新buffer页)
    -- nvim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd> lua vim.lsp.buf.definition() <CR>', opts)
    -- 参数、函数重命名
    -- nvim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>r', '<cmd> lua vim.lsp.buf.rename() <CR>', opts)
    nvim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>r', '<cmd> lua require("lspsaga.rename").rename() <CR>', opts)
    -- 代码格式化
    nvim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>f', '<cmd> lua vim.lsp.buf.format({ async = true }) <CR>', opts)
    -- 查询函数被引用情况
    -- nvim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-u>', '<cmd> Telescope lsp_references theme=dropdown <CR>', opts)
    -- 展示错误信息
    nvim.api.nvim_set_keymap('n', '<leader>e', '<cmd> lua vim.diagnostic.open_float() <CR>', opts)
    -- 跳转到下/上个错误
    nvim.api.nvim_set_keymap('n', '[g', '<cmd> lua vim.diagnostic.goto_prev() <CR>', opts)
    nvim.api.nvim_set_keymap('n', ']g', '<cmd> lua vim.diagnostic.goto_next() <CR>', opts)
    -- 查看帮助信息（代替内置 LSP 的窗口，Lspsaga 让查看帮助信息更美观）
    nvim.api.nvim_set_keymap('n', 'gh', '<cmd> Lspsaga hover_doc<CR>', opts)
    -- -- 跳转到上一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
    -- nvim.api.nvim_set_keymap('n', '[g', '<cmd> Lspsaga diagnostic_jump_prev <CR>', opts)
    -- -- 跳转到下一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
    -- nvim.api.nvim_set_keymap('n', ']g', '<cmd> Lspsaga diagnostic_jump_next <CR>', opts)

    -- 悬浮窗口上翻页，由 Lspsaga 提供
    -- nvim.api.nvim_set_keymap('i', '<A-i>', '<cmd> lua require('lspsaga.action').smart_scroll_with_saga(-1) <CR>', opts)
    -- 悬浮窗口下翻页，由 Lspsaga 提供
    -- nvim.api.nvim_set_keymap('i', '<A-k>', '<cmd> lua require('lspsaga.action').smart_scroll_with_saga(1) <CR>', opts)
end

-- 通用配置
local on_attach = function(client, bufnr)
    lsp_highlight_document(client)
    set_keymap(bufnr)
end

-- 增强 LSP 补全
local capabilities = nvim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true, }

-- 自动安装, 从nvim-lsp-installer插件中获取安装列表
local mason = require('configs.mason.init')
local servers = mason.servers

for _, lsp in pairs(servers) do
    local lsp_config = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities
    }

    -- 关闭<yamlls>关键字排序检测
    if lsp == 'yamlls' then
        lsp_config.settings = {
            yaml = {
                keyOrdering = false,
                schemas = {
                    kubernetes = "/*.yaml", -- Add the schema for gitlab piplines
                },
            }
        }
    end

    require('lspconfig')[lsp].setup(lsp_config)
end
