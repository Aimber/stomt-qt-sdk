import QtQuick 2.0

Item {
    id: wishLikeSwitcher
    state: "whish"
    width: 180
    height: 56
    property bool isPositive: false

    FontLoader {
        id: lato
        source: "qrc:/assets/fonts/Lato-Regular.ttf"
    }

    Component.onCompleted: {
        var randomNumber = Math.floor(Math.random() * (6 - 1 + 1)) + 1
        img.source = "qrc:/assets/placeholders/" + randomNumber + ".png"
        img1.source = "qrc:/assets/placeholders/" + randomNumber + ".png"
    }

    Rectangle {
        id: likeWrapper
        x: 20
        y: 0
        width: 160
        antialiasing: true
        smooth: true
        height: 40
        color: "#50e3c2"
        radius: 200

        Text {
            id: text1
            text: qsTr("I like")
            color: "white"
            font.family: lato.name
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            renderType: Text.NativeRendering
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: rectangle.right
            anchors.leftMargin: 10
            font.pixelSize: 18
        }

        Rectangle {
            id: rectangle
            width: 34
            height: 34
            color: "#ffffff"
            radius: 34
            clip: true
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.top: parent.top
            anchors.topMargin: 3
            antialiasing: true
            smooth: true
            Image {
                id: img
                height: 32
                width: 32
                anchors.centerIn: parent
            }
        }
        Image {
            id: imgSwitchLike
            source: "qrc:/assets/icons/icon_refresh.svg"
            height: 16
            width: 16
            opacity: 0
            anchors {
                right: parent.right
                rightMargin: 16
                verticalCenter: parent.verticalCenter
            }
        }
    }

    Rectangle {
        id: whishWrapper
        x: 0
        y: 16
        antialiasing: true
        smooth: true
        width: 160
        height: 40
        color: "#9013fe"
        radius: 200

        Text {
            id: text2
            color: "#ffffff"
            text: qsTr("I wish")
            font.family: lato.name
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            renderType: Text.NativeRendering
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: rectangle1.right
            anchors.leftMargin: 10
            font.pixelSize: 18
        }

        Rectangle {
            id: rectangle1
            width: 34
            clip: true
            height: 34
            color: "#ffffff"
            radius: 34
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.top: parent.top
            anchors.topMargin: 3
            antialiasing: true
            smooth: true
            Image {
                id: img1
                height: 32
                width: 32
                anchors.centerIn: parent
            }
        }
        Image {
            id: imgSwitchWish
            source: "qrc:/assets/icons/icon_refresh.svg"
            height: 16
            width: 16
            anchors {
                right: parent.right
                rightMargin: 16
                verticalCenter: parent.verticalCenter
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            if (wishLikeSwitcher.state == "like") {
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
            name: "wish"

            PropertyChanges {
                target: imgSwitchLike
                opacity: 0
            }
            PropertyChanges {
                target: imgSwitchWish
                opacity: 1
            }
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

            PropertyChanges {
                target: imgSwitchLike
                opacity: 1
            }
            PropertyChanges {
                target: imgSwitchWish
                opacity: 0
            }
        }
    ]
    transitions: [
        Transition {
            NumberAnimation {
                properties: "x,y,opacity"
                easing.type: Easing.InOutQuad
                duration: 150
            }


        }
    ]
}
