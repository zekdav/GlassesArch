local capabilities = require("cmp_nvim_lsp").default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

vim.diagnostic.config({
  virtual_text = {
    enabled = true,
    spacing = 4,
    prefix = "●",
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
})

for type, icon in pairs({ Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
    end

    map("gd", vim.lsp.buf.definition, "LSP definition")
    map("gD", vim.lsp.buf.declaration, "LSP declaration")
    map("gi", vim.lsp.buf.implementation, "LSP implementation")
    map("gr", vim.lsp.buf.references, "LSP references")
    map("gt", vim.lsp.buf.type_definition, "LSP type definition")
    map("K", vim.lsp.buf.hover, "LSP hover")
    map("<C-k>", vim.lsp.buf.signature_help, "LSP signature")
    map("<leader>rn", vim.lsp.buf.rename, "LSP rename")
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, buffer = bufnr, desc = "LSP code action" })
    map("<leader>ld", vim.diagnostic.open_float, "LSP diagnostic")
    map("[d", function()
      if vim.diagnostic.jump then
        vim.diagnostic.jump({ count = -1 })
      else
        vim.diagnostic.goto_prev()
      end
    end, "LSP prev diagnostic")
    map("]d", function()
      if vim.diagnostic.jump then
        vim.diagnostic.jump({ count = 1 })
      else
        vim.diagnostic.goto_next()
      end
    end, "LSP next diagnostic")
    map("<leader>lf", function()
      local ok, conform = pcall(require, "conform")
      if ok then
        conform.format({ bufnr = bufnr, async = true, lsp_fallback = true })
      else
        vim.lsp.buf.format({ bufnr = bufnr, async = true })
      end
    end, "LSP format")

    if client and client.server_capabilities.documentHighlightProvider then
      local group = vim.api.nvim_create_augroup("LspHL_" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd("CursorHold", { group = group, buffer = bufnr, callback = vim.lsp.buf.document_highlight })
      vim.api.nvim_create_autocmd("CursorMoved", { group = group, buffer = bufnr, callback = vim.lsp.buf.clear_references })
    end
  end,
})

local servers = {
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=never",
      "--completion-style=detailed",
      "--fallback-style=Google",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
  },
  omnisharp = {
    cmd = { vim.fn.executable("OmniSharp") == 1 and "OmniSharp" or "omnisharp" },
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
    settings = {
      FormattingOptions = {
        EnableEditorConfigSupport = true,
      },
      RoslynExtensionsOptions = {
        EnableAnalyzersSupport = true,
        EnableImportCompletion = true,
      },
    },
  },
  csharp_ls = {
    filetypes = { "cs" },
    init_options = {
      AutomaticWorkspaceInit = true,
    },
  },
  jdtls = {
    settings = {
      java = {
        eclipse = { downloadSources = true },
        maven = { downloadSources = true },
        inlayHints = { parameterNames = { enabled = "all" } },
      },
    },
  },
  cssls = {
    settings = {
      css = { validate = true, lint = { unknownAtRules = "ignore" } },
      less = { validate = true },
      scss = { validate = true },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },
}

for name, config in pairs(servers) do
  config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
  if vim.lsp.config then
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
  else
    local ok, lspconfig = pcall(require, "lspconfig")
    if ok then
      lspconfig[name].setup(config)
    end
  end
end

-- Изоляция bqls (BigQuery LSP), чтобы он не падал на обычных .sql файлах
if vim.lsp and vim.lsp.config then
  vim.lsp.config("bqls", {
    filetypes = { "bigquery" },
  })
end
