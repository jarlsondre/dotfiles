return {
  'linux-cultist/venv-selector.nvim',
  -- No branch pin: the widely-copied `branch = "regexp"` is merged into main.
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-telescope/telescope.nvim',
  },
  ft = 'python',
  keys = {
    { '<leader>vs', '<cmd>VenvSelect<cr>', desc = "Select Python venv" },
  },
  opts = {
    search = {
      -- Find every venv under $HOME by its pyvenv.cfg marker instead of by
      -- name. Library/ stays excluded: enumerating CloudStorage can hang.
      home = {
        command = table.concat({
          '$FD -g pyvenv.cfg $HOME --max-depth 8 -HI -a --color never',
          '-E Library/ -E .Trash/ -E node_modules/ -E .git/ -E .cache/',
          '-E .local/ -E .platformio/',
          '-x echo {//}/bin/python',
        }, ' '),
      },
    },
    options = {
      notify_user_on_venv_activation = true,

      -- ruff/ty read $VIRTUAL_ENV once at startup, so restart them on venv
      -- change. The old clients are excluded from reuse rather than waited
      -- on: vim.lsp.start would otherwise "reuse" a client that is still
      -- shutting down, leaving the buffer with no LSP at all.
      on_venv_activate_callback = function()
        local servers = { 'ruff', 'ty' }

        local stopping = {}
        for _, name in ipairs(servers) do
          for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
            stopping[client.id] = true
            client:stop()
          end
        end

        local reuse_client = function(client, conf)
          return client.name == conf.name and not stopping[client.id]
              and not client:is_stopped()
        end
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == 'python' then
            for _, name in ipairs(servers) do
              -- copy: vim.lsp.config[name] is a shared cached table
              local config = vim.deepcopy(vim.lsp.config[name])
              if not config.root_dir and config.root_markers then
                config.root_dir = vim.fs.root(buf, config.root_markers)
              end
              vim.lsp.start(config, { bufnr = buf, reuse_client = reuse_client })
            end
          end
        end
      end,
    },
  },
}
