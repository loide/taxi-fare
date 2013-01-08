import QtQuick 1.0
import QtMobility.location 1.2
import Qt.labs.components.native 1.0

Window {
    id: main
    clip: true

    MainMap {
        id: mainMap

        Component.onCompleted: {
            controller.init()
            controller.landmarks()
            currentLocationCircle = positionSource.position.coordinate
        }
    }

    PopupDialog {
        id: popupDialog
        visible: false

        onPopupOk: {
            console.log("### saving landmark...")
            controller.saveLandmark(popupDialog.latitude, popupDialog.longitude, text)
            popupDialog.visible = !popupDialog.visible
            popupDialog.inputText = ""
        }
    }

    MyToolbar {
        id: myToolbar
        visible: true
        anchors.bottom: mainMap.bottom

        onAddPosition: {
            popupDialog.latitude = mainMap.positionSource.position.coordinate.latitude
            popupDialog.longitude = mainMap.positionSource.position.coordinate.longitude
            popupDialog.visible = !popupDialog.visible
            console.log("### adding position latitude: "+popupDialog.latitude + " -- longitude: "+popupDialog.longitude)
        }
        onZoomIn: {
            mainMap.mapObject.zoomLevel += 1
            console.log("### zoomIn")
        }
        onZoomOut: {
            mainMap.mapObject.zoomLevel -= 1
            console.log("### zoomOut")
        }

        onInfo: {
            console.log("INFO");
        }
    }

    Page {
        orientationLock: PageOrientation.LockPortrait
    }
}
