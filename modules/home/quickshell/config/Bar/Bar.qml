import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Widgets
import qs.Settings
import qs.Bar

Scope {
    Item {
        anchors.fill: parent
        Variants {
            model: Quickshell.screens
            Item {
                property var modelData

                Exclusions {
                    screen: modelData
                    bar: bar
                }

                PanelWindow {
                    id: bar
                    screen: modelData

                    color: Theme.backgroundPrimary

                    anchors {
                        top: true
                        left: true
                        right: true
                    }

                    implicitHeight: Settings.barSize

                    Row {
                        id: barRight
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        layoutDirection: Qt.RightToLeft
                        anchors.rightMargin: 6

                        Clock {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            font.pointSize: 12
                        }
                    }
                }

                PanelWindow {
                    id: left
                    WlrLayershell.exclusionMode: ExclusionMode.Ignore
                    screen: modelData
                    anchors.top: true
                    anchors.left: true
                    anchors.bottom: true
                    implicitWidth: Settings.borderSize
                    margins.top: Settings.barSize
                    color: Theme.backgroundPrimary
                }
                PanelWindow {
                    id: right
                    WlrLayershell.exclusionMode: ExclusionMode.Ignore
                    screen: modelData
                    anchors.top: true
                    anchors.right: true
                    anchors.bottom: true
                    implicitWidth: Settings.borderSize
                    margins.top: Settings.barSize
                    color: Theme.backgroundPrimary
                }
                PanelWindow {
                    id: bottom
                    WlrLayershell.exclusionMode: ExclusionMode.Ignore
                    screen: modelData
                    anchors.left: true
                    anchors.bottom: true
                    anchors.right: true
                    implicitHeight: Settings.borderSize
                    color: Theme.backgroundPrimary
                }
            }
        }
    }
}
