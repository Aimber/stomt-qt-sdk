import QtQuick 2.0
import com.stomt.qmlSDK 1.0
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: sendSuccessful
    border.width: 3
    state: "invisible"
    radius: 8
    border.color: "#768998"
    onStateChanged: {
        if (state === "invisible") {
            enabled = false
        } else {
            enabled = true
        }
    }

    property string stomtShortLink

    opacity: 0

    Timer {
        id:timerBack
        interval: 15000
        running: false
        repeat: false
        onTriggered: sendSuccessful.state = "invisible"
    }

    Connections {
        target: Stomt
        onStomtSuccessfulSend: {
            stomtShortLink = shortlink
            sendSuccessful.state = "visible"
            timerBack.start()
        }
    }

    LinearGradient {
        id: gradient
        anchors.fill: parent
        anchors.margins: 3
        clip: true
        cached: true
        start: Qt.point(0, 0)
        end: Qt.point(gradient.width, gradient.height)
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "#0a2965"
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation {
                        from: "#0a2965"
                        to: "#1da1f2"
                        duration: 5000
                    }
                    ColorAnimation {
                        from: "#1da1f2"
                        to: "#0a2965"
                        duration: 5000
                    }
                }
            }
            GradientStop {
                position: 1.0
                color: "#1da1f2"
                SequentialAnimation on color {
                    loops: Animation.Infinite

                    ColorAnimation {
                        from: "#1da1f2"
                        to: "#0a2965"
                        duration: 100000
                    }
                    ColorAnimation {
                        from: "#0a2965"
                        to: "#1da1f2"
                        duration: 100000
                    }
                }
            }
        }
    }
    Item {
        anchors.fill: parent
        clip: true

        MouseArea {
            id: ma
            anchors.fill: parent
            hoverEnabled: true
            onPositionChanged: {
                attractor.pointX = mouseX
                attractor.pointY = mouseY
            }
        }

        Attractor {
            id: attractor
            Component.onCompleted: {
                attractor.x = parent.width * .5
                attractor.y = 50
            }

            system: particleSystem
            affectedParameter: Attractor.Acceleration
            strength: 8000000
            proportionalToDistance: Attractor.InverseQuadratic
        }

        ParticleSystem {
            id: particleSystem
        }

        Emitter {
            id: emitter
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }

            width: parent.width - 10
            height: 100
            system: particleSystem
            emitRate: 15
            lifeSpan: 5000
            lifeSpanVariation: 1000
            size: 8
            endSize: 20
            sizeVariation: 5
            velocity: AngleDirection {
                angle: -90
                magnitude: 50
                magnitudeVariation: 25
                angleVariation: 10
            }
        }

        ImageParticle {
            height: 16
            width: 16
            source: "qrc:/assets/particle/dot.png"
            system: particleSystem
            opacity: .5
        }

        Image {
            id: bgGlow
            width: 500
            height: width
            opacity: .3
            source: "qrc:/assets/particle/backgroundGlow.png"
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: -width * .65
            }
        }
    }

    MouseArea {
        anchors.centerIn: parent
        width: 300
        height: 500
        propagateComposedEvents: true
        onClicked: {
            Qt.openUrlExternally(stomtShortLink)
            sendSuccessful.state = "invisible"
        }

        Text {
            id: txtLink
            anchors.centerIn: parent
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            color: "white"
            text: qsTr("View your feedback \n on stomt.com")
        }
    }

    MouseArea {
        width: 32
        height: width
        anchors {
            top: parent.top
            topMargin: 10
            rightMargin: 5
            right: parent.right
        }
        onClicked: sendSuccessful.state = "invisible"
        Image {
            id: imgClose
            source: "qrc:/assets/icons/icon_close.svg"
            sourceSize: Qt.size(24, 24)
        }
    }

    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: sendSuccessful
                opacity: 1
            }
        },
        State {
            name: "invisible"
            PropertyChanges {
                target: sendSuccessful
                opacity: 0
            }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation {
                properties: "opacity"
                easing.type: Easing.InOutQuad
                duration: 500
            }
        }
    ]
}
