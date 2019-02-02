// File: AddTaskActions.js
// Description: Actions for AddTaskPage.qml
.import QtQuick.LocalStorage 2.0 as Database
Qt.include("StorageActions.js")

function add () {

    // Only perform this action when there is something in the taskInput
    if ( taskInput.displayText == "" ) {
        return
    }
    
    db.transaction(
        function(tx) {

            // If the task already exists, show an error dialog
            var rs = tx.executeSql('SELECT * FROM Tasks WHERE description = "' + taskInput.displayText + '"')
            if ( rs.rows.length > 0 ) {
                PopupUtils.open(dialog)
                return
            }
            tx.executeSql('INSERT INTO Tasks VALUES("' + taskInput.displayText + '", 0)')
            taskInput.text = " "

            // Go back to the listPage and trigger the update signal
            if ( mainStack.depth === 1 ) {
                listPage.updated()
                bottomEdge.collapse()
            }
            else {
                mainStack.pop()
                mainStack.currentPage.updated()
            }
        }
    )
}
