import QtQuick 2.0

Item {
    id: root
    signal hallChosen(int hall)

    readonly property int hallItemHeight: 250
    readonly property int hallItemWidth: contentContainer.width - 20

    readonly property int imageHeight: 200
    readonly property int imageWidth: 300

    Component {
        id: delegate
        Rectangle {
            height: hallItemHeight
            width: hallItemWidth

            color: "white"

            Column {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Image {
                    width: imageWidth
                    height: imageHeight
                    source: "file:///" + applicationDirPath + '/' + image
                    smooth: true
                }
                Text {
                    text: name
                    anchors.horizontalCenter: parent.horizontalCenter
//                    font.pointSize: 12
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: root.hallChosen(index)
            }
        }
    }

    GridView {
        cellHeight: hallItemHeight + 20
        cellWidth: parent.width
        anchors.fill: parent
        model: MenuModel
        delegate: delegate
    }
}
