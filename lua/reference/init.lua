local M = {}

function M.open(payload)
  local text = vim.base64.decode(payload)

  vim.schedule(function()
    vim.cmd.stopinsert()

    local buf = vim.api.nvim_create_buf(false, true)

    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].swapfile = false
    vim.bo[buf].filetype = "sh"

    local lines = vim.split(
      text:gsub("\n$", ""),
      "\n",
      { plain = true }
    )

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modified = false

    vim.api.nvim_open_win(buf, true, {
      split = "above",
      win = 0,
    })

    vim.keymap.set("n", "q", "<cmd>close<CR>", {
      buffer = buf,
      silent = true,
    })
  end)

  return ""
end

return M
