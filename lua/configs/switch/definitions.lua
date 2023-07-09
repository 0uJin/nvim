-- ################################################## 字典定义 ##################################################
local elements = {}
elements.switch_custom_definitions = { {} }

-- -------------------------------------------------- 代码相关 --------------------------------------------------
table.insert(elements.switch_custom_definitions, { '==', '!=' })
table.insert(elements.switch_custom_definitions, { '&&', '||' })
table.insert(elements.switch_custom_definitions, { 'true', 'false' })
table.insert(elements.switch_custom_definitions, { 'True', 'False' })
-- -------------------------------------------------- 数值转换 --------------------------------------------------
table.insert(elements.switch_custom_definitions, {'min', 'max'})
table.insert(elements.switch_custom_definitions, {'Min', 'Max'})
table.insert(elements.switch_custom_definitions, {'second', 'minute', 'hour'})
table.insert(elements.switch_custom_definitions, {'day', 'week', 'month', 'year'})
table.insert(elements.switch_custom_definitions, {'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'})
table.insert(elements.switch_custom_definitions, {'2006-01-02 15:04:05', 'yyyy-MM-dd HH:mm:ss'})
-- -------------------------------------------------- 常用转换 --------------------------------------------------
table.insert(elements.switch_custom_definitions, {'self', 'repl'})
table.insert(elements.switch_custom_definitions, {'add', 'sub'})
table.insert(elements.switch_custom_definitions, {'Add', 'Del', 'Update'})
table.insert(elements.switch_custom_definitions, {'increase', 'decrease'})
table.insert(elements.switch_custom_definitions, {'open', 'close'})
table.insert(elements.switch_custom_definitions, {'set', 'get'})
table.insert(elements.switch_custom_definitions, {'Set', 'Get'})
table.insert(elements.switch_custom_definitions, {'read', 'write'})
table.insert(elements.switch_custom_definitions, {'create', 'remove'})
table.insert(elements.switch_custom_definitions, {'master', 'slave'})
table.insert(elements.switch_custom_definitions, {'in', 'out'})
table.insert(elements.switch_custom_definitions, {'end', 'start'})
table.insert(elements.switch_custom_definitions, {'enable', 'disable'})
table.insert(elements.switch_custom_definitions, {'success', 'fail'})
table.insert(elements.switch_custom_definitions, {'valid', 'expire'})
table.insert(elements.switch_custom_definitions, {'debug', 'info', 'warn', 'error', 'fatal'})
-- -------------------------------------------------- 向量转换 --------------------------------------------------
table.insert(elements.switch_custom_definitions, {'left', 'right'})
table.insert(elements.switch_custom_definitions, {'top', 'bottom'})
table.insert(elements.switch_custom_definitions, {'width', 'height'})
table.insert(elements.switch_custom_definitions, {'next', 'previous'})
table.insert(elements.switch_custom_definitions, {'prefix', 'suffix'})
table.insert(elements.switch_custom_definitions, {'horizontal', 'vertical'})
-- -------------------------------------------------- 系统变量 --------------------------------------------------
table.insert(elements.switch_custom_definitions, {'linux', 'windows', 'darwin'})
table.insert(elements.switch_custom_definitions, {'amd64', 'arm64'})

-- ================================================ 返回通用元素 ================================================
return elements
