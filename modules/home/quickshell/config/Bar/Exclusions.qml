pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.Settings

Scope {
    id: root

    required property ShellScreen screen
    required property Item bar

    ExclusionZone {
        anchors.left: true
    }

    ExclusionZone {
        anchors.right: true
    }

    ExclusionZone {
        anchors.bottom: true
    }

    component ExclusionZone: PanelWindow {
        screen: root.screen
        exclusiveZone: Settings.borderSize
        color: "transparent"
        mask: Region {}
    }
}
