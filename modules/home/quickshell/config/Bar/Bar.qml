import QtQuick
import Quickshell
import qs.Widgets
import qs.Settings

Scope {
    // no more time object

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            color: Theme.backgroundPrimary

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

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
    }
}
