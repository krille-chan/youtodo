// File: ListActions.js
// Description: Actions for ListPage.qml
.import QtQuick.LocalStorage 2.0 as Database
Qt.include("StorageActions.js")

function update() {
    transaction ( 'CREATE TABLE IF NOT EXISTS Tasks(description TEXT, done BOOL)' )
    transaction ( 'SELECT * FROM Tasks', updateList )
}

function updateList ( rs ) {
    model.clear()
    for (var i = 0; i < rs.rows.length; i++) {
        model.append ( rs.rows.item(i) )
    }
}

function cleanUp () {
    transaction ( 'DELETE FROM Tasks WHERE done = 1' )
    update ()
}
