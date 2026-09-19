-- Omarchy Hyprland setup: helpers, defaults, and current theme overrides.

require("hypr.helpers")
local require_optional = require("hypr.require_optional")

-- Use Omarchy defaults, but don't edit these directly.
require("hypr.autostart")
if _G.omarchy_default_bindings ~= false then
  require("hypr.bindings.media")
  require("hypr.bindings.clipboard")
  require("hypr.bindings.tiling")
  require("hypr.bindings.utilities")
  require("hypr.bindings.voxtype")
  require_optional.module("hypr.bindings.applications")
end
require("hypr.envs")
require("hypr.looknfeel")
require("hypr.qconsole")
require("hypr.input")
require("hypr.windows")

-- Current theme overrides.
require_optional.module("omarchy.current.theme.hyprland")
