local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- ============================================================
-- GENERAL
-- ============================================================

config.font = wezterm.font("JetBrains Mono")
config.font_size = 10

config.initial_cols = 135
config.initial_rows = 35

config.max_fps = 240
config.animation_fps = 60

config.color_scheme = "Catppuccin Macchiato"

config.window_decorations = "RESIZE"

config.window_padding = {
	left = 10,
	right = 10,
	top = 8,
	bottom = 8,
}

config.scrollback_lines = 10000

config.window_background_opacity = 0.78
config.win32_system_backdrop = "Acrylic"

config.enable_scroll_bar = false
config.use_dead_keys = false

-- ============================================================
-- LINUX
-- ============================================================

config.default_prog = {
	"bash"
}

-- ============================================================
-- TAB BAR
-- ============================================================

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

-- ============================================================
-- COLORS
-- ============================================================

local colors = {
	crust = "#181926",
	mantle = "#1e2030",

	surface0 = "#363a4f",
	surface1 = "#494d64",

	text = "#cad3f5",
	subtext = "#a5adcb",

	mauve = "#c6a0f6",
	lavender = "#b7bdf8",
}

-- ============================================================
-- WINDOW FRAME
-- ============================================================

config.window_background_opacity = 1.0

config.window_frame = {
	border_left_width = "0.25cell",
	border_right_width = "0.25cell",
	border_top_height = "0.15cell",
	border_bottom_height = "0.15cell",

	border_left_color = colors.mauve,
	border_right_color = colors.mauve,
	border_top_color = colors.mauve,
	border_bottom_color = colors.mauve,
}

-- ============================================================
-- KEYBINDINGS
--
-- MAIN KEY is CTRL + ALT.
--
-- Navigation:
--
--             I
--           J K L
--
-- Splits:
--
--             U O
--
-- Tabs:
--
--       A   T   D
--
-- ============================================================

config.keys = {

	-- ========================================================
	-- PANE NAVIGATION
	-- ========================================================

	-- AltGr + I
	-- Pane above
	{
		key = "i",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},

	-- AltGr + J
	-- Pane left
	{
		key = "j",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},

	-- AltGr + K
	-- Pane below
	{
		key = "k",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},

	-- AltGr + L
	-- Pane right
	{
		key = "l",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},

	-- ========================================================
	-- PANE SPLITTING
	-- ========================================================

	-- AltGr + U
	-- Left / right split
	{
		key = "u",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	},

	-- AltGr + O
	-- Top / bottom split
	{
		key = "o",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},

	-- ========================================================
	-- CLOSE PANE
	-- ========================================================

	-- AltGr + W
	{
		key = "w",
		mods = "CTRL|ALT",
		action = wezterm.action.CloseCurrentPane({
			confirm = true,
		}),
	},

	-- ========================================================
	-- NEW TAB
	-- ========================================================

	-- AltGr + T
	{
		key = "t",
		mods = "CTRL|ALT",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	-- ========================================================
	-- TAB NAVIGATION
	-- ========================================================

	-- AltGr + A
	-- Previous tab
	{
		key = "a",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivateTabRelative(-1),
	},

	-- AltGr + D
	-- Next tab
	{
		key = "d",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivateTabRelative(1),
	},

	-- ========================================================
	-- MOVE TABS
	-- ========================================================

	-- AltGr + E
	-- Move tab left
	{
		key = "e",
		mods = "CTRL|ALT",
		action = wezterm.action.MoveTabRelative(-1),
	},

	-- AltGr + R
	-- Move tab right
	{
		key = "r",
		mods = "CTRL|ALT",
		action = wezterm.action.MoveTabRelative(1),
	},

	-- ========================================================
	-- PANE RESIZING
	-- ========================================================

	-- AltGr + Shift + I
	{
		key = "i",
		mods = "CTRL|ALT|SHIFT",
		action = wezterm.action.AdjustPaneSize({
			"Up",
			5,
		}),
	},

	-- AltGr + Shift + J
	{
		key = "j",
		mods = "CTRL|ALT|SHIFT",
		action = wezterm.action.AdjustPaneSize({
			"Left",
			5,
		}),
	},

	-- AltGr + Shift + K
	{
		key = "k",
		mods = "CTRL|ALT|SHIFT",
		action = wezterm.action.AdjustPaneSize({
			"Down",
			5,
		}),
	},

	-- AltGr + Shift + L
	{
		key = "l",
		mods = "CTRL|ALT|SHIFT",
		action = wezterm.action.AdjustPaneSize({
			"Right",
			5,
		}),
	},

	-- ========================================================
	-- ZOOM
	-- ========================================================

	-- AltGr + Z
	{
		key = "z",
		mods = "CTRL|ALT",
		action = wezterm.action.TogglePaneZoomState,
	},

	-- ========================================================
	-- CLEAR TERMINAL
	-- ========================================================

	-- AltGr + C
	{
		key = "c",
		mods = "CTRL|ALT",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},

	-- ========================================================
	-- LAUNCHER
	-- ========================================================

	-- AltGr + P
	{
		key = "p",
		mods = "CTRL|ALT",
		action = wezterm.action.ShowLauncher,
	},
}

-- ============================================================
-- DIRECT TAB SELECTION
-- ============================================================

for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = wezterm.action.ActivateTab(i),
	})
end

-- ============================================================
-- TAB TITLES
-- ============================================================

local function get_tab_title(tab)
	if tab.tab_title and #tab.tab_title > 0 then
		return tab.tab_title
	end

	return tab.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = get_tab_title(tab)

	title = wezterm.truncate_right(title, max_width - 10)

	local tab_index = tab.tab_index

	if tab.is_active then
		return {
			{
				Background = {
					Color = colors.mauve,
				},
			},
			{
				Foreground = {
					Color = colors.crust,
				},
			},
			{
				Text = "  " .. tab_index .. "  " .. title .. "  ",
			},
		}
	end

	return {
		{
			Background = {
				Color = colors.mantle,
			},
		},
		{
			Foreground = {
				Color = colors.subtext,
			},
		},
		{
			Text = "  " .. tab_index .. "  " .. title .. "  ",
		},
	}
end)

-- ============================================================
-- CURSOR
-- ============================================================

config.default_cursor_style = "SteadyBar"
config.cursor_blink_rate = 0

-- ============================================================
-- FINAL
-- ============================================================

return config
