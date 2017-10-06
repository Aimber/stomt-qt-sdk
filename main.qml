import QtQuick 2.6
import QtQuick.Window 2.2
import "qml/"

Window {
    visible: true
    width: 450
    height: 300
    title: qsTr("STOMT")

    Stomt{
        anchors.centerIn: parent
    }
}
