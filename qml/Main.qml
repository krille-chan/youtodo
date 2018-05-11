import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import QtQuick.LocalStorage 2.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'youtodo.christianpauly'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    property var db: LocalStorage.openDatabaseSync("YouTodoTasks", "1.0", "The Example QML SQL!", 1000000)

    PageStack {
        id: mainStack
    }

    Component.onCompleted: mainStack.push(Qt.resolvedUrl("./pages/List.qml"))

}
