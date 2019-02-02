// File: TaskActions.js
// Description: Actions for Task.qml

function toggle () {
    taskModel.toggle ( task._description )
}


function remove () {
    taskModel.cancel ( task._description )
}
