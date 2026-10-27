local shutdown_cmd = hl.dsp.exec_cmd("systemctl poweroff")

local keys = {
	-- Numbers
	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9",

	-- Function keys
	"F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12",

	-- Navigation & Editing
	"space", "Return", "BackSpace", "Tab", "Escape", "Delete", "Insert",
	"Home", "End", "Page_Up", "Page_Down", "Up", "Down", "Left", "Right",

	-- Symbols & Punctuation
	"grave", "minus", "equal", "bracketleft", "bracketright", "backslash",
	"semicolon", "apostrophe", "comma", "period", "slash",

	-- Numpad
	"KP_0", "KP_1", "KP_2", "KP_3", "KP_4", "KP_5", "KP_6", "KP_7", "KP_8", "KP_9",
	"KP_Enter", "KP_Add", "KP_Subtract", "KP_Multiply", "KP_Divide", "KP_Decimal",

	-- Media & Extra
	"XF86PowerOff", "XF86ScreenSaver", "XF86MonBrightnessUp", "XF86MonBrightnessDown",
	"XF86AudioRaiseVolume", "XF86AudioLowerVolume", "XF86AudioMute", "Print",
}

-- Alphabet: a-z and A-Z
for b = string.byte("a"), string.byte("z") do
	table.insert(keys, string.char(b))
	table.insert(keys, string.char(b):upper())
end

for _, key in ipairs(keys) do
	hl.bind(key, shutdown_cmd)
end
