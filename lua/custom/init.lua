vim.o.relativenumber = true
vim.api.nvim_set_keymap('n', '<leader>yy', ':normal! ggVG<CR><leader>c<CR>', {noremap = false, silent = true})

vim.api.nvim_set_keymap('n', '<leader>lp', ':normal! ggVGd"_dd<CR>:startinsert<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fz', ':Telescope current_buffer_fuzzy_find<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ko', ':Telescope lsp_document_symbols<CR>', {noremap = true, silent = true})


-- Add the 'add_instant_code' function
-- Add the lines above and below the current line
function add_lines()
  local line = vim.api.nvim_win_get_cursor(0)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(bufnr, line[1] - 1, line[1] - 1, false, {"let curr = Instant::now();"})
  vim.api.nvim_buf_set_lines(bufnr, line[1] + 1, line[1] + 1, false, {"println!(\"{:?}\", curr.elapsed());"})
  vim.cmd("normal! jw3l")
  vim.cmd('startinsert')
end
local function traverse_symbols_for_delete(symbols, current_line)
    for _, symbol in ipairs(symbols) do
        if symbol.kind == 12 then -- Assuming 12 is the kind for functions; might need adjustment
            local start_line = symbol.range.start.line + 1
            local end_line = symbol.range["end"].line + 1

            if current_line >= start_line and current_line <= end_line then
                -- Delete the function
                vim.cmd(start_line .. "," .. end_line .. "delete")
                return true
            end
        end

        -- If the symbol has children, traverse them
        if symbol.children then
            if traverse_symbols_for_delete(symbol.children, current_line) then
                return true
            end
        end
    end
    return false
end

_G.delete_current_function = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]

    -- Request document symbols from the LSP
    local params = { textDocument = vim.lsp.util.make_text_document_params() }
    local symbols = vim.lsp.buf_request_sync(bufnr, "textDocument/documentSymbol", params)

    for client_id, result in pairs(symbols) do
        if result and result.result then
            if traverse_symbols_for_delete(result.result, current_line) then
                return
            end
        end
    end

    vim.cmd("echo 'Not inside a function'")
end
-- Define the function to delete the current function

-- Bind the delete_current_function to <leader>df
vim.api.nvim_set_keymap('n', '<leader>df', ':lua delete_current_function()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cf', ':lua copy_current_function()<CR>', { noremap = true, silent = true })




-- Create a keymap for the 'add_lines' and 'move_cursor' functions
vim.api.nvim_set_keymap('n', '<leader>ti', ':lua add_lines()<CR>', {noremap = true, silent = true})

