/* SwayNC stylesheet, regenerated per theme by omarchy-theme-set-templates
   from this template (tokens resolve against the active theme's colors.toml).
   Cascades apply to toasts and the control center alike. */

* {
  all: unset;
  font-size: 13px;
  border-radius: 12px;
}

.control-center {
  background-color: {{ darker_background }};
  border: 1px solid {{ mix muted darker_background 60% }};
  border-radius: 16px;
  color: {{ foreground }};
  padding: 8px;
}

.close-button {
  background: {{ mix muted darker_background 55% }};
  color: {{ background }};
  margin: 4px;
  padding: 6px;
  border-radius: 8px;
}

.close-button:hover { background: {{ red }}; }

.notification-row {
  outline: none;
  margin: 0 4px;
}

.notification-row:hover .notification-background { background-color: {{ lighter_background }}; }
.notification-row:focus .notification-background { background-color: {{ selection }}; }

.notification-background {
  background-color: {{ background }};
  border: none;
  margin: 4px;
  padding: 6px;
  border-radius: 12px;
  color: {{ foreground }};
}

.notification { padding: 3px; }

.notification-content {
  background: transparent;
  padding: 4px;
  color: {{ foreground }};
}

.notification-content .app-name { color: {{ bright_foreground }}; font-weight: 700; }
.notification-content .summary { color: {{ foreground }}; font-weight: 600; }
.notification-content .not-region { color: {{ dark_foreground }}; }
.notification-content .body { color: {{ foreground }}; }
.notification-content .time { color: {{ dark_foreground }}; }

.notification-action {
  background-color: {{ mix muted darker_background 55% }};
  color: {{ foreground }};
  border-radius: 8px;
  padding: 4px 12px;
  margin: 3px;
}

.notification-action:hover { background-color: {{ accent }}; }

.widget-title {
  color: {{ dark_foreground }};
  font-size: 13px;
  font-weight: bold;
  margin: 6px 10px 2px;
}

.widget-title>button {
  color: {{ foreground }};
  padding: 2px 6px;
  border-radius: 6px;
  background: {{ mix muted darker_background 55% }};
}

.widget-dnd { color: {{ dark_foreground }}; margin: 4px 10px; }

.view { background: transparent; margin: 4px 2px; }
scrollbar { background: transparent; }
