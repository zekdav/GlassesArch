local M = {}

local themes = { "poimandres", "minimal", "aura-dark" }
local current_index = 1

function M.set(name)
  for index, theme in ipairs(themes) do
    if theme == name then
      current_index = index
      break
    end
  end

  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify("Theme error: " .. err, vim.log.levels.ERROR, { title = "Colorscheme" })
    return
  end

  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NONE", bg = "NONE" })
  vim.api.nvim_set_hl(0, "VertSplit", { fg = "NONE", bg = "NONE" })
  vim.notify("Theme: " .. name, vim.log.levels.INFO, { title = "Colorscheme" })
end

function M.cycle()
  current_index = (current_index % #themes) + 1
  M.set(themes[current_index])
end

function M.select()
  vim.ui.select(themes, {
    prompt = "Select Colorscheme:",
  }, function(choice)
    if choice then
      M.set(choice)
    end
  end)
end

function M.apply_default()
  M.set("poimandres")
end

return M
