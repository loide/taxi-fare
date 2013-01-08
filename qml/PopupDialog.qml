import QtQuick 1.0
import com.nokia.meego 1.1

Item {
    id: popupContainer
    height: 200
    width: 300

    property real latitude: 0.0
    property real longitude: 0.0
    property alias inputText: inputName.text

    signal popupOk(string text)

    Rectangle {
        id: background
        anchors.fill: parent
        color: "white"
        border.width: 2
        border.color: "black"
    }

    Text {
        id: dscText
        text: "Write the landmark name"
        color: "#616161"
        font.pixelSize: 15
        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 30
    }

    TextField {
        id: inputName
        width: parent.width
        errorHighlight: false
        platformSipAttributes: SipAttributes { actionKeyHighlighted: true }
        font.pixelSize: 20
        anchors.left: parent.left
        anchors.top: dscText.bottom
        anchors.topMargin: 40

        Keys.onReturnPressed: {
            parent.focus = true
            popupContainer.popupOk(inputName.text)
            inputName.text = ""
        }

        MyButton {
            id: okButton
            state: "enabled"
            defaultImage: "qrc:data/images/bt_ok_on.png"
            pressedImage: "qrc:data/images/bt_ok_off.png"
            disabledImage: "qrc:data/images/bt_ok_disabled.png"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                dscText.focus = true
                inputName.focus = false
                popupContainer.popupOk(inputName.text)
                inputName.text = ""
            }
        }
    }
}
