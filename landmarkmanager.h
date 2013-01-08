#ifndef LANDMARKMANAGER_H
#define LANDMARKMANAGER_H

#include <QObject>
#include <qlandmark.h>
#include <qlandmarkmanager.h>
#include <qlandmarkid.h>
#include <qlandmarkcategoryid.h>

QTM_USE_NAMESPACE

class LandmarkManager : public QObject
{
    Q_OBJECT
public:
    LandmarkManager(QObject *parent = 0);
    ~LandmarkManager();

public slots:
    void init();
    void saveLandmark(double latitude, double longitude, QString name);
    void landmarks();
    bool cleanLandmarks();
    void onLandmarksAdded(const QList<QLandmarkId> &landmarkIds);

private:
    QLandmarkManager *m_manager;
    QLandmarkCategoryId m_categoryId;
};

#endif
