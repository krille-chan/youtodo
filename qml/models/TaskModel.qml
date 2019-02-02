import QtQuick 2.4
import QtQuick.LocalStorage 2.0 as Database
import "../actions/TaskModelActions.js" as TaskModelActions
import "../actions/StorageActions.js" as StorageActions

ListModel {
    id: model

    function add ( description ) {
        StorageActions.transaction('INSERT INTO Tasks VALUES("' + description + '", 0)')
        model.append ( { "description": description, "done": false } )
    }


    function toggle ( description ) {
        var id = TaskModelActions.getIdFromDescription ( description )
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
        var id = TaskModelActions.getIdFromDescription ( description )
        if ( id === -1 ) return
        StorageActions.transaction ( 'DELETE FROM Tasks WHERE description = "' + description + '"' )
        model.remove ( id )
    }


    function exists ( description ) {
        return TaskModelActions.getIdFromDescription ( description ) !== -1
    }

    Component.onCompleted: TaskModelActions.init ()
}
