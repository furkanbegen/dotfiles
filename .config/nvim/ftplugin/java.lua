local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local config = {
  cmd = {
    'java', 
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-noverify',
    '-Xms1g',
    '-jar', '/usr/share/java/jdt/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/usr/share/java/jdt/config_linux/',
    '-data', vim.fn.expand('~/.cache/jdtls-workspace') .. workspace_dir, 
  },

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  capabilities = capabilities

}
require('jdtls').start_or_attach(config)

vim.api.nvim_set_keymap('n', '<leader>lA', '<cmd>lua requre(\'jdtls\').code_action()<CR>', {silent = true})
