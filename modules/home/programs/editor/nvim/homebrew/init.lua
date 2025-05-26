local function set_normal_keymap(lh, rh)
  local opts = { noremap = true, silent = true }

  vim.keymap.set('n', lh, rh, opts)
end

local function set_basic_keymaps()
  set_normal_keymap('<Leader>dd', function() vim.diagnostic.open_float({scope='line'}) end)
end

local function set_tree_keymaps()
  local api = require "nvim-tree.api"
  set_normal_keymap('<Leader>e', api.tree.toggle)
end

local function set_telescope_keymaps()
  local builtin = require('telescope.builtin')
  set_normal_keymap('<Leader>ff', builtin.find_files)
  set_normal_keymap('<Leader>fg', builtin.live_grep)
  set_normal_keymap('<Leader>fb', builtin.buffers)
  set_normal_keymap('<Leader>fh', builtin.help_tags)
  set_normal_keymap('<Leader>gs', builtin.git_status)
end

local function setup_lsps(lspconfig, cmp)
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      --['<C-b>'] = cmp.mapping.scroll_docs(-4),
      --['<C-f>'] = cmp.mapping.scroll_docs(4),
      --['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = "nil" },
      { name = "neorg" },
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
      })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources(
      {
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      },
      {
        { name = 'buffer' },
      }
    )
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
        { name = 'cmdline' }
      })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  lspconfig['lua_ls'].setup { capabilities = capabilities }
  lspconfig['rust_analyzer'].setup { capabilities = capabilities }
  lspconfig['pylsp'].setup { capabilities = capabilities }
  lspconfig['jdtls'].setup { capabilities = capabilities }
  lspconfig['clangd'].setup { capabilities = capabilities }
  lspconfig['nil_ls'].setup { capabilities = capabilities }
  lspconfig['ts_ls'].setup { capabilities = capabilities }

  local dap = require("dap")

  dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
      command = os.getenv('CODELLDB'),
      args = {"--port", "${port}"},
    }
  }

  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
  dap.configurations.c = dap.configurations.rust
  dap.configurations.cpp = dap.configurations.rust
  local dapui = require("dapui")
  dapui.setup({})
  require("nvim-dap-virtual-text").setup({})

  set_normal_keymap('<Leader>de', function() dap.continue() end)
  set_normal_keymap('<Leader>dj', function() dap.step_over() end)
  set_normal_keymap('<Leader>di', function() dap.step_into() end)
  set_normal_keymap('<Leader>do', function() dap.step_out() end)
  set_normal_keymap('<Leader>db', function() dap.toggle_breakpoint() end)
  set_normal_keymap('<Leader>dl', function() dap.run_last() end)
  set_normal_keymap('<Leader>du', function() dapui.toggle() end)
end

local function set_global_options()
  vim.cmd('set nocompatible')
  vim.g.mapleader = ' '
  vim.cmd('set expandtab')
  vim.cmd('set shiftwidth=4')
  vim.cmd('set tabstop=4')
  vim.wo.number = true
  vim.wo.relativenumber = true

  vim.cmd('set colorcolumn=120')

  set_tree_keymaps()
  set_telescope_keymaps()
  set_basic_keymaps()
  vim.opt.conceallevel = 2
  vim.cmd('colorscheme gruvbox-baby')
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

--require("mason").setup()
--require("mason-lspconfig").setup({
--  ensure_installed = { 'lua_ls', 'rust_analyzer',  'pylsp', 'jdtls', 'clangd', 'rnix', 'ts_ls' }
--})

set_global_options()
require('gitsigns').setup()
require("lualine").setup()
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --[[disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    ]] 
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  }
}
require("nvim-tree").setup()
vim.wo.foldlevel = 99
vim.wo.conceallevel = 2
require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.keybinds"] = {
      config = {
        default_keybinds = false,
      }
    },
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/Documents/notes",
        },
        default_workspace = "notes",
      },
    },
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.integrations.nvim-cmp"] = {},
    --[[
    ["external.templates"] = {
      templates_dir = "~/Documents/norg/templates",
      -- default_subcommand = "add", -- or "fload", "load"
      -- keywords = { -- Add your own keywords.
      --   EXAMPLE_KEYWORD = function ()
      --     return require("luasnip").insert_node(1, "default text blah blah")
      --   end,
      -- },
      -- snippets_overwrite = {},
    }
    ]]
  }
})

local function parse_datetime(dt)
  return os.time({
    year = tonumber(dt:sub(1, 4)),
    month = tonumber(dt:sub(6, 7)),
    day = tonumber(dt:sub(9, 10)),
    hour = tonumber(dt:sub(12, 13)),
    min = tonumber(dt:sub(15, 16)),
    sec = tonumber(dt:sub(18, 19)),
  })
end

local function render_elapsed()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local ns = vim.api.nvim_create_namespace("elapsed_namespace")
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  for i, line in ipairs(lines) do
    -- Match with optional second datetime
    local col_start, col_end = line:find("<<%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d%s*::?%s*[%d%-: ]*>>")
    if col_start and col_end then
      local dt1, dt2 = line:match("<<(%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d)%s*::%s*(%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d)>>")
      if not dt1 then
        -- Try matching only one datetime if the second is missing
        dt1 = line:match("<<(%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d)%s*::?%s*>>")
      end
      if dt1 then
        local t1 = parse_datetime(dt1)
        local t2 = dt2 and parse_datetime(dt2) or os.time()
        local diff = os.difftime(t2, t1)
        if diff >= 0 then
          local days = math.floor(diff / 86400)
          local hours = math.floor((diff % 86400) / 3600)
          local minutes = math.floor((diff % 3600) / 60)

          local parts = {}
          if days > 0 then table.insert(parts, days .. "d") end
          if hours > 0 then table.insert(parts, hours .. "h") end
          if minutes > 0 then table.insert(parts, minutes .. "m") end
          if #parts == 0 then table.insert(parts, "0m") end
          local text = table.concat(parts, " ")

          -- Conceal with extmark
          vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, col_start - 1, {
            end_col = col_end,
            conceal = "⏱", -- optional
          })

          -- Virtual text (shown at end of line)
          vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, 0, {
            virt_text = {{text, "Normal"}},
            virt_text_pos = "eol",
            hl_mode = "combine",
          })
        end
      end
    end
  end
end

local function insert_date_time()
  local date = os.date("%Y-%m-%d %H:%M:%S")
  vim.api.nvim_put({date}, 'c', true, true)
end

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "norg",
  callback = function()
    vim.keymap.set("n", "<Leader>td", "<Plug>(neorg.qol.todo-items.todo.task-done)", { buffer = true })
    vim.keymap.set("n", "<Leader>tu", "<Plug>(neorg.qol.todo-items.todo.task-undone)", { buffer = true })
    vim.keymap.set("n", "<Leader>tp", "<Plug>(neorg.qol.todo-items.todo.task-pending)", { buffer = true })
    vim.keymap.set("n", "<Leader>th", "<Plug>(neorg.qol.todo-items.todo.task-on_hold)", { buffer = true })
    vim.keymap.set("n", "<Leader>tc", "<Plug>(neorg.qol.todo-items.todo.task-cancelled)", { buffer = true })
    vim.keymap.set("n", "<Leader>tr", "<Plug>(neorg.qol.todo-items.todo.task-recurring)", { buffer = true })
    vim.keymap.set("n", "<Leader>ti", "<Plug>(neorg.qol.todo-items.todo.task-important)", { buffer = true })
    vim.keymap.set("n", "<,", "<Plug>(neorg.promo.demote)", { buffer = true }) -- demote non recursively
    vim.keymap.set("n", "<<", "<Plug>(neorg.promo.demote.nested)", { buffer = true }) -- demote recursively
    vim.keymap.set("n", ">.", "<Plug>(neorg.promo.promote)", { buffer = true }) -- promote non recursively
    vim.keymap.set("n", ">>", "<Plug>(neorg.promo.promote.nested)", { buffer = true }) -- promote recursively
    vim.keymap.set("n", "<Leader>id", "<Plug>(neorg.tempus.insert-date)", { buffer = true }) -- insert date reference
    vim.keymap.set("n", "<Leader>in", function ()
      insert_date_time()
    end, { buffer = true }) -- insert current date literal
    vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true }) -- follow link
    vim.keymap.set("n", "<Leader>nn", "<Plug>(neorg.dirman.new-note)", { buffer = true }) -- new note
    vim.keymap.set("n", "<Leader>r", function ()
      render_elapsed()
    end,
      { buffer = true })
  end,
})

local timers = {}
local function start_timer_for_buf(bufnr)
  if timers[bufnr] then return end  -- prevent duplicate timers

  local timer = vim.loop.new_timer()
  timer:start(0, 60000, vim.schedule_wrap(function()
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_call(bufnr, function()
        render_elapsed()
      end)
    else
      timer:stop()
      timer:close()
      timers[bufnr] = nil
    end
  end))

  timers[bufnr] = timer
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  pattern = "*.norg",
  callback = function(args)
    local bufnr = args.buf
    render_elapsed()
    start_timer_for_buf(bufnr)
  end,
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "lua", "nix" },
  callback = function ()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})
setup_lsps(require("lspconfig"), require("cmp"))
