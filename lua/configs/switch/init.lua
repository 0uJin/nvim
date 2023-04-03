local nvim = vim
local definitions = require('configs.switch.definitions')

-- 转换快捷键
nvim.g.switch_mapping = '!'
-- 转换数组, 会在同一数组内循环转换
nvim.g.switch_custom_definitions = definitions.switch_custom_definitions

