import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Page {
    anchors.fill: parent

    header: PageHeader {
        id: header
        title: i18n.tr('Info')
    }

    Image {
        id: coffeeImage
        anchors.top: header.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: parent.width / 4
        width: parent.width / 2
        height: width
        source: "../../assets/coffee.svg"
    }


    Button {
        id: coffeeButton
        anchors.top: coffeeImage.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: height
        color: UbuntuColors.green
        onClicked: Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=ZAGCFNJ2SKZY8")
        text: i18n.tr('Buy me a coffee')
    }


    Label {
        id: label2
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: height
        text: i18n.tr('YouTodo by Christian Pauly') + "\n" + i18n.tr('Email: ') + ' christian-pauly@posteo.de'
        onLinkActivated: Qt.openUrlExternally(link)
        horizontalAlignment: Text.AlignHCenter
    }

}
