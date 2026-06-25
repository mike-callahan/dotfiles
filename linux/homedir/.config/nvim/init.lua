local map = vim.keymap.set
local motion_modes = { 'n', 'x', 'o' }

-- Home-row motion: j=word-left, k=up, l=down, ;=word-right
-- (Arrows keep defaults for char/line movement.)
map(motion_modes, 'j', 'b')   -- word left
map(motion_modes, 'l', 'j')   -- line down
map(motion_modes, ';', 'w')   -- word right
-- k is already 'up' by default

-- Line ends: J = beginning of line, : = end of line
map(motion_modes, 'J', '^')
map(motion_modes, ':', '$')

-- Paragraph: K = up, L = down
map(motion_modes, 'K', '{')
map(motion_modes, 'L', '}')

-- File extremes: gj = top of file, g; = bottom of file
map(motion_modes, 'gj', 'gg')
map(motion_modes, 'g;', 'G')

-- Space opens command line
map({ 'n', 'x' }, '<Space>', ':')

-- Ctrl-A select all of file
map({ 'n', 'x' }, '<C-a>', '<Esc>ggVG')

-- Ctrl-F: open search
map('n', '<C-f>', '/')

-- Ctrl-R: global replace-all of current search pattern
-- Opens :%s/<last-search>//g with cursor between the // for the replacement
map('n', '<C-r>', ':%s/<C-r>///g<Left><Left>')

-- r becomes redo (overrides default r = replace single char, which we don't use)
map('n', 'r', '<C-r>')

-- Indent in visual mode: zj = unindent, z; = indent (keep selection)
map('x', 'zj', '<gv')
map('x', 'z;', '>gv')

-- "Block" = nearest enclosing braces, brackets, or parens.
-- Picks whichever opener is closest before the cursor (innermost wins for nested blocks).
local function nearest_block()
	local candidates = {
		{ open = '{',   close_ = '}',   ch = '{' },
		{ open = '\\[', close_ = '\\]', ch = '[' },
		{ open = '(',   close_ = ')',   ch = '(' },
	}
	local best, best_row, best_col = nil, 0, 0
	for _, d in ipairs(candidates) do
		local pos = vim.fn.searchpairpos(d.open, '', d.close_, 'bnW')
		if pos[1] > 0 and (pos[1] > best_row or (pos[1] == best_row and pos[2] > best_col)) then
			best, best_row, best_col = d.ch, pos[1], pos[2]
		end
	end
	return best
end

-- Ctrl-B: enter visual and select the enclosing block
map('n', '<C-b>', function()
	local ch = nearest_block()
	if ch then vim.api.nvim_feedkeys('vi' .. ch, 'n', false) end
end)

-- zJ / z: in normal mode: unindent / indent the enclosing block
map('n', 'zJ', function()
	local ch = nearest_block()
	if ch then vim.cmd('normal! vi' .. ch .. '<') end
end)
map('n', 'z:', function()
	local ch = nearest_block()
	if ch then vim.cmd('normal! vi' .. ch .. '>') end
end)

-- Disable Ex mode (footgun)
map('n', 'Q', '<Nop>')
