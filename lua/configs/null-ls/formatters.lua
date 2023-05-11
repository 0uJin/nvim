local null_ls = require('null-ls')
local elements = {}

elements.python = {
    filetypes = { "python" },
    null_ls.builtins.formatting.autopep8.with({
        extra_args = { "--max-line-length=120" }
    }),
}

-- ================================================ 返回通用元素 ================================================
return elements
