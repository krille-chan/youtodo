import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import QtQuick.LocalStorage 2.0

ListItem {
    id: task

    property var text: ""
    property var done: false


    onClicked: mark ()

    function mark () {
        console.log ( checkBox.checked )
        var mark = 1
        if ( checkBox.checked ) mark = 0
        checkBox.checked = mark
        db.transaction(
            function(tx) {
                tx.executeSql('UPDATE Tasks SET done = ' + mark + ' WHERE description = "' + task.text + '"')
            }
        )
    }

    ListItemLayout {
        id: layout
        title.text: text
        CheckBox {
            id: checkBox
            SlotsLayout.position: SlotsLayout.Leading
            checked: done
        }

    }

    // Delete Button
    leadingActions: ListItemActions {
        actions: [
        Action {
            iconName: "delete"
            onTriggered: {
                db.transaction(
                    function(tx) {
                        tx.executeSql('DELETE FROM Tasks WHERE description = "' + task.text + '"')
                    }
                )
                task.destroy()
            }
        }
        ]
    }

}
