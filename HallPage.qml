import QtQuick 2.0

Item {
    id: root

    readonly property int exhibitItemHeight: 250
    readonly property int exhibitItemWidth: contentContainer.width - 20

    readonly property int imageHeight: 200
    readonly property int imageWidth: 300

    Component {
        id: delegate
        Rectangle {
            height: exhibitItemHeight
            width: exhibitItemWidth

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
//                onClicked: root.exhibitChosen(index)
            }
        }
    }

    GridView {
        cellHeight: exhibitItemHeight + 20
        cellWidth: parent.width
        anchors.fill: parent
        model: HallModels[currentHallId]
        delegate: delegate
    }
}
