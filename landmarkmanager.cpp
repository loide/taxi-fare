#include "landmarkmanager.h"

#include <qlandmarkmanager.h>
#include <qlandmark.h>
#include <qlandmarkid.h>
#include <qgeocoordinate.h>
#include <qlandmarkcategory.h>
#include <QObject>
#include <QString>
#include <QStringList>
#include <QDebug>
#include <QList>

QTM_USE_NAMESPACE

LandmarkManager::LandmarkManager (QObject *parent)
    : QObject(parent)
    , m_manager(0)
{
}

LandmarkManager::~LandmarkManager()
{
}

void LandmarkManager::init()
{
    m_manager = new QLandmarkManager;
    connect(m_manager, SIGNAL(landmarksAdded(const QList<QLandmarkId> &)), this,
            SLOT(onLandmarksAdded(const QList<QLandmarkId> &)));

    QList<QLandmarkCategory> categories = m_manager->categories();
    foreach(QLandmarkCategory category, categories) {
        if (category.name() == "Geographical area")
            m_categoryId = category.categoryId();
    }

}

void LandmarkManager::saveLandmark(double latitude, double longitude, QString name)
{
    if (!m_manager)
        return;

    QGeoCoordinate coordinate;
    coordinate.setLatitude(latitude);
    coordinate.setLongitude(longitude);
    QLandmark *landmark = new QLandmark;
    landmark->addCategoryId(m_categoryId);
    landmark->setName(name);
    landmark->setCoordinate(coordinate);
    landmark->setRadius(100);

    bool result = m_manager->saveLandmark(landmark);
}

void LandmarkManager::landmarks()
{
    if (!m_manager)
        return;
    QList<QLandmarkId> landmarkIds = m_manager->landmarkIds();
    QList<QLandmark> landmarks = m_manager->landmarks(landmarkIds);
}

bool LandmarkManager::cleanLandmarks()
{
    bool result = false;

    if (!m_manager)
        return result;

    QList<QLandmark> lms = m_manager->landmarks();
    if (lms.count() > 0)
        result = m_manager->removeLandmarks(lms);

    return result;
}

void LandmarkManager::onLandmarksAdded(const QList<QLandmarkId> &landmarkIds)
{
    foreach(QLandmarkId id, landmarkIds)
        qDebug() << " ID: " << id.localId();

    landmarks();
}
