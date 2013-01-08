import QtQuick 1.0
import com.nokia.meego 1.1

Item {
    id: toolbar
    width: parent.width
    height: 70

    signal addPosition()
    signal zoomIn()
    signal zoomOut()
    signal info()

    Rectangle {
        id: background
        opacity: 0.5
        color: "#343434"
        anchors.fill: parent
    }

    Row {
        anchors.centerIn: parent
        spacing: 20

        Button {
            id: addButton
            iconSource: "qrc:/data/images/car_taxi.png"
            width: 50
            onClicked: toolbar.addPosition()
        }

        Button {
            id: zoomIn
            iconSource: "qrc:/data/images/zoom_in.png"
            width: 50            
            onClicked: toolbar.zoomIn();
        }

        Button {
            id: zoomOut
            iconSource: "qrc:/data/images/zoom_out.png"
            width: 50            
            onClicked: toolbar.zoomOut()
        }

        Button {
            id: info
            iconSource: "qrc:/data/images/information.png"
            width: 50
            onClicked: toolbar.info()
        }
    }
}
