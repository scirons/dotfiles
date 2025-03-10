local autocmd = vim.api.nvim_create_autocmd

-- Remove trailing spaces and newlines before saving
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local currPos = vim.api.nvim_win_get_cursor(0) -- Save cursor position
    vim.cmd([[%s/\s\+$//e]]) -- Remove trailing spaces
    vim.cmd([[%s/\n\+\%$//e]]) -- Remove trailing newlines
    vim.api.nvim_win_set_cursor(0, currPos) -- Restore cursor position
  end,
})

-- Ensure newline at EOF for C/C++ files
autocmd("BufWritePre", {
  pattern = "*.[ch]",
  command = [[%s/\%$/\r/e]],
})
