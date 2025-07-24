pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property string backgroundPrimary: "#282828"

    readonly property string textPrimary: "#fbf1c7"

    readonly property FontStuff font: FontStuff {}

    component FontFamily: QtObject {
        readonly property string sans: "IBM Plex Sans"
        readonly property string mono: "JetBrains Mono NF"
        readonly property string material: "Material Symbols Rounded"
    }

    component FontSize: QtObject {
        readonly property int small: 11
        readonly property int smaller: 12
        readonly property int normal: 13
        readonly property int larger: 15
        readonly property int large: 18
        readonly property int extraLarge: 28
    }

    component FontStuff: QtObject {
        readonly property FontFamily family: FontFamily {}
        readonly property FontSize size: FontSize {}
    }
}
