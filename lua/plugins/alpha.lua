local function getLen(str, start_pos)
	local byte = string.byte(str, start_pos)
	if not byte then
		return nil
	end

	return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
end

local function colorize(header, header_color_map, colors)
	for letter, color in pairs(colors) do
		local color_name = "AlphaJemuelKwelKwelWalangTatay" .. letter
		vim.api.nvim_set_hl(0, color_name, color)
		colors[letter] = color_name
	end

	local colorized = {}

	for i, line in ipairs(header_color_map) do
		local colorized_line = {}
		local pos = 0

		for j = 1, #line do
			local start = pos
			pos = pos + getLen(header[i], start + 1)

			local color_name = colors[line:sub(j, j)]
			if color_name then
				table.insert(colorized_line, { color_name, start, pos })
			end
		end

		table.insert(colorized, colorized_line)
	end

	return colorized
end

return{
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
	local alpha = require("alpha")

	local dashboard = require("alpha.themes.dashboard")

	local header = {
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████                                   ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
	}

	local color_map = {
		[[ WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBWWWWWWWWWWWWWW ]],
		[[ RRRRWWWWWWWWWWWWWWWWRRRRRRRRRRRRRRRRWWWWWWWWWWWWWWWWBBPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPBBWWWWWWWWWWWW ]],
		[[ RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRBBPPPPPPHHHHHHHHHHHHHHHHHHHHHHHHHHPPPPPPBBWWWWWWWWWW ]],
		[[ RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRBBPPPPHHHHHHHHHHHHFFHHHHFFHHHHHHHHHHPPPPBBWWWWWWWWWW ]],
		[[ OOOORRRRRRRRRRRRRRRROOOOOOOOOOOOOOOORRRRRRRRRRRRRRBBPPHHHHFFHHHHHHHHHHHHHHHHHHHHHHHHHHHHPPBBWWWWWWWWWW ]],
		[[ OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOBBPPHHHHHHHHHHHHHHHHHHHHBBBBHHHHFFHHHHPPBBWWBBBBWWWW ]],
		[[ OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOBBPPHHHHHHHHHHHHHHHHHHBBMMMMBBHHHHHHHHPPBBBBMMMMBBWW ]],
		[[ YYYYOOOOOOOOOOOOOOOOYYYYYYYYYYYYYYYYOOBBBBBBBBOOOOBBPPHHHHHHHHHHHHFFHHHHBBMMMMMMBBHHHHHHPPBBMMMMMMBBWW ]],
		[[ YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYBBMMMMBBBBOOBBPPHHHHHHHHHHHHHHHHHHBBMMMMMMMMBBBBBBBBMMMMMMMMBBWW ]],
		[[ YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYBBBBMMMMBBBBBBPPHHHHHHFFHHHHHHHHHHBBMMMMMMMMMMMMMMMMMMMMMMMMBBWW ]],
		[[ GGGGYYYYYYYYYYYYYYYYGGGGGGGGGGGGGGGGYYYYBBBBMMMMBBBBPPHHHHHHHHHHHHHHFFBBMMMMMMMMMMMMMMMMMMMMMMMMMMMMBB ]],
		[[ GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGBBBBMMMMBBPPHHFFHHHHHHHHHHHHBBMMMMMMCCWWMMMMMMMMMMCCWWMMMMBB ]],
		[[ GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGBBBBBBBBPPHHHHHHHHHHHHHHHHBBMMMMMMWWWWMMMMMMWWMMWWWWMMMMBB ]],
		[[ UUUUGGGGGGGGGGGGGGGGUUUUUUUUUUUUUUUUGGGGGGGGGGGGBBBBPPHHHHHHHHHHFFHHHHBBMMHHHHMMMMMMMMMMMMMMMMMMHHHHBB ]],
		[[ UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUBBPPPPHHFFHHHHHHHHHHBBMMHHHHMMWWMMMMWWMMMMWWMMHHHHBB ]],
		[[ UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUBBPPPPPPHHHHHHHHHHHHHHBBMMMMMMWWWWWWWWWWWWWWMMMMBBWW ]],
		[[ VVVVUUUUUUUUUUUUUUUUVVVVVVVVVVVVVVVVUUUUUUUUUUUUBBBBBBPPPPPPPPPPPPPPPPPPPPBBMMMMMMMMMMMMMMMMMMMMBBWWWW ]],
		[[ VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVBBMMMMMMBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBWWWWWW ]],
		[[ VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVBBMMMMBBBBWWBBMMMMBBWWWWWWWWWWBBMMMMBBWWBBMMMMBBWWWWWWWW ]],
		[[ WWWWVVVVVVVVVVVVVVVVWWWWWWWWWWWWWWWWVVVVVVVVVVBBBBBBBBWWWWBBBBBBWWWWWWWWWWWWWWBBBBBBWWWWBBBBWWWWWWWWWW ]],
	}

	local colors = {
		["W"] = { fg = 0x000000 },
		["C"] = { fg = 0xffffff },
		["B"] = { fg = 0x0a0a0a },
		["R"] = { fg = 0xff0000 },
		["O"] = { fg = 0xff9900 },
		["Y"] = { fg = 0xffff00 },
		["G"] = { fg = 0x33ff00 },
		["U"] = { fg = 0x0099ff },
		["P"] = { fg = 0xffcc99 },
		["H"] = { fg = 0xff99ff },
		["F"] = { fg = 0xff3399 },
		["M"] = { fg = 0x999999 },
		["V"] = { fg = 0x6633ff },
	}

	dashboard.section.header.val = header
	dashboard.section.header.opts = {
		hl = colorize(header, color_map, colors),
		position = "center",
	}

	dashboard.section.buttons.val = {
      dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
      dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
      dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
  }
	for _, a in ipairs(dashboard.section.buttons.val) do
		a.opts.width = 49
		a.opts.cursor = -2
	end

	alpha.setup(dashboard.opts)
	vim.cmd([[autocmd Filetype alpha setlocal nofoldenable]])
end,
}
