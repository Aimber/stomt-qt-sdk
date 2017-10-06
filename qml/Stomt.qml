import QtQuick 2.0

Item {
    id: stomt
    height: 236
    width: 420

    FontLoader { id: lato; source: "qrc:/assets/fonts/Lato-Regular.ttf" }


    Connections {
        target:stomtPlugin
        onTargetImageUrlReceived: {
            print("as");
            print(url);
        }
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
        width: stomt.width
        height: stomt.height - 40
        anchors.margins: 10

        Column {
            id: column
            spacing: 15
            anchors.fill: parent
            anchors.margins: 15

            Rectangle {
                anchors.right: parent.right
                anchors.left: parent.left
                height: stomtWrapper.height * 0.25

                Rectangle {
                    id: rectangle1
                    height: parent.height
                    anchors.top: parent.top
                    anchors.left: parent.left
                    width: parent.width * .5
                    WishLikeSwitcher {
                        id:wishLikeSwitcher
                        anchors.left: parent.left
                    }
                }

                Target {
                    id: targetWrapper
                    height: parent.height
                    width: parent.width * .5
                    anchors.right: parent.right
                    anchors.top: parent.top
                }
            }

            Item {
                id: item1
                anchors.right: parent.right
                anchors.left: parent.left
                height: stomtWrapper.height * 0.25

                TextInput {
                    id: textInput
                    color: "#424246"
                    text: qsTr("weilweiilweilwei eilweilwelwe ilweilweil")
                    font.letterSpacing: 0
                    font.wordSpacing: 0
                    font.family: lato.name
                    autoScroll: false
                    renderType: Text.NativeRendering
                    anchors.fill: parent
                    anchors.margins: 5
                    font.pixelSize: 14
                    wrapMode: TextInput.WrapAnywhere
                    maximumLength: 120

                }


            }

            Item {
                id: item2
                anchors.right: parent.right
                anchors.left: parent.left
                height: stomtWrapper.height * 0.2
            }
        }

        SubmitBtn {
            id: submitBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -40
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Connections{
            target:submitBtn
            onSendStomt:{
                stomtPlugin.sendStomt(textInput.text, wishLikeSwitcher.isPositive)
            }
        }
    }
}
