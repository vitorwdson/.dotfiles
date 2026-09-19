import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

// Native replacement for waybar's swaync bell: subscribes to swaync's waybar
// stream so the bell reacts the same tick a notification arrives or DND
// flips, instead of polling. State model mirrors swaync's classes:
//   ""             -> bell, no pending notifications
//   "notification" -> bell + red dot (same ticks as an upgrade)
//   "dnd-none"     -> bell-slash
//   "dnd-notification" etc. -> bell-slash + dot
BarWidget {
  id: root
  moduleName: "omarchy.notifications-center"

  property int count: 0
  property bool hasDnd: false
  property bool hasNotifications: false

  readonly property string glyph: hasDnd ? "\uF1F6" : "\uF0F3"
  readonly property string label: root.hasNotifications
    ? count + " notification" + (count === 1 ? "" : "s") + (hasDnd ? " (DND)" : "")
    : "Notification center"

  visible: true
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  function applyState(data) {
    root.count = Math.max(0, parseInt(String(data.text || "0"), 10) || 0)
    var klass = String(data.class || data.alt || "")
    root.hasDnd = klass.indexOf("dnd") !== -1
    root.hasNotifications = klass.indexOf("notification") !== -1
  }

  // -swb prints the current state on connect, then one JSON line per state
  // change (add/close/inhibitors/DND). The client process exits when swaync
  // restarts; onExited schedules a reconnect.
  Process {
    id: subscribeProc
    command: ["swaync-client", "-swb"]
    stdout: SplitParser {
      onRead: function(data) {
        root.applyState(Util.parseModuleJson(data))
      }
    }
    onExited: reconnectTimer.restart()
  }

  Timer {
    id: reconnectTimer
    interval: 2000
  }

  Component.onCompleted: subscribeProc.running = true

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.glyph
    tooltipText: root.label
    onPressed: function(b) {
      if (b === Qt.RightButton) {
        root.bar.run("swaync-client -d")
      } else {
        root.bar.run("swaync-client -t -sw")
      }
    }
  }

  // Red superscript dot next to the bell glyph, like the old waybar
  // `format-icons` markup.
  Rectangle {
    id: bellDot
    visible: parent.visible && root.hasNotifications
    color: Color.urgent
    radius: width / 2
    width: Style.spaceReal(6)
    height: Style.spaceReal(6)
    anchors.horizontalCenter: button.horizontalCenter
    anchors.horizontalCenterOffset: Style.spaceReal(8)
    anchors.verticalCenter: button.verticalCenter
    anchors.verticalCenterOffset: -Style.spaceReal(6)
  }
}