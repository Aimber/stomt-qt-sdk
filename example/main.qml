import QtQuick 2.9
import QtQuick.Window 2.2
import com.stomt.qmlSDK 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Stomt Example Widget")

    StomtWidget {
        anchors.centerIn: parent
        targetDisplayName: "QtWidgetTest"
        targetImageUrl: "qrc:/target.png"
        targetID: "qtwidgettest"

        // Normally you should *never* share appkeys
        // but for demonstration purposes we use here
        // the test server.
        appKey: "Q1Y7qiRJDu48NsEkHTtB0GCwo"

        // If you want to test your
        // integration use: https://test.stomt.com/
        useTestServer: true
    }
}
