"Plugins
call plug#begin('~/.vim/plugged')
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'preservim/nerdtree'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'frazrepo/vim-rainbow'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'edkolev/tmuxline.vim'

" LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'

" Themes
 "   Plug 'shaunsingh/nord.nvim'
  Plug 'arcticicestudio/nord-vim'

" Version Control
    Plug 'nvim-lua/plenary.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'tpope/vim-fugitive'


call plug#end()

set completeopt=menu,menuone,noselect
set nocompatible
filetype off
filetype plugin indent on
set number relativenumber
set hlsearch              " Highlight found searches
set hidden
set nobackup              " No auto backup
set noerrorbells
set nowrap
set noswapfile            " No swap
set nobackup
set nowritebackup
set signcolumn=yes
set cursorline
set splitright
set splitbelow
set t_Co=256              " Set if term supports 256 colors.
set clipboard=unnamedplus " Copy/paste between vim and other programs

set expandtab             " Use spaces instead of tab
set smarttab
set shiftwidth=2          " One tab == four spaces.
set tabstop=2            " One tab == four spaces.
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR> 


" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

colorscheme nord
let g:airline_theme = 'nord_minimal'
let g:nord_contrast = v:true
let g:nord_borders = v:true
let g:go_def_mapping_enabled = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let rainbow_active = 1

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:ctrlp_map = '<c-p>'

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
"i means that insert mode"
inoremap <UP> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
nnoremap <silent> <Tab>l :tabnext<CR>
nnoremap <silent> <Tab>h :tabprevious<CR>
nnoremap <silent> <Tab>n :tabnext<CR>
nnoremap <silent> <Tab>p :tabprevious<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
map <C-s> :source ~/.config/nvim/init.vim<CR>

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fgg <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>ps <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "java", "html", "css", "javascript", "php", "json" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
  indent = {
      enable = true
      }
}

require('telescope').setup{ 
    defaults = { 
        file_ignore_patterns = {"node_modules"} 
        },
    extensions = {
        fzf = {
            fuzzt = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
            }
        }
    
  }

require('telescope').load_extension('fzf')

require('lualine').setup{
    options = {
        theme = 'nord'},
        sections = {
            lualine_b= {'branch', 'diff', 'diagnostics'}
            }
    }

require('gitsigns').setup{
    keymaps ={
            ['<leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
            [']c'] = { expr = true, "&diff ? ']c': '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
            ['[c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},
    }

}

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig').gopls.setup{} 
  require('lspconfig').java_language_server.setup{} 
  require('lspconfig').dockerls.setup{} 
  require('lspconfig').yamlls.setup{} 
EOF
