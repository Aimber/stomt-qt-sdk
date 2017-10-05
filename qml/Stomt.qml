import QtQuick 2.0

Item {
    id: stomt
    height: 236
    width: 420

    FontLoader { id: lato; source: "qrc:/assets/fonts/Lato-Regular.ttf" }

    Component.onCompleted: {
        stomtPlugin.getTargetImageUrl(targetName.text)
    }

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
            spacing: 10
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

                Rectangle {
                    id: targetWrapper
                    anchors.top: parent.top
                    anchors.right: parent.right
                    height: parent.height
                    width: parent.width * .5

                    Rectangle {
                        id: target
                        x: 8
                        y: 5
                        color: "#e1e8ed"
                        height: 40
                        width: 177
                        radius: 40

                        Rectangle {
                            id: targetImage
                            width: 34
                            height: 34
                            radius: 34
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 4
                        }
                        Text {
                            id: targetName
                            text: qsTr("screenplay")
                            font.family: lato.name
                            renderType: Text.NativeRendering
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: targetImage.right
                            anchors.leftMargin: 8

                        }
                    }
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
                    text: qsTr("weilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilweilw eilweilwelwe ilweilweil")
                    font.letterSpacing: 0
                    font.wordSpacing: 0
                    font.family: lato.name
                    autoScroll: false
                    renderType: Text.NativeRendering
                    anchors.fill: parent
                    font.pixelSize: 14
                    wrapMode: TextInput.WrapAnywhere
                    anchors.margins: 0
                    maximumLength: 140

                }


            }

            Item {
                id: item2
                anchors.right: parent.right
                anchors.left: parent.left
                height: stomtWrapper.height * 0.25
            }
        }

        Rectangle {
            id: rectangle
            width: 80
            height: 80
            color: "#768998"
            radius: 40
            border.color: "#e1e8ed"
            border.width: 6
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -40
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: text1
                color: "#ffffff"
                text: qsTr(">")
                font.family: lato.name
                font.bold: false
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 34
            }
            MouseArea {
                anchors.fill: parent
                onClicked: stomtPlugin.sendStomt(targetName.text,textInput.text,wishLikeSwitcher.isPositive)
            }
        }
    }
}
