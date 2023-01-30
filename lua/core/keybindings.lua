vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap

local cycle_next = '<CMD>BufferLineCyclePrev<CR>'
local cycle_prev = '<CMD>BufferLineCycleNext<CR>'
local close_other_buffers = '<CMD>BufferLineCloseLeft<CR><CMD>BufferLineCloseRight<CR>'
local close_current_buffer = '<CMD>BufDel<CR>'
map('n', '<Space>', '', {})
map('n', 'Q', '', {})
map('n', '<ESC>', '<CMD>noh<CR>', { silent = true })
map('n', '<A-,>', cycle_next, { silent = true })
map('n', '<A-.>', cycle_prev, { silent = true })
map('n', '<A-t>', close_other_buffers, { silent = true })
map('n', '<A-c>', close_current_buffer, { silent = true })
map('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
map('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })
map('n', 'n', 'nzzzv', { silent = true })
map('n', 'N', 'Nzzzv', { silent = true })
vim.keymap.set('n', '<F1>', '<CMD>lua require("dap").step_into()<CR>')
vim.keymap.set('n', '<F2>', '<CMD>lua require("dap").continue()<CR>')
vim.keymap.set('n', '<F3>', '<CMD>lua require("dap").step_over()<CR>')
vim.keymap.set('n', '<F4>', '<CMD>lua require("dap").step_out()<CR>')

local whichkey_status, whichkey = pcall(require, 'which-key')
if not whichkey_status then
    return
end
local mappings = {
    e = { '<CMD>NvimTreeToggle<CR>', 'File Explorer' },
    o = { '<CMD>NvimTreeFindFile<CR>', 'Open file in explorer' },
    p = { '<CMD>lua require("telescope.builtin").find_files({find_command = { "fd", "-t=f", "-H" }})<CR>', 'Search files' },
    f = { '<CMD>Telescope live_grep<CR>', 'Search in files' },
    g = {
        name = 'Git',
        l = { '<cmd>lua LAZYGIT_TOGGLE()<CR>', 'Toggle lazygit' },
        w = {
            name = 'Git Worktree',
            c = { '<CMD>lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>', 'Create a worktree' },
            s = { '<CMD>lua require("telescope").extensions.git_worktree.git_worktrees()<CR>',
                'Swith and delete a worktrees' }
        }
    },
    S = { '<cmd>Silicon<CR>', 'Take screenshot' },
    [','] = { cycle_next, 'Cycle to next buffer' },
    ['.'] = { cycle_prev, 'Cycle to previous buffer' },
    t = { close_other_buffers, 'Close other buffers' },
    c = { close_current_buffer, 'Close current buffer' },
    s = { '<CMD>SymbolsOutline<CR>', 'Toggle Symbol outline' },
    h = {
        name = 'Harpoon',
        a = { '<CMD>lua require("harpoon.mark").add_file()<CR>', 'Add mark' },
        m = { '<CMD>Telescope harpoon marks<CR>', 'Show marks' },
        e = { '<CMD>lua require("harpoon.ui").toggle_quick_menu()<CR>', 'Show menu' }
    },
    D = {
        name = 'Debugging',
        b = { '<CMD>lua require("dap").toggle_breakpoint()<CR>', 'Set breakpoint' },
        B = { '<CMD>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
            'Set conditional breakpoint' },
        lp = { '<CMD>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))',
            'Set log point conditional breakpoint' }
    }
}

local opts = {
    prefix = '<leader>'
}

whichkey.register(mappings, opts)
