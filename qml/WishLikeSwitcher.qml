import QtQuick 2.0

Item {
    id: wishLikeSwitcher
    state: "whish"
    width: 160
    height: 56
    property bool isPositive: false

    FontLoader { id: lato; source: "qrc:/assets/fonts/Lato-Regular.ttf" }


    Rectangle {
        id: likeWrapper
        x: 20
        y: 0
        width: 140
        height: 40
        color: "#50e3c2"
        radius: 200

        Text {
            id: text1
            text: qsTr("Ich mag")
            color: "white"
            font.family: lato.name
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            renderType: Text.NativeRendering
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: rectangle.right
            anchors.leftMargin: 10
            font.pixelSize: 12
        }

        Rectangle {
            id: rectangle
            width: 34
            height: 34
            color: "#ffffff"
            radius: 17
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.top: parent.top
            anchors.topMargin:3
        }

    }

    Rectangle {
        id: whishWrapper
        x: 0
        y: 16
        width: 140
        height: 40
        color: "#9013fe"
        radius: 200

        Text {
            id: text2
            color: "#ffffff"
            text: qsTr("Ich wünschte")
            font.family: lato.name
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            renderType: Text.NativeRendering
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: rectangle1.right
            anchors.leftMargin: 10
            font.pixelSize: 12
        }

        Rectangle {
            id: rectangle1
            width: 34
            height: 34
            color: "#ffffff"
            radius: 17
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.top: parent.top
            anchors.topMargin:3
        }

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(wishLikeSwitcher.state == "like"){
                wishLikeSwitcher.state = "wish"
                isPositive = false
            } else {
                wishLikeSwitcher.state = "like"
                isPositive = true
            }
        }
    }




    states: [
        State {
            name: "which"
        },
        State {
            name: "like"

            PropertyChanges {
                target: likeWrapper
                x: 0
                y: 16
                z: 1
            }

            PropertyChanges {
                target: whishWrapper
                x: 20
                y: 0
            }
        }
    ]
    transitions: [
        Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuad; duration: 300 }

        }
    ]
}
