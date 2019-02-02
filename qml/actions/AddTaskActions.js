// File: AddTaskActions.js
// Description: Actions for AddTaskPage.qml
.import Ubuntu.Components.Popups 1.3 as Popup

function add () {
    var newDescription = taskInput.displayText

    // Only perform this action when there is something in the taskInput
    if ( newDescription == "" ) {
        return
    }

    if ( taskModel.exists ( newDescription ) ) {
        Popup.PopupUtils.open ( dialog )
        return
    }

    console.log("check:", taskModel.exists ( newDescription ))

    taskModel.add ( newDescription )

    // Go back to the ListPage
    taskInput.text = ""
    bottomEdge.collapse ()
}
