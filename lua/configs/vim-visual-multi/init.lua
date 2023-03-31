local nvim = vim

local vm_maps = {}
-- 输入
vm_maps['i'] = 'h'
-- 行首输入
vm_maps['I'] = 'H'
-- 查找选中的内容
vm_maps['Find Under'] = '<A-j>'
-- 查找下一个
vm_maps['Find Subword Under'] = '<A-j>'
-- 查找全部
vm_maps['Select All'] = '<A-l>'
-- 查找全部(可视模式)
vm_maps['Visual All'] = '<A-l>'
-- 多光标选择(向上)
-- vm_maps['Select Cursor Down'] = '<M-Down>'
-- 多光标选择(向下)
-- vm_maps['Select Cursor Up'] = '<M-Up>'
-- 多光标选择(向上)
vm_maps['Select Cursor Down'] = '<A-k>'
-- 多光标选择(向下)
vm_maps['Select Cursor Up'] = ''
-- 撤销
vm_maps['Undo'] = ''
-- 重做
vm_maps['Redo'] = ''
-- 禁用<Tab>键
vm_maps['I Next'] = ''
-- 禁用<Shift><Tab>键
vm_maps['I Prev'] = ''
-- 禁用<Enter>键
vm_maps['Toggle Mappings'] = ''
-- 禁用<Space>键
vm_maps['Toggle Single Region'] = ''
-- 按键初始化
nvim.g.VM_maps  = vm_maps

-- 关闭默认映射
nvim.g.VM_default_mappings = 0
-- 按键重新映射
nvim.g.VM_custom_motions = {i= 'k', k= 'j', j= 'h', h= 'i', H= 'I', I= '$'}
