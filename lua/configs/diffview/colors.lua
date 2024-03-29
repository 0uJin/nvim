-- ################################################## 高亮配色 ##################################################
local nvim = vim

-- ================================================== 设置配色 ==================================================
-- 新增部份
nvim.api.nvim_set_hl(0, 'DiffAdd', { ctermbg = 'gray', bg = '#003f11' })
-- 修改部份
nvim.api.nvim_set_hl(0, 'DiffChange', { bg = '#243955' })
-- 删除部份
nvim.api.nvim_set_hl(0, 'DiffDelete', { fg = '#444444' })
-- 不相同文本内容
nvim.api.nvim_set_hl(0, 'DiffText', { bg = '#005f87' })
