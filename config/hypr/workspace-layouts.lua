-- Restore workspace layouts saved by omarchy-hyprland-workspace-layout-toggle.

local paths = require("hypr.paths")
local require_all = require("hypr.require_all")

local layouts_dir = paths.state_home .. "/omarchy/workspace-layouts"

require_all.files(layouts_dir, "omarchy.workspace-layouts", { reload = true })
