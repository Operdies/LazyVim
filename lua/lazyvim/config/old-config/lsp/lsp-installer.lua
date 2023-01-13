local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local servers = {
	"sumneko_lua",
	"cssls",
	--[[ "clangd", ]]
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"omnisharp",
	"gopls",
    --[[ "golangci_lint_ls", ]]
    "marksman"
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local function ensureInstalled(servers)
  local installed = lsp_installer.get_installed_servers()
  local installedMap = {}
  for _, v in pairs(installed) do 
    installedMap[v.name] = true
  end
  for _, server in pairs(servers) do 
    if installedMap[server] == nil then 
      lsp_installer.install(server)
    end
  end
end
ensureInstalled(servers)

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	if server == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "omnisharp" then
		local omnisharp_opts = require("user.lsp.settings.omnisharp")
		opts = vim.tbl_deep_extend("force", omnisharp_opts, opts)
	end

	lspconfig[server].setup(opts)
end
