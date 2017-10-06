import QtQuick 2.0

Rectangle {
    id: submitBtn
    width: 80
    height: 80
    color: "#768998"
    radius: 40
    border.color: "#e1e8ed"
    border.width: 6

    signal sendStomt

    Image {
        id: imgArrow
        anchors.centerIn: parent
        height: 30
        width: 30
        sourceSize: Qt.size(30, 30)
        source: "qrc:/assets/icons/icon_arrow-pointing-to-right.svg"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            sendStomt()
        }
        onEntered: {

        }
    }
}
