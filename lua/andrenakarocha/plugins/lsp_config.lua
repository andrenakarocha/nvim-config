return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Helper to set up simple servers
			local servers = { "lua_ls", "ts_ls", "prismals", "html", "cssls", "sqlls" }

			for _, server in ipairs(servers) do
				vim.lsp.config[server] = { capabilities = capabilities }
			end

			-- Python (Pyright)
			vim.lsp.config.pyright = {
				capabilities = capabilities,
				settings = { python = { analysis = { typeCheckingMode = "basic" } } },
			}

			-- Angular
			vim.lsp.config.angularls = {
				capabilities = capabilities,
				root_dir = function(fname)
					return vim.fs.root(fname, { "angular.json", "project.json" }) or vim.fn.getcwd()
				end,
			}

			-- Roslyn
			vim.lsp.config("roslyn", {
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
				},
			})

			-- 2. ENABLE SERVERS
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("prismals")
			vim.lsp.enable("html")
			vim.lsp.enable("cssls")
			vim.lsp.enable("sqlls")
			vim.lsp.enable("pyright")
			vim.lsp.enable("angularls")

			-- 3. KEYMAPS (LspAttach Event)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local opts = { buffer = args.buf }

					-- Diagnostics
					vim.diagnostic.config({ virtual_text = true })

					-- Mappings
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})
		end,
	},
	{
		"seblyng/roslyn.nvim",
		opts = {},
	},
	{
		"mason-org/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"omnisharp",
				"angularls",
				"html",
				"cssls",
				"sqlls",
				"prismals",
				"pyright",
			},
		},
	},
}
