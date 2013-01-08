import QtQuick 1.0
import QtMobility.location 1.2

Item {
    id: mapContainer

    width: parent.width
    height: parent.height

    property alias mapObject: map
    property alias currentLocationCircle: currentPosition.center
    property alias positionSource: positionSource

    Coordinate {
        id: initialCoordinate
        latitude: -3.0607
        longitude: -60.0130
    }

    LandmarkModel {
        id: allLandmarksModel
        autoUpdate: true
        importFile: "/opt/taxi-fare/mylandmarks.lmx"
        sortBy: LandmarkModel.NameSort
        sortOrder: LandmarkModel.AscendingOrder
        limit: 100
    }

    PositionSource {
        id: positionSource
        updateInterval: 30000
        active: true
        onPositionChanged: {
            console.log("### current position: "+position.coordinate.latitude + " -- "+position.coordinate.longitude)
        }
    }

    Map {
        id: map
        plugin: Plugin { name: "nokia" }
        zoomLevel: 15
        center: initialCoordinate

        size.width: parent.width
        size.height: parent.height

        MapObjectView {
            id: allLandmarks
            model: allLandmarksModel
            delegate: Component {
                id: landDelegate
                MapGroup {
                    id: groupDelegate
                    MapText {
                        id: text
                        text: landmark.name
                        font.pixelSize: 12
                        font.bold: true
                        font.capitalization: Font.Capitalize
                        color: "#616161"
                        coordinate: landmark.coordinate
                        offset.y: -10
                        z: 2
                    }
                    MapImage {
                        id: image
                        source: "qrc:/data/images/map-marker-flag-blue.png"
                        coordinate: landmark.coordinate
                        z: 2
                    }
                }
            }
        }

        MapCircle {
            id: currentPosition
            radius: 100
            color: "red"
            center: initialCoordinate
        }

        MapMouseArea {
            id: mapMouseArea

            property int lastX: -1
            property int lastY: -1

            onPressed: {
                allLandmarksModel.autoUpdate = false
                lastX = mouse.x
                lastY = mouse.y
            }
            onReleased: {
                allLandmarksModel.autoUpdate = true
                lastX = -1
                lastY = -1
            }
            onPositionChanged: {
                if (mouse.button == Qt.LeftButton) {
                    if (lastX != -1 && lastY != -1) {
                        var dx = mouse.x - lastX
                        var dy = mouse.y - lastY

                        map.pan(-dx, -dy)
                    }
                    lastX = mouse.x
                    lastY = mouse.y
                }
            }
            onDoubleClicked: {
                map.center = mouse.coordinate
                lastX = -1
                lastY = -1
                if (mouse.button == Qt.LeftButton)
                    map.zoomLevel += 1
                if (mouse.button == Qt.RightButton)
                    map.zoomLevel -= 1
            }
        }

        Behavior on zoomLevel {
            NumberAnimation { duration: 500; easing.type: Easing.OutQuad }
        }
    }
}
