import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

ListItem {
    id: task

    property var _description: description
    property var _done: done

    onClicked: taskModel.toggle ( task._description )

    ListItemLayout {
        id: layout
        title.text: _description
        CheckBox {
            id: checkBox
            SlotsLayout.position: SlotsLayout.Leading
            checked: _done
        }

    }

    leadingActions: ListItemActions {
        actions: [
        Action {
            iconName: "delete"
            onTriggered: taskModel.cancel ( task._description )
        }
        ]
    }
}
