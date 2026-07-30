return {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
        vim.g.molten_output_win_max_height = 30 -- also raise image.nvim's max_height; both clamp plots
        vim.g.molten_auto_open_output = true    -- float opens on cursor-into-cell; does not take focus
        vim.g.molten_wrap_output = true
        vim.g.molten_virt_text_output = false   -- float only; no inline virtual text
        vim.g.molten_virt_lines_off_by_1 = false -- markdown-only (covers the closing ```)
        vim.g.molten_image_provider = "image.nvim" -- without this, plots are silently dropped
        vim.g.molten_image_location = "float"   -- virt text is off, so render plots in the float
        vim.g.molten_output_virt_lines = true   -- pad the buffer so the float doesn't cover the next # %%
        vim.g.molten_cover_empty_lines = true   -- anchor output below the last line of code, not after trailing blanks
    end,
    config = function()
        local cell = [[^#\s*%%]] -- matches "# %%" (and "#%%") cell delimiters

        -- Initialize one kernel and wait for it; otherwise each queued
        -- evaluation prompts for -- and launches -- its own kernel.
        local function with_kernel(fn)
            local ok, kernels = pcall(vim.fn.MoltenRunningKernels, true)
            if ok and type(kernels) == "table" and #kernels > 0 then
                fn()
                return
            end
            vim.api.nvim_create_autocmd("User", {
                pattern = "MoltenKernelReady",
                once = true,
                callback = function() fn() end,
            })
            vim.cmd("MoltenInit")
        end

        -- Evaluate the cell the cursor is currently inside.
        local function eval_cell()
            local start = vim.fn.search(cell, "bcnW")
            start = start == 0 and 1 or start + 1
            local finish = vim.fn.search(cell, "nW")
            finish = finish == 0 and vim.fn.line("$") or finish - 1
            if finish < start then return end
            -- EvaluateRange bakes the line numbers in; EvaluateVisual re-reads
            -- the marks after molten's kernel prompt, by which point they're stale.
            vim.fn.MoltenEvaluateRange(start, finish)
        end

        -- Run every cell top to bottom.
        local function eval_all()
            local view = vim.fn.winsaveview()
            vim.cmd("keepjumps normal! gg")
            local line = vim.fn.search(cell, "cW")
            while line ~= 0 do
                eval_cell()
                line = vim.fn.search(cell, "W")
            end
            vim.fn.winrestview(view)
        end

        local function run_cell() with_kernel(eval_cell) end
        local function run_all() with_kernel(eval_all) end

        -- No visibility query exists, so track it with a flag; auto_open_output
        -- must follow it or the float reopens on the next cursor move.
        local output_shown = true
        local function toggle_output()
            output_shown = not output_shown
            pcall(vim.fn.MoltenUpdateOption, "auto_open_output", output_shown)
            pcall(vim.cmd, output_shown and "MoltenShowOutput" or "MoltenHideOutput")
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            group = vim.api.nvim_create_augroup("molten_keys", { clear = true }),
            callback = function(ev)
                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
                end
                map("n", "<leader>mi", ":MoltenInit<CR>", "Molten: init kernel")
                map("n", "<leader>mr", run_cell, "Molten: run cell")
                map("v", "<leader>mr", ":<C-u>MoltenEvaluateVisual<CR>", "Molten: run selection")
                map("n", "<leader>ma", run_all, "Molten: run all cells")
                map("n", "<leader>mt", toggle_output, "Molten: toggle output")
                map("n", "]h", function() vim.fn.search(cell, "W") end, "Molten: next cell")
                map("n", "[h", function() vim.fn.search(cell, "bW") end, "Molten: prev cell")
            end,
        })
    end,
}
