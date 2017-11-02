import QtQuick 2.7
import QtQuick.Controls 1.4
import com.stomt.qmlSDK 1.0

Rectangle {
    id: submitBtn
    width: 80
    height: 80
    color: "#768998"
    radius: 40
    border.color: "#e1e8ed"
    border.width: 6

    signal sendStomt
    property bool isLoading: false


    Image {
        id: imgArrow
        anchors.centerIn: parent
        height: 30
        width: 30
        sourceSize: Qt.size(30, 30)
        source: "qrc:/assets/icons/icon_arrow-pointing-to-right.svg"
    }

    Image {
        id: imgCorrect
        anchors.centerIn: parent
        height: 30
        width: 30
        opacity: 0
        sourceSize: Qt.size(30, 30)
        source: "qrc:/assets/icons/icon_correct.svg"
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        width: 30
        height: 30
        opacity: 0
        running: false
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            submitBtn.state = "submit"
            isLoading = true
            sendStomt()
        }
        onHoveredChanged: {
            if (!isLoading) {
                submitBtn.state = "hover"
            }
        }

        onExited: {
            if (!isLoading) {
                submitBtn.state = ""
            }
        }
    }
    Timer {
        id: timer
        interval: 1000
        onTriggered: {
            submitBtn.state = ""
        }
    }

    Connections {
        target: Stomt
        onStomtSuccessfulSend: {
            submitBtn.state = "success"
            isLoading = false
            timer.start()
        }
    }

    states: [
        State {
            name: "hover"

            PropertyChanges {
                target: submitBtn
                color: "#ffcd64"
            }
        },
        State {
            name: "submit"

            PropertyChanges {
                target: imgArrow
                opacity: 0
            }

            PropertyChanges {
                target: busyIndicator
                running: true
                opacity: 1
            }
        },
        State {
            name: "success"

            PropertyChanges {
                target: imgCorrect
                opacity: 1
            }

            PropertyChanges {
                target: submitBtn
                color: "#d7ff0d"
            }

            PropertyChanges {
                target: imgArrow
                opacity: 0
            }
        }
    ]
    transitions: [
        Transition {
            from: ""
            to: "hover"

            ColorAnimation {
                target: submitBtn
                from: "#768998"
                to: "#ffcd64"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "hover"
            to: ""

            ColorAnimation {
                target: submitBtn
                from: "#ffcd64"
                to: "#768998"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "submit"
            to: "success"
            NumberAnimation {
                properties: "opacity"
                easing.type: Easing.InOutQuad
                duration: 300
            }
        },
        Transition {
            from: "success"
            to: ""
            NumberAnimation {
                properties: "opacity"
                easing.type: Easing.InOutQuad
                duration: 300
            }
        },
        Transition {
            from: "success"
            to: ""

            ColorAnimation {
                target: submitBtn
                from: "#d7ff0d"
                to: "#768998"
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
    ]
}
