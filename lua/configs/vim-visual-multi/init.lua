local nvim = vim

-- 按键初始化
nvim.g.VM_maps  = {}
-- 按键重新映射
nvim.g.VM_custom_motions = {i= 'k', k= 'j', j= 'h', h= 'i', H= 'I', I= '$'}
-- 输入
nvim.g.VM_maps['i'] = 'h'
-- 行首输入
nvim.g.VM_maps['I'] = 'H'
-- 查找选中的内容
nvim.g.VM_maps['Find Under'] = '<A-j>'
-- 查找下一个
nvim.g.VM_maps['Find Subword Under'] = '<A-j>'
-- 查找全部
nvim.g.VM_maps['Select All'] = '<A-l>'
-- 查找全部(可视模式)
nvim.g.VM_maps['Visual All'] = '<A-l>'
-- 多光标选择(向上)
-- nvim.g.VM_maps['Select Cursor Down'] = '<M-Down>'
-- 多光标选择(向下)
-- nvim.g.VM_maps['Select Cursor Up'] = '<M-Up>'
-- 多光标选择(向上)
nvim.g.VM_maps['Select Cursor Down'] = '<A-k>'
-- 多光标选择(向下)
nvim.g.VM_maps['Select Cursor Up'] = ''
-- 撤销
nvim.g.VM_maps['Undo'] = ''
-- 重做
nvim.g.VM_maps['Redo'] = ''
-- 禁用<Tab>键
nvim.g.VM_maps['I Next'] = ''
-- 禁用<Shift><Tab>键
nvim.g.VM_maps['I Prev'] = ''
-- 禁用<Enter>键
nvim.g.VM_maps['Toggle Mappings'] = ''
-- 禁用<Space>键
nvim.g.VM_maps['Toggle Single Region'] = ''
-- 关闭默认映射
nvim.g.VM_default_mappings = 0

