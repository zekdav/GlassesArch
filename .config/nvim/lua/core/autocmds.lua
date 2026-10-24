local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general_group = augroup("GeneralAutocmds", { clear = true })
local yank_group = augroup("YankHighlight", { clear = true })
local tree_group = augroup("NeoTreeDirOpen", { clear = true })
local clean_separators = augroup("CleanSeparators", { clear = true })

autocmd({ "VimEnter", "ColorScheme" }, {
  group = clean_separators,
  callback = function()
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NONE", bg = "NONE" })
    vim.api.nvim_set_hl(0, "VertSplit", { fg = "NONE", bg = "NONE" })
  end,
})

autocmd("VimEnter", {
  group = tree_group,
  once = true,
  callback = function(event)
    local is_dir = vim.fn.isdirectory(event.file) == 1
    if is_dir then
      local cur_buf = event.buf ~= 0 and event.buf or vim.api.nvim_get_current_buf()
      vim.cmd.cd(event.file)
      require("neo-tree.command").execute({
        action = "focus",
        source = "filesystem",
        position = "right",
        dir = event.file,
      })
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(cur_buf) and vim.api.nvim_buf_get_name(cur_buf) == event.file then
          vim.api.nvim_buf_delete(cur_buf, { force = true })
        end
      end)
    end
  end,
})

autocmd("VimEnter", {
  group = general_group,
  once = true,
  callback = function()
    vim.defer_fn(function()
      require("core.themes").apply_default()
    end, 1)
  end,
})

autocmd("TextYankPost", {
  group = yank_group,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

autocmd("BufReadPost", {
  group = general_group,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd("FileType", {
  group = general_group,
  pattern = {
    "help",
    "man",
    "qf",
    "notify",
    "lspinfo",
    "checkhealth",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true, desc = "Close window" })
  end,
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = general_group,
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

autocmd("BufWritePre", {
  group = general_group,
  pattern = "*",
  callback = function()
    local pos = vim.fn.getpos(".")
    pcall(vim.cmd, [[%s/\s\+$//e]])
    vim.fn.setpos(".", pos)
  end,
})


-- 1. Автооткрытие Neo-tree справа при пустом запуске
local startup_tree_group = vim.api.nvim_create_augroup("AutoOpenNeoTree", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = startup_tree_group,
  nested = true,
  callback = function()
    if vim.fn.argc() ~= 0 then return end
    local buf = vim.api.nvim_get_current_buf()
    local is_empty = vim.api.nvim_buf_get_name(buf) == ""
      and vim.bo[buf].buftype == ""
      and vim.api.nvim_buf_line_count(buf) <= 1
      and (vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or "") == ""

    if is_empty then
      pcall(function()
        require("neo-tree.command").execute({
          action = "show",
          source = "filesystem",
          position = "right",
        })
      end)
    end
  end,
})

-- 2. Мгновенный выход по :wq / :q без задержек анимации
local fast_exit_group = vim.api.nvim_create_augroup("FastExitOnQuit", { clear = true })
vim.api.nvim_create_autocmd({ "QuitPre", "VimLeavePre" }, {
  group = fast_exit_group,
  callback = function()
    vim.g.minianimate_disable = true
    pcall(function()
      if package.loaded["smear_cursor"] then
        require("smear_cursor").enabled = false
      end
    end)
    pcall(function()
      if package.loaded["notify"] then
        require("notify").dismiss({ silent = true, pending = false })
      end
    end)
    pcall(function()
      if package.loaded["snacks"] then
        require("snacks").animate.disable()
      end
    end)
  end,
})
