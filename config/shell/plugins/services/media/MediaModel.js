function isProxyPlayer(player) {
  var dbusName = String(player && player.dbusName || "").toLowerCase()
  var desktopEntry = String(player && player.desktopEntry || "").toLowerCase()
  return dbusName.indexOf("playerctld") !== -1 || desktopEntry === "playerctld"
}

// MPRIS players that win player selection whenever they have a track
// loaded, playing or paused (mirrors the old waybar's dedicated Spotify
// module). Manual selection via the popup's source list still overrides.
var priorityIdentities = ["spotify"]

// Bar widget glyph per player, matched by dbus name/identity/desktop entry.
// Anything unmatched falls back to a generic music note.
var playerIcons = [
  ["spotify", "\uF1BC"],           // 󰁾 nf-fa-spotify
  ["firefox", "\uF269"],           // 󰊙 nf-fa-firefox
  ["chromium", "\uF268"],          // 󰊈 nf-fa-chrome
  ["chrome", "\uF268"],
  ["brave", "\uF268"],
  ["mpv", "\uF036"],               // 󱕼 nf-fa-play-circle
]

function playerIcon(player) {
  var dbusName = String(player && player.dbusName || "").toLowerCase()
  var identity = String(player && player.identity || "").toLowerCase()
  var desktopEntry = String(player && player.desktopEntry || "").toLowerCase()
  var token = ""
  var i = 0

  for (i = 0; i < playerIcons.length; i++) {
    token = String(playerIcons[i][0]).toLowerCase()
    if (!token) continue
    if (dbusName.indexOf(token) !== -1 || identity.indexOf(token) !== -1 || desktopEntry.indexOf(token) !== -1) return playerIcons[i][1]
  }

  return "\uDB80\uFD5A" // 󰝚 nf-md-music
}

function isPriorityPlayer(player) {
  var dbusName = String(player && player.dbusName || "").toLowerCase()
  var identity = String(player && player.identity || "").toLowerCase()
  var desktopEntry = String(player && player.desktopEntry || "").toLowerCase()
  var token = ""
  var i = 0

  for (i = 0; i < priorityIdentities.length; i++) {
    token = String(priorityIdentities[i]).toLowerCase()
    if (!token) continue
    if (dbusName.indexOf(token) !== -1 || identity.indexOf(token) !== -1 || desktopEntry.indexOf(token) !== -1) return true
  }

  return false
}

function hasMetadata(player) {
  return !!(player && (player.trackTitle || player.trackArtist || player.identity || player.desktopEntry))
}

function hasTrackMetadata(player) {
  return !!(player && (player.trackTitle || player.trackArtist || player.trackAlbum || player.trackArtUrl))
}

function playerCanControl(player) {
  return !!(player && (player.canTogglePlaying || player.canPlay || player.canPause || player.canGoNext || player.canGoPrevious))
}

function canHandleAction(player, action) {
  if (!player) return false
  if (action === "next") return !!player.canGoNext
  if (action === "previous") return !!player.canGoPrevious
  if (action === "play") return !!(player.canPlay || player.canTogglePlaying)
  if (action === "pause") return !!(player.canPause || player.canTogglePlaying)
  if (action === "playPause") return !!(player.canTogglePlaying || player.canPlay || player.canPause)
  return false
}

function canCycleSource(player) {
  return !!(player && hasMetadata(player) && (player.isPlaying || player.canPlay))
}

function nodeProps(node) {
  return node && node.ready && node.properties ? node.properties : {}
}

function isPlaybackStream(node) {
  if (!node || !node.isStream) return false
  if (node.isSink === true) return true

  var mediaClass = String(node.type || "")
  return mediaClass.indexOf("Stream/Output/Audio") !== -1
    || mediaClass.indexOf("AudioOutStream") !== -1
    || mediaClass.indexOf("Output") !== -1
}

function streamLabelKey(label) {
  var key = String(label || "").toLowerCase()
  key = key.replace(/^pipewire alsa \[/, "")
  key = key.replace(/\]$/, "")
  key = key.replace(/^alsa playback \[/, "")
  key = key.replace(/[^a-z0-9]+/g, "")
  return key
}

function rawStreamLabel(node) {
  if (!node) return ""
  var p = nodeProps(node)
  return p["application.name"]
    || node.description
    || p["media.name"]
    || p["node.name"]
    || node.name
}

function playerAppLabel(player) {
  if (!player) return ""
  var dbus = String(player.dbusName || "")
  dbus = dbus.replace(/^org\.mpris\.MediaPlayer2\./, "")
  dbus = dbus.replace(/\.instance[0-9]+$/, "")
  return player.desktopEntry || player.identity || dbus
}

function playerHasPlaybackStream(player, playbackStreams) {
  var playerKey = streamLabelKey(playerAppLabel(player))
  if (!playerKey) return false

  var streams = Array.isArray(playbackStreams) ? playbackStreams : []
  var streamKey = ""
  var i = 0

  for (i = 0; i < streams.length; i++) {
    streamKey = streamLabelKey(rawStreamLabel(streams[i]))
    if (!streamKey) continue
    if (streamKey === playerKey
        || streamKey.indexOf(playerKey) !== -1
        || playerKey.indexOf(streamKey) !== -1)
      return true
  }

  return false
}

function playerKey(player) {
  if (!player) return ""
  return String(player.dbusName || player.desktopEntry || player.identity || "")
}

function trackSignature(player) {
  if (!player) return ""
  return [
    player.trackTitle || "",
    player.trackArtist || "",
    player.trackAlbum || "",
    player.trackArtUrl || ""
  ].join("\u001f")
}

function trackChanged(previousSignature, player) {
  return trackSignature(player) !== String(previousSignature || "")
}

function labelFor(player) {
  if (!player) return ""
  return player.trackTitle || player.identity || player.desktopEntry || ""
}

function osdMessage(player, fallback) {
  if (!player) return fallback
  var label = labelFor(player)
  if (label && player.trackArtist) return label + " - " + player.trackArtist
  return label || fallback
}

if (typeof module !== "undefined") {
  module.exports = {
    isProxyPlayer: isProxyPlayer,
    isPriorityPlayer: isPriorityPlayer,
    playerIcon: playerIcon,
    hasMetadata: hasMetadata,
    hasTrackMetadata: hasTrackMetadata,
    playerCanControl: playerCanControl,
    canHandleAction: canHandleAction,
    canCycleSource: canCycleSource,
    nodeProps: nodeProps,
    isPlaybackStream: isPlaybackStream,
    streamLabelKey: streamLabelKey,
    rawStreamLabel: rawStreamLabel,
    playerAppLabel: playerAppLabel,
    playerHasPlaybackStream: playerHasPlaybackStream,
    playerKey: playerKey,
    trackSignature: trackSignature,
    trackChanged: trackChanged,
    labelFor: labelFor,
    osdMessage: osdMessage
  }
}
