vim.g.mapleader = " "
vim.g.localmapleader = " "
local map = vim.api.nvim_set_keymap

local cycle_next = "<CMD>BufferLineCyclePrev<CR>"
local cycle_prev = "<CMD>BufferLineCycleNext<CR>"
local close_other_buffers = "<CMD>BufferLineCloseLeft<CR><CMD>BufferLineCloseRight<CR>"
local close_current_buffer = "<CMD>BufDel<CR>"
map("n", "<Space>", "", {})
map("n", "<F1>", "", {})
map("n", "Q", "", {})
map("n", "<ESC>", "<CMD>noh<CR>", { silent = true })
map("n", "<A-,>", cycle_next, { silent = true })
map("n", "<A-.>", cycle_prev, { silent = true })
map("n", "<A-t>", close_other_buffers, { silent = true })
map("n", "<A-c>", close_current_buffer, { silent = true })
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
map("n", "n", "nzzzv", { silent = true })
map("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "<F8>", '<CMD>lua require("dap").continue()<CR>')
vim.keymap.set("n", "<F9>", '<CMD>lua require("dap").step_into()<CR>')
vim.keymap.set("n", "<F10>", '<CMD>lua require("dap").step_over()<CR>')
vim.keymap.set("n", "<F11>", '<CMD>lua require("dap").step_out()<CR>')

local whichkey_status, whichkey = pcall(require, "which-key")
if not whichkey_status then
	return
end
local mappings = {
	e = { "<CMD>NvimTreeToggle<CR>", "File Explorer" },
	o = { "<CMD>NvimTreeFindFile<CR>", "Open file in explorer" },
	p = {
		'<CMD>lua require("telescope.builtin").find_files({find_command = { "fd", "-t=f", "-H" }})<CR>',
		"Search files",
	},
	f = { "<CMD>Telescope live_grep_args<CR>", "Search in files" },
	r = { [[<CMD>lua require("telescope").extensions.recent_files.pick({only_cwd=true})<CR>]], "Recent files" },
	b = { [[<CMD>Telescope buffers<CR>]], "Opened buffers" },
	g = {
		name = "Git",
		l = { "<cmd>lua LAZYGIT_TOGGLE()<CR>", "Toggle lazygit" },
		w = {
			name = "Git Worktree",
			c = {
				'<CMD>lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>',
				"Create a worktree",
			},
			s = {
				'<CMD>lua require("telescope").extensions.git_worktree.git_worktrees()<CR>',
				"Switch and delete a worktrees",
			},
		},
		h = {
			name = "Hunk",
			n = {
				"<CMD>Gitsigns next_hunk<CR>",
				"Next hunk",
			},
			p = {
				"<CMD>Gitsigns prev_hunk<CR>",
				"Previous hunk",
			},
			P = {
				"<CMD>Gitsigns preview_hunk<CR>",
				"Preview hunk",
			},
			r = {
				"<CMD>Gitsigns reset_hunk<CR>",
				"Reset hunk",
			},
			s = {
				"<CMD>Gitsigns select_hunk<CR>",
				"Select hunk",
			},
		},
	},
	s = { "<cmd>lua require('treesj').split()<CR>", "Join the object under cursor" },
	j = { "<cmd>lua require('treesj').join()<CR>", "Split the object under cursor" },
	S = { "<cmd>Silicon<CR>", "Take screenshot" },
	[","] = { cycle_next, "Cycle to next buffer" },
	["."] = { cycle_prev, "Cycle to previous buffer" },
	t = { close_other_buffers, "Close other buffers" },
	c = { close_current_buffer, "Close current buffer" },
	h = {
		name = "Harpoon",
		a = { '<CMD>lua require("harpoon.mark").add_file()<CR>', "Add mark" },
		m = { "<CMD>Telescope harpoon marks<CR>", "Show marks" },
		e = { '<CMD>lua require("harpoon.ui").toggle_quick_menu()<CR>', "Show menu" },
	},
	D = {
		name = "Debugging",
		b = { "<CMD>PBToggleBreakpoint<CR>", "Toggle breakpoint" },
		B = {
			"<CMD>PBSetConditionalBreakpoint<CR>",
			"Set conditional breakpoint",
		},
		lp = {
			'<CMD>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
			"Set log point conditional breakpoint",
		},
		o = {
			"<CMD>lua require('dapui').toggle()<CR>",
			"Toggle DAP ui",
		},
	},
	n = {
		name = "Noice",
		d = { "<CMD>Noice dismiss<CR>", "Dismiss notifications" },
	},
}

local opts = {
	prefix = "<leader>",
}

whichkey.register(mappings, opts)
vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n" }, "]g", "<cmd>Gitsigns next_hunk<CR>", { desc = "Git next hunk" })
vim.keymap.set({ "n" }, "[g", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Git next hunk" })
