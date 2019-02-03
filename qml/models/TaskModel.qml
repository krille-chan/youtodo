import QtQuick 2.4
import QtQuick.LocalStorage 2.0 as Database
import "../scripts/StorageActions.js" as StorageActions

ListModel {
    id: model

    function _init() {
        transaction ( 'CREATE TABLE IF NOT EXISTS Tasks(description TEXT, done BOOL)' )
        transaction ( 'SELECT * FROM Tasks', _updateList )
    }


    function _updateList ( rs ) {
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


    function _getIdFromDescription ( description ) {
        for (var i = 0; i < model.count; i++) {
            if ( model.get(i).description === description ) {
                return i
            }
        }
        return -1
    }

    function add ( description ) {
        StorageActions.transaction('INSERT INTO Tasks VALUES("' + description + '", 0)')
        model.append ( { "description": description, "done": false } )
    }


    function toggle ( description ) {
        var id = _getIdFromDescription ( description )
        var newDone = !(model.get( id ).done)
        StorageActions.transaction ( 'UPDATE Tasks SET done = ' + newDone + ' WHERE description = "' + description + '"' )
        model.set ( id, { "done": newDone })
    }


    function cleanUp () {
        StorageActions.transaction ( 'DELETE FROM Tasks WHERE done = 1' )
        for (var i = 0; i < model.count; i++) {
            if ( model.get(i).done ) {
                model.remove ( i )
                i--
            }
        }
    }


    function cancel ( description ) {
        var id = _getIdFromDescription ( description )
        if ( id === -1 ) return
        StorageActions.transaction ( 'DELETE FROM Tasks WHERE description = "' + description + '"' )
        model.remove ( id )
    }


    function exists ( description ) {
        return _getIdFromDescription ( description ) !== -1
    }

    Component.onCompleted: _init ()
}
