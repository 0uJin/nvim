local status, null_ls = pcall(require, "null-ls")
if not status then
    return
end

local nvim = vim
local elements = {}

local lsp_formatting = function(bufnr)
    nvim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = nvim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
elements.on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        nvim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        nvim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

null_ls.setup()

-- ===================================================  代码格式化  ===================================================
local formatters = require('configs.null-ls.formatters')
-- 注册格式化器
for _, register in pairs(formatters) do
    null_ls.register(register)
end

-- ================================================ 返回通用元素 ================================================
return elements
