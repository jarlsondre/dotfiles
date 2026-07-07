-- Snippets (luasnip + vimtex completion) are skipped over SSH to keep remote
-- sessions light. `cond = false` means lazy.nvim never adds them to the rtp.
local in_ssh = require("util.env").in_ssh()

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',

  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    { 'saadparwaiz1/cmp_luasnip', cond = not in_ssh },
    {
      'L3MON4D3/LuaSnip',
      cond = not in_ssh,
      build = vim.fn.executable('make') == 1 and 'make install_jsregexp' or nil,
    },
  },

  config = function()
    local cmp = require('cmp')

    local luasnip
    if not in_ssh then
      luasnip = require('luasnip')
      luasnip.config.setup {
        enable_autosnippets = true,
        region_check_events = "CursorMoved,CursorMovedI",
        delete_check_events = "TextChanged,InsertLeave",
      }
      -- Lua snippets (snippets/*.lua) and snipmate snippets (snippets/*.snippets)
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
      require("luasnip.loaders.from_snipmate").load()
    end

    local sources = {
      { name = 'nvim_lsp' },
      { name = 'path' },
    }
    if not in_ssh then
      table.insert(sources, { name = 'luasnip' })
      table.insert(sources, { name = 'vimtex' })
    end

    cmp.setup {
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.order,
        },
      },
      -- Snippet expansion: disabled completely in SSH
      snippet = not in_ssh and {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      } or nil,

      completion = { completeopt = 'menu,menuone,noinsert' },

      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif luasnip and luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<C-g>'] = cmp.mapping({
          i = function() if cmp.visible() then cmp.abort() else cmp.complete() end end,
          c = function() if cmp.visible() then cmp.close() else cmp.complete() end end,
        }),
      }),

      sources = sources,
    }
  end,
}
