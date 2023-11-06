local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)

local function traverse_symbols(symbols, current_line)
    for _, symbol in ipairs(symbols) do
        if symbol.kind == 12 then -- Assuming 12 is the kind for functions; might need adjustment
            local start_line = symbol.range.start.line + 1
            local end_line = symbol.range["end"].line + 1

            if current_line >= start_line and current_line <= end_line then
                -- Yank the function
                vim.cmd(start_line .. "," .. end_line .. "yank")
                -- Use osc52 to copy to system clipboard
                require('osc52').copy(vim.fn.getreg('"'))
                return true
            end
        end

        -- If the symbol has children, traverse them
        if symbol.children then
            if traverse_symbols(symbol.children, current_line) then
                return true
            end
        end
    end
    return false
end

_G.copy_current_function = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]

    -- Request document symbols from the LSP
    local params = { textDocument = vim.lsp.util.make_text_document_params() }
    local symbols = vim.lsp.buf_request_sync(bufnr, "textDocument/documentSymbol", params)

    for client_id, result in pairs(symbols) do
        if result and result.result then
            if traverse_symbols(result.result, current_line) then
                return
            end
        end
    end

    vim.cmd("echo 'Not inside a function'")
end


require('leap').add_default_mappings()

