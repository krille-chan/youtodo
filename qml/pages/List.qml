import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import QtQuick.LocalStorage 2.0
import "../components"

Page {
    id: listPage
    anchors.fill: parent
    Component.onCompleted: update ()

    function update() {
        db.transaction(
            function(tx) {
                try{
                    // Create the database if it doesn't already exist
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Tasks(description TEXT, done BOOL)')

                    // Show all added tasks
                    var rs = tx.executeSql('SELECT * FROM Tasks')

                    taskList.children = ""
                    emptyListLabel.visible = rs.rows.length == 0
                    console.log(rs.rows.length)
                    for (var i = 0; i < rs.rows.length; i++) {
                        var newTask = Qt.createComponent("../components/Task.qml")
                        newTask.createObject(taskList, {"text": rs.rows.item(i).description, "done": rs.rows.item(i).done })
                    }
                }
                catch ( e ) {
                    console.error ( e )
                }
            }
        )
    }


    // ============================== HEADER ==============================
    header: PageHeader {
        id: header
        title: i18n.tr('YouTodo')
        trailingActionBar {
            actions: [
            Action {
                text: i18n.tr("Info")
                iconName: "info"
                onTriggered: {
                    mainStack.push(Qt.resolvedUrl("./Info.qml"))
                }
            },
            Action {
                text: i18n.tr("Clear")
                iconName: "delete"
                onTriggered: {
                    db.transaction(
                        function(tx) {
                            tx.executeSql('DELETE FROM Tasks WHERE done = 1')
                        }
                    )
                    update ()
                }
            },
            Action {
                text: i18n.tr("Add task")
                iconName: "add"
                onTriggered: {
                    mainStack.push(Qt.resolvedUrl("./AddTask.qml"))
                }
            }
            ]
        }
    }


    // ============================== LIST OF ALL TASKS ==============================

    ScrollView {
        width: parent.width
        height: parent.height - header.height
        anchors.top: header.bottom
        contentItem: Column {
            id: taskList
            width: root.width
        }
    }

    Label {
        id: emptyListLabel
        visible: false
        text: i18n.tr("Swipe from the bottom to enter some tasks ...")
        anchors.centerIn: parent
    }

    // ============================== BOTTOM EDGE ==============================
    BottomEdge {
        id: bottomEdge
        height: parent.height
        contentComponent: Rectangle {
            width: listPage.width
            height: listPage.height
            color: "white"
            AddTask { }
        }
    }
}
