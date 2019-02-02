// File: MainActions.js
// Description: Actions for all Qml Pages and Components
function pushPage ( page ) {
    var path = "../pages/%1Page.qml".arg( page )
    mainStack.push( Qt.resolvedUrl( path ) )
}
