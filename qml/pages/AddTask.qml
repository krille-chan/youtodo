import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import QtQuick.LocalStorage 2.0
import Ubuntu.Components.Popups 1.3

Page {
    id: addTaskPage
    anchors.fill: parent

    function add () {
        db.transaction(
            function(tx) {
                if ( taskInput.displayText == "" ) {
                    return
                }

                var rs = tx.executeSql('SELECT * FROM Tasks WHERE description = "' + taskInput.displayText + '"')
                if ( rs.rows.length > 0 ) {
                    PopupUtils.open(dialog)
                    return
                }
                tx.executeSql('INSERT INTO Tasks VALUES("' + taskInput.displayText + '", 0)')
                taskInput.text = " "
                if ( mainStack.depth === 1 ) {
                    listPage.update()
                    bottomEdge.collapse()
                }
                else {
                    mainStack.clear ()
                    mainStack.push (Qt.resolvedUrl("./List.qml"))
                }
            }
        )

    }

    header: PageHeader {
        id: header
        title: i18n.tr('Add Task')
        trailingActionBar {
            actions: [
            Action {
                iconName: "ok"
                onTriggered: add ()
            }
            ]
        }
    }

    TextField {
        id: taskInput
        placeholderText: i18n.tr("What to do?")
        width: parent.width - this.height
        maximumLength: 35
        anchors.top: header.bottom
        anchors.topMargin: this.height
        anchors.horizontalCenter: header.horizontalCenter
        Keys.onReturnPressed: add ()
    }

    Image {
        anchors.top: taskInput.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: taskInput.height
        width: parent.width / 1.5
        height: width
        source: "../../assets/logo.svg"
    }

    Component {
        id: dialog
        Dialog {
            id: dialogue
            title: i18n.tr("Task already exists!")
            Button {
                text: "OK"
                onClicked: PopupUtils.close(dialogue)
            }
        }
    }

}
