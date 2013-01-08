#include <QApplication>
#include <QDeclarativeView>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QUrl>

#include "landmarkmanager.h"

int main (int argc, char *argv[])
{
    QApplication app(argc, argv);
    LandmarkManager *manager = new LandmarkManager;;

    QDeclarativeView view;

    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    view.rootContext()->setContextProperty("controller", manager);
    view.setSource(QUrl("qrc:/qml/main.qml"));
    view.resize(480, 854);

#if defined(MEEGO_EDITION_HARMATTAN)
    view.showFullScreen();
#else
    view.show();
#endif

    return app.exec();
}
