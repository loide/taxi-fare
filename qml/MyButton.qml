import QtQuick 1.0

Item {
    id: button
    width: buttonImage.width
    height: buttonImage.height

    property alias imageSource: buttonImage.source
    property alias buttonArea: buttonArea
    property string defaultImage: "qrc:data/images/zoom_in.png"
    property string pressedImage: ""
    property string disabledImage: ""

    signal clicked

    Image {
        id: buttonImage
    }

    MouseArea {
        id: buttonArea
        anchors.fill: buttonImage
        onClicked:  { buttonImage.source = button.defaultImage; button.clicked() }
    }

    states: [
        State {
            name: "pressed"
            when: buttonArea.pressed
            PropertyChanges {
                target: buttonImage
                source: button.pressedImage
            }
        },
        State {
            name: "enabled"
            PropertyChanges {
                target: buttonImage
                source: button.defaultImage
            }
        },
        State {
            name: "disabled"
            PropertyChanges {
                target: buttonImage
                source: button.disabledImage
            }
        }
    ]
}
