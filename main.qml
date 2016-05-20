import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {
    id: root
    visible: true
    width: 480
    height: 860
    title: qsTr("Museum App")

    readonly property int menuWidth: 80

    readonly property int topBarHeight: 40
    readonly property string yellow: "#dddd33"

    readonly property int menuButtonWidth: 40
    readonly property int menuButtonHeight: 40

    property bool sideMenuSwitch: false

    property int currentHallId: 0

    property int currentPageId: 0

    signal menuOptionChosen(int option)

    onMenuOptionChosen: {
        if(option === 1 && option !== currentPageId)
        {
            currentPageId = option
            stackView.push(mainPage)
        }
    }

    property Component mainPage: MainPage{
        onHallChosen:{
            stackView.push(hallPage)
            currentHallId = hall
        }
    }

    property Component hallPage: HallPage{

    }

    onSideMenuSwitchChanged: {
        menuBehavior.enabled = true
        sideMenu.x = sideMenuSwitch ? 0 : container.x - menuWidth
    }

    Item {
        id: container
        anchors.fill: parent

        Rectangle {
            id: sideMenu
            height: parent.height
            width: menuWidth
            x: container.x - width
            z: contentContainer.z + 1
            color: yellow

            Behavior on x {
                id: menuBehavior
                enabled: false
                NumberAnimation {
                    id: menuNumberAnimation
                    easing.type: Easing.OutExpo
                    duration: 500
                    onRunningChanged: menuBehavior.enabled = false
                }
            }

            Component {
                id: delegate

                Item {

                    height: sideMenu.width + 10
                    width: sideMenu.width

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 10

                        Image {
                            width: sideMenu.width - 30
                            height: sideMenu.width - 30
                            source: image
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
                        onClicked: menuOptionChosen(index)
                    }
                }
            }

            GridView {
                cellHeight: hallItemHeight + 20
                cellWidth: parent.width
                anchors.fill: parent
                model: ListModel {
                    ListElement {
                        image: "qrc:/resources/side_menu_icons/ic_about.png"
                        name: "О проекте"
                    }
                    ListElement {
                        image: "qrc:/resources/side_menu_icons/ic_gallery.png"
                        name: "Экспонаты"
                    }
                }
                delegate: delegate
            }
        }

        Item {
            id: contentContainer
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width
            anchors.left: sideMenu.right

            Rectangle {
                id: topBar
                width: parent.width
                height: topBarHeight
                color: yellow

                Rectangle {
                    id: menuButton
                    width: menuButtonWidth
                    height: menuButtonHeight
                    color: "#ffffff"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: sideMenuSwitch = !sideMenuSwitch
                    }
                }
            }

            StackView {
                id: stackView
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 10
                focus: true
                initialItem: mainPage
            }
        }
    }
}
