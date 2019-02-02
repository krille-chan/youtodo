import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import "actions/MainActions.js" as MainActions

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'youtodo.christianpauly'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    PageStack {
        id: mainStack
        Component.onCompleted: MainActions.pushPage ( "List" )
    }

}
