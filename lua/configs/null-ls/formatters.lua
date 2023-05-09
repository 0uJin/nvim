local null_ls = require('null-ls')
local elements = {}

elements.python = {
    filetypes = { "python" },
    null_ls.builtins.formatting.autopep8,
}

-- ================================================ 返回通用元素 ================================================
return elements
