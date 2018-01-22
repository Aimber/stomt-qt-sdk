import QtQuick 2.0
import com.stomt.qmlSDK 1.0

Rectangle {
    id: targetWrapper
    state: "imgLoading"

    property url targetImageUrl
    property string targetDisplayName

    Rectangle {
        id: target
        color: "#e1e8ed"
        height: 40
        width: 177
        radius: 40

        Rectangle {
            id: targetImageWrapper
            width: 34
            color: "gray"
            radius: 34
            height: 34
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 6
            clip: true
            Image {
                id: targetImage
                source: targetImageUrl
                clip: true
                width: 30
                height: 30
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                sourceSize.height: 30
                sourceSize.width: 30
                anchors.fill: parent
                onStatusChanged: {
                    if (targetImage.status === Image.Ready)
                        targetWrapper.state = "imgLoaded"
                }
            }
        }

        Text {
            id: targetName
            text: targetDisplayName
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
        cursorShape: Qt.PointingHandCursor
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
