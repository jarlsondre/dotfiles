return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require('dap')

    -- Adapter for Python (debugpy)
    dap.adapters.python = {
      type = 'executable',
      command = 'python',
      args = { '-m', 'debugpy.adapter' },
    }
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        console = "integratedTerminal",
        justMyCode = false,
        pythonPath = function()
          -- Adds virtualenv if possible
          local venv_path = os.getenv("VIRTUAL_ENV")
          if venv_path then
            return venv_path .. '/bin/python'
          end
          return '/Users/jarl/.pyenv/shims/python'
        end,
      },
    }

    -- Adapter for Rust
    dap.adapters.lldb = {
      type = "server",
      port = "${port}",   -- DAP will automatically choose a free port
      executable = {
        command = "/Users/jarl/codelldb/extension/adapter/codelldb",
        args = { "--port", "${port}" },
      },
    }
    dap.configurations.rust = {
      {
        name = "main",
        type = "lldb",
        request = "launch",
        program = function()
          local bin = vim.fn.expand("%:t:r")
          return vim.fn.getcwd() .. "/target/debug/" .. bin
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    dap.configurations.cpp = {
      {
        name = "Launch C++ file",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    vim.fn.sign_define('DapBreakpoint', { text = '◆', texthl = '', linehl = '', numhl = '' })

    vim.keymap.set('n', '<F5>', function() require('dap').continue() end,
      { silent = true, desc = "DAP: start/continue debugging" })
    vim.keymap.set('n', '<F10>', function() require('dap').step_over() end,
      { silent = true, desc = "DAP: step over" })
    vim.keymap.set('n', '<F11>', function() require('dap').step_into() end,
      { silent = true, desc = "DAP: step into" })
    vim.keymap.set('n', '<F12>', function() require('dap').step_out() end,
      { silent = true, desc = "DAP: step out" })
    vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end,
      { silent = true, desc = "DAP: toggle breakpoint" })
    -- vim.api.nvim_set_keymap('n', '<Leader>B', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '<Leader>lp', "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { noremap = true, silent = true })

    vim.keymap.set('n', '<Leader>dc', function() require('dap').repl.open() end,
      { silent = true, desc = "DAP: open REPL (debug console)" })

    vim.keymap.set('n', '<Leader>rr', function() require('dap').run_last() end,
      { silent = true, desc = "DAP: rerun last debug session" })

    vim.keymap.set('n', '<Leader>dq', function()
      require('dap').terminate()
    end, { desc = "DAP: terminate session" })

    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = "DAP: hover info for value" })

    -- More in-depth information than hover
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end, { desc = "DAP: preview value" })

    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end, { desc = "DAP: show call stack" })

    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.sidebar(widgets.scopes, nil, 'leftabove 40vsplit').open()
    end, { desc = "DAP: show variable scopes" })
  end,
}
