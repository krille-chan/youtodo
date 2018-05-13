import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Page {
    anchors.fill: parent

    header: PageHeader {
        title: i18n.tr('Info')
    }

    Label {
        id: label1
        anchors.centerIn: parent
        font.pixelSize: 52
        text: i18n.tr('YouTodo by Christian Pauly')
    }
    Label {
        anchors.top: label1.bottom
        anchors.horizontalCenter: label1.horizontalCenter
        text: i18n.tr('Email:') + ' <a href="mailto: christian-pauly@posteo.de">christian-pauly@posteo.de</a>'
        onLinkActivated: Qt.openUrlExternally(link)
    }

}
