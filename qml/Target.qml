import QtQuick 2.0

Rectangle {
    id: targetWrapper
    state: "imgLoading"

    Rectangle {
        id: target
        color: "#e1e8ed"
        height: 40
        width: 177
        radius: 40

        Rectangle {
            id: targetImageWrapper
            width: 34
            height: 34
            radius: 34
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 4
            clip: true
            Image {
                id: targetImage
                source: stomtPlugin.profileImageUrl
                clip: true
                width: 34
                height: 34
                asynchronous: true
                sourceSize.height: 34
                sourceSize.width: 34
                anchors.centerIn: parent
                onStatusChanged: {
                    if (targetImage.status === Image.Ready)
                        targetWrapper.state = "imgLoaded"
                }
            }
        }

        Text {
            id: targetName
            text: stomtPlugin.getTargetID()
            font.pixelSize: 16
            font.family: lato.name
            renderType: Text.NativeRendering
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: targetImageWrapper.right
            anchors.leftMargin: 8
        }
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            Qt.openUrlExternally("https://www.stomt.com/" + targetName.text)
        }
    }

    states: [
        State {
            name: "imgLoading"

            PropertyChanges {
                target: targetImage
                opacity: 0
            }

        },
        State {
            name: "imgLoaded"
            PropertyChanges {
                target: targetImage
                opacity: 1
            }

        }
    ]
    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation {
                properties: "opacity"
                easing.type: Easing.InOutQuad
                duration: 300
            }

        }
    ]
}
