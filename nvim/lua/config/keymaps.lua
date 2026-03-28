-- Custom map function to make it less tedious to create keybindings.
local function map(mode_string, keymap, action, opts_string)
	-- Initalize tables
	local modes = {}
	local opts = {}

	-- Parse the mode string into the mode table
	for i = 1, #mode_string do
		table.insert(modes, mode_string:sub(i, i))
	end

	-- Parse the option string into the option table
	if opts_string then
		local desc_start = -1
		for i = 1, #opts_string do
			local opt = opts_string:sub(i, i)
			if opt == "s" then
				opts.silent = true
			elseif opt == "r" then
				opts.remap = true
			elseif opt == "e" then
				opts.expr = true
			elseif opt == "u" then
				opts.unique = true
			elseif opt == "f" then
				opts.nowait = true
			elseif opt == "#" then
				desc_start = i + 1
				break
			else
				error(string.format("'%s' is an invalid token", opt))
			end
		end

		-- Add the description to the option table
		if desc_start ~= -1 and desc_start <= #opts_string then
			opts.desc = opts_string:sub(desc_start)
		end
	end

	-- Set the keymap
	vim.keymap.set(modes, keymap, action, opts)
end

-- Mode reference for keymaps:
-- n = normal
-- i = insert
-- v = visual
-- x = visual and v-block
-- V = v-line
-- o = operator-pending
-- c = command-line
-- t = terminal
-- s = select
--
-- Option reference for keymaps:
-- s = silent
-- r = remap
-- e = expression
-- u = unique
-- f = fast (nowait)
-- # = Put description after

-- Better up/down
map("nx", "j", "v:count == 0 ? 'gj' : 'j'", "se#Down")
map("nx", "k", "v:count == 0 ? 'gk' : 'k'", "se#Up")
map("nx", "<Down>", "v:count == 0 ? 'gj' : 'j'", "se#Down")
map("nx", "<Up>", "v:count == 0 ? 'gk' : 'k'", "se#Down")

-- Move accross windows using <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", "r#Go to Left Window")
map("n", "<C-j>", "<C-w>j", "r#Go to Lower Window")
map("n", "<C-k>", "<C-w>k", "r#Go to Upper Window")
map("n", "<C-l>", "<C-w>l", "r#Go to Right Window")

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", "#Increase Window Height")
map("n", "<C-Down>", "<cmd>resize -2<cr>", "#Decrease Window Height")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "#Decrease Window Width")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "#Increase Window Width")

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", "#Move Down")
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", "#Move Up")
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", "#Move Down")
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", "#Move Up")
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", "#Move Down")
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", "#Move Up")

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", "#Prev Buffer")
map("n", "<S-l>", "<cmd>bnext<cr>", "#Next Buffer")
map("n", "[b", "<cmd>bprevious<cr>", "#Prev Buffer")
map("n", "]b", "<cmd>bnext<cr>", "#Next Buffer")
map("n", "<leader>bb", "<cmd>e #<cr>", "#Switch to Other Buffer")
map("n", "<leader>`", "<cmd>e #<cr>", "#Switch to Other Buffer")

-- Better operators
map("nv", "x", '"_x', "#Delete Char/Seletion")
map("nv", "d", '"_d', "#Delete")
map("nv", "c", '"_c', "#Change")
map("nv", "s", '"_s', "#Substitute")
map("nv", "X", "x", "#Delete & Yank Char/Selection")
map("nv", "D", "d", "#Delete & Yank")
map("nv", "C", "c", "#Change & Yank")
map("nv", "S", "s", "#Substitute & Yank")

-- Better redo
map("nv", "U", "<C-r>", "#Redo")

-- Better Line jumps
map("nvo", "gl", "$", "#End of Line")
map("nvo", "gh", function()
	local col = vim.fn.col(".")
	local first_nonblank = vim.fn.match(vim.fn.getline("."), "\\S") + 1
	return (col == first_nonblank) and "0" or "^"
end, "e#Beginning of Line")

-- <ctrl> keys
map("ixns", "<C-s>", "<cmd>w<cr><esc>", "#Save File")
map("ixns", "<C-x>", "<cmd>bd<cr><esc>", "#Close Buffer")
map("ixns", "<C-a>", function()
	vim.cmd("normal! gg0vG$")
end, "#Select All")

map("n", "M", "m", "#Set Mark")
map("n", "m", "q", "#Start Macro")
map("n", "q", "<cmd>bd<cr><esc>", "#Close Buffer")

-- better indenting
map("x", "<", "<gv", "#decrease indent")
map("x", ">", ">gv", "#Increase Indent")
map("n", "<", "<<", "#decrease indent")
map("n", ">", ">>", "#Increase Indent")
