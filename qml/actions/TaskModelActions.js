// File: TaskModelActions.js
// Description: Actions for TaskModel.qml
.import QtQuick.LocalStorage 2.0 as Database
Qt.include("StorageActions.js")

function init() {
    transaction ( 'CREATE TABLE IF NOT EXISTS Tasks(description TEXT, done BOOL)' )
    transaction ( 'SELECT * FROM Tasks', updateList )
}


function updateList ( rs ) {
    model.clear()
    for (var i = 0; i < rs.rows.length; i++) {
        var done = false
        if ( rs.rows.item(i).done ) done = true
        model.append ( {
            "description": rs.rows.item(i).description,
            "done": done
        } )
    }
}


function getIdFromDescription ( description ) {
    for (var i = 0; i < model.count; i++) {
        if ( model.get(i).description === description ) {
            return i
        }
    }
    return -1
}
