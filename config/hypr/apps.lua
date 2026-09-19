-- App-specific tweaks.
local paths = require("hypr.paths")
local require_all = require("hypr.require_all")

require_all.files(paths.omarchy_path .. "/hypr/apps", "hypr.apps")
