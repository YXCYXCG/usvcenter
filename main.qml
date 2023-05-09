import QtQuick          2.12
import QtQuick.Window   2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts  1.12

ApplicationWindow {
    id: root_window
    visible:                        true
    width:                          960
    height:                         720
    title:                          qsTr("USV综合监控系统")
    minimumWidth:                   450
    minimumHeight:                  240
    property int index:             1

    property int mapMode:           0

    header: ToolBar {
        id:                         tabBar
        RowLayout {
            id:                     rowLayout
            anchors.fill:           parent
            spacing:                10
            //head
            ColoredImage {
                id:                 innerImage
                width:              30
                height:             width
                source:             "/images/menu"
                color:              "black"
            }
            //first Button
            MyButton {
                id:                 firstButton
                text:               qsTr("三维助航")
                icon.source:        "/images/1"
                onClicked: {
                    clearAllChecks()
                    checked = true
                    index = 1
                }
            }
            //second Button
            MyButton {
                text:               qsTr("场景感知")
                icon.source:        "/images/2"
                onClicked: {
                    clearAllChecks()
                    checked = true
                    index = 2
                }
            }
            //third Button
            MyButton {
                text:               qsTr("视频监控")
                icon.source:        "/images/3"
                onClicked: {
                    clearAllChecks()
                    checked = true
                    index = 3
                }
            }
            MyButton {
                text:               qsTr("航道地图")
                icon.source:        "/images/4"
                onClicked: {
                    clearAllChecks()
                    checked = true
                    index = 4
                }
            }
        }
    }

    Component.onCompleted: {
        firstButton.checked = true
    }

    function clearAllChecks() {
        for (var i=0; i<rowLayout.children.length; i++) {
           if (rowLayout.children[i].toString().startsWith("MyButton"))
                rowLayout.children[i].checked = false
            }
    }

    //界面的显示的形式有多种多样的，这里不做多说明。如前三个用的SwipeView。
    Loader {
        id:             firstPage
        anchors.fill:   parent
        visible:        index==1
        source:         "TestPage1.qml"
    }
    Loader {
        id:             secondPage
        anchors.fill:   parent
        visible:        index==2
        source:         "TestPage2.qml"
    }
    TestPage3 {
        id:             thirdPage
        anchors.fill:   parent
        visible:        index==3
    }
    TestPage4 {
        id:             fourthPage
        anchors.fill:   parent
        visible:        index==4
    }
    Row {
        visible: index==4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
        anchors.horizontalCenter: parent.horizontalCenter
        PlanButton {
            id: id1
            text:               qsTr("开始规划")
            anchors.right: id2.left
            anchors.rightMargin: 30
            onClicked: {
                checked = true
                root_window.mapMode = 1
            }
        }
        PlanButton {
            id: id2
            text:               qsTr("发送航点")
            onClicked: {
                checked = true
                root_window.mapMode = 0
            }
        }
        PlanButton {
            id: id3
            anchors.left: id2.right
            anchors.leftMargin: 30
            text:               qsTr("取消规划")
            onClicked: {
                checked = true
                root_window.mapMode = 0
            }
        }
    }
}
