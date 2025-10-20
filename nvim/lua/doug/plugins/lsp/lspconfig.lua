return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- Format on save
				if ev.data and ev.data.client_id then
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client and client.supports_method("textDocument/formatting") then
						local format_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
						vim.api.nvim_clear_autocmds({ group = format_group, buffer = ev.buf })
					end
				end
				local mappings = {
					{ "n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
					{ "n", "gD", vim.lsp.buf.declaration, "Go to declaration" },
					{ "n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions" },
					{ "n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
					{
						"n",
						"gt",
						"<cmd>Telescope lsp_type_definitions<CR>",
						"Show LSP type definitions",
					},
					{
						{ "n", "v" },
						"<leader>ca",
						vim.lsp.buf.code_action,
						"See available code actions",
					},
					{ "n", "<leader>rn", vim.lsp.buf.rename, "Smart rename" },
					{ "n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
					{ "n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics" },
					{
						"n",
						"[d",
						vim.diagnostic.goto_prev,
						"Go to previous diagnostic",
					},
					{ "n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic" },
					{ "n", "K", vim.lsp.buf.hover, "Show documentation" },
					{ "n", "<leader>rs", ":LspRestart<CR>", "Restart LSP" },
				}

				for _, map in ipairs(mappings) do
					opts.desc = map[4]
					keymap.set(map[1], map[2], map[3], opts)
				end
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "󰠠",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = { "lua_ls", "pyright", "clangd", "html", "cssls", "emmet_ls", "svelte", "graphql" },
		})

		local servers = mason_lspconfig.get_installed_servers()

		for _, server in ipairs(servers) do
			local opts = {
				capabilities = capabilities,
			}

			if server == "lua_ls" then
				opts.settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				}
			elseif server == "emmet_ls" then
				opts.filetypes =
					{ "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" }
			elseif server == "graphql" then
				opts.filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" }
			elseif server == "svelte" then
				opts.on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end
			end

			lspconfig[server].setup(opts)
		end
	end,
}
