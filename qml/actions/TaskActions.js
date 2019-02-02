// File: TaskActions.js
// Description: Actions for Task.qml
.import QtQuick.LocalStorage 2.0 as Database
Qt.include("StorageActions.js")

function mark () {
    var mark = 1
    if ( checkBox.checked ) mark = 0
    checkBox.checked = mark
    transaction ( 'UPDATE Tasks SET done = ' + mark + ' WHERE description = "' + task._description + '"' )
}


function remove () {
    transaction ( 'DELETE FROM Tasks WHERE description = "' + task._description + '"' )
    listPage.updated ()
}
