import QtQuick 2.0
import com.stomt.qmlSDK 1.0

Item {
    id: stomtWidget
    height: 236
    width: 420
    property string appKey
    property string targetID
    property url targetImageUrl
    property string targetDisplayName

    onAppKeyChanged: Stomt.setAppID(stomtWidget.appKey)
    onTargetIDChanged: Stomt.setTargetID(stomtWidget.targetID)
    onTargetImageUrlChanged: targetWrapper.targetImageUrl = stomtWidget.targetImageUrl
    onTargetDisplayNameChanged: targetWrapper.targetDisplayName = stomtWidget.targetDisplayName

    FontLoader {
        id: lato
        source: "qrc:/assets/fonts/Lato-Regular.ttf"
    }

    Rectangle {
        id: stomtWrapper
        radius: 8
        clip: false
        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
        }

        border.width: 3
        border.color: "#768998"
        width: stomtWidget.width
        height: stomtWidget.height - 40
        anchors.margins: 10

        Column {
            id: column
            spacing: 5
            anchors.fill: parent
            anchors.margins: 15

            Rectangle {
                id: rectangle
                anchors.right: parent.right
                anchors.left: parent.left
                height: 65

                Rectangle {
                    id: rectangle1
                    height: parent.height
                    anchors.top: parent.top
                    anchors.left: parent.left
                    width: parent.width * .5
                    WishLikeSwitcher {
                        id: wishLikeSwitcher
                        anchors.left: parent.left
                        onIsPositiveChanged: {
                            if (textInput.text === "would "
                                    || textInput.text === "because ") {
                                if (wishLikeSwitcher.isPositive) {
                                    textInput.text = "because "
                                } else {
                                    textInput.text = "would "
                                }
                            }
                        }
                    }
                }

                Target {
                    id: targetWrapper
                    height: parent.height
                    width: parent.width * .5
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 5
                }
            }

            Item {
                id: item1
                anchors.right: parent.right
                anchors.left: parent.left
                height: 65

                TextInput {
                    id: textInput
                    color: "#424246"
                    text: qsTr("would ")
                    font.letterSpacing: 0
                    font.wordSpacing: 0
                    selectByMouse: true
                    font.family: lato.name
                    autoScroll: false
                    renderType: Text.NativeRendering
                    anchors.fill: parent
                    anchors.margins: 5
                    font.pixelSize: 14
                    wrapMode: TextInput.WrapAnywhere
                    maximumLength: 120
                    onTextChanged: {
                        limiter.text = textInput.length + " / 120"
                    }
                }
            }

            Item {
                id: footer
                anchors.right: parent.right
                anchors.left: parent.left
                height: 30
                Text {
                    id: limiter
                    text: qsTr("7 / 120")
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    color: "gray"
                }
            }
        }

        SubmitBtn {
            id: submitBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -40
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Connections {
            target: submitBtn
            onSendStomt: {
                Stomt.sendStomt(textInput.text, wishLikeSwitcher.isPositive)
            }
        }
    }
}
