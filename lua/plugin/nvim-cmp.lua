vim.opt.completeopt = { "menu", "menuone", "noselect" }

local status_ok, from_vscode = pcall(require, "luasnip.loaders.from_vscode")
if not status_ok then
	return
end

from_vscode.lazy_load()

local status_ok1, cmp = pcall(require, "cmp")
if not status_ok1 then
	return
end

local status_ok2, luasnip = pcall(require, "luasnip")
if not status_ok2 then
	return
end
luasnip.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })

local status_ok3, lspkind = pcall(require, "lspkind")
if not status_ok3 then
	return
end

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	preselect = require("cmp").PreselectMode.None,
	completion = { completeopt = "menu,menuone,noselect" },
	experimental = { ghost_text = true },
	sources = {
		{
			name = "nvim_lsp",
			keyword_length = 3,
			priority = 10,
		},
		{
			name = "luasnip",
			option = {
				use_show_condition = true,
				show_autosnippets = true,
			},
			priority = 9,
		},
		{
			name = "nvim_lsp_signature_help",
			priority = 8,
		},
		{
			name = "nvim_lua",
			priority = 7,
		},
		{
			name = "buffer",
			keyword_length = 3,
			priority = 6,
		},
		{
			name = "path",
			priority = 5,
		},
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
			mode = "symbol_text",
			preset = "codicons",
		}),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),
		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),
		["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-j>"] = cmp.mapping.select_next_item(select_opts),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm( --[[ { select = true } ]]),
		["<C-d>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
})

local cmdline_mappings = {
	["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
	["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
	["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
	["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
	["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
	["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
	["<Tab>"] = cmp.mapping(function(fallback)
		local col = vim.fn.col(".") - 1
		if cmp.visible() then
			cmp.select_next_item()
		elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
			fallback()
		else
			cmp.complete()
		end
	end, { "i", "c" }),
}
table.insert({
	cmp.mapping.preset.cmdline(),
}, cmdline_mappings)

local tokens = { "?", "/" }
for idx = 1, #tokens do
	cmp.setup.cmdline(tokens[idx], {
		mapping = cmdline_mappings,
		sources = cmp.config.sources({
			{ name = "nvim_lsp_document_symbol" },
		}, {
			{ name = "buffer" },
		}, {
			{ name = "nvim_lua" },
		}),
	})
end

cmp.setup.cmdline(":", {
	mapping = cmdline_mappings,
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})
