import QtQuick 2.0

Column {
    id: clockBlock
    spacing: 5

    property string timeText: ""
    property string dateText: ""

    Timer {
        interval: 1000; running: true; repeat: true
        triggeredOnStart: true
        onTriggered: {
            var d = new Date();
            dateText = d.toLocaleDateString(Qt.locale(), "dddd, MMMM d");
            timeText = d.toLocaleTimeString(Qt.locale(), "HH:mm");
        }
    }

    Text {
        text: clockBlock.dateText
        color: "white"
        font.family: "Cantarell"
        font.pointSize: 16
        font.weight: Font.Normal
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text {
        text: clockBlock.timeText
        color: "white"
        font.family: "Cantarell"
        font.pointSize: 64
        font.weight: Font.Light
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
