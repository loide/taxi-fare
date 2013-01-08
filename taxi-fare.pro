TEMPLATE = app
TARGET = taxi-fare
INCLUDEPATH += .

QT += declarative
CONFIG += mobility
MOBILITY += location


HEADERS += landmarkmanager.h
SOURCES += landmarkmanager.cpp \
           main.cpp

RESOURCES += qml.qrc

contains(MEEGO_EDITION, harmattan) {
    DEFINES += MEEGO_EDITION_HARMATTAN

    target.path = /opt/taxi-fare/bin

    landmarks.path = /opt/taxi-fare
    landmarks.files = mylandmarks.lmx

    INSTALLS += target landmarks
}

OTHER_FILES += \
    qml/*
