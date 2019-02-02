// File: StorageActions.js
// Description: Actions to inlcude in other scripts. Needs including:
// .import QtQuick.LocalStorage 2.0 as Database
// to work!
var db = Database.LocalStorage.openDatabaseSync("YouTodoTasks", "1.0", "The Example QML SQL!", 1000000)

function transaction ( query, callback ) {
    try {
        db.transaction(
            function(tx) {
                var result = tx.executeSql( query )
                if ( callback ) callback ( result )
            }
        )
    }
    catch ( e ) {
        if ( callback ) callback ( e )
    }
}
