import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import "../actions/AddTaskActions.js" as AddTaskActions

Page {
    id: addTaskPage
    anchors.fill: parent

    // ============================== HEADER ===================================
    header: PageHeader {
        id: header
        title: i18n.tr('Add Task')
        trailingActionBar {
            actions: [
            Action {
                iconName: "ok"
                onTriggered: AddTaskActions.add ()
            }
            ]
        }
    }

    // ============================== CONTENT ==================================

    TextField {
        id: taskInput
        placeholderText: i18n.tr("What to do?")
        width: parent.width - this.height
        anchors.top: header.bottom
        anchors.topMargin: this.height
        anchors.horizontalCenter: header.horizontalCenter
        Keys.onReturnPressed: AddTaskActions.add ()
    }

    Image {
        anchors.top: taskInput.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: taskInput.height
        width: parent.width / 1.5
        height: width
        source: "../../assets/addTask.svg"
    }

    // ======================== TASK EXISTS DIALOG =============================
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
