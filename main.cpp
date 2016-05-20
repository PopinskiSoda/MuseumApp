#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QDir>
#include <QStringList>
#include <QQmlContext>

#include <hall.h>
#include <exhibit.h>

int main(int argc, char *argv[])
{
    QString assetsPath = "assets/";

    QDir assetsDir(assetsPath);
    QStringList hallDirs = assetsDir.entryList(QDir::Dirs|QDir::NoDotAndDotDot);
    QStringList hallImages = assetsDir.entryList(QStringList("*.jpg"));
    QList< QList<QObject *> > exhibitLists;// = new QList< QList<QObject *>* >();

    QList<QString>::iterator it = hallDirs.begin();
    while (it != hallDirs.end()) {
        QDir hallDir(assetsPath + *it);
        QStringList exhibitHtmls = hallDir.entryList(QStringList("*.html"));
        QStringList exhibitDirs = hallDir.entryList(QDir::Dirs|QDir::NoDotAndDotDot);
        QList<QString>::iterator it2 = exhibitDirs.begin();
        QList<QObject *>* exhibitList = new QList<QObject*>();

        while (it2 != exhibitDirs.end())
        {
            QString exhibitDirPath = assetsPath + *it + '/' + *it2;
            QDir exhibitDir(exhibitDirPath);
            QStringList exhibitImages = exhibitDir.entryList(QStringList("*.jpg"));

            Exhibit* exhibit = new Exhibit();
            exhibit->setName(exhibitDirPath + '/' + exhibitImages.at(0));
            exhibit->setImage(exhibitDirPath + '/' + exhibitImages.at(0));
            exhibitList->append(exhibit);

            ++it2;
        }
//        exhibitLists->append(exhibitList);
        ++it;
    }

    QStringList* hallImageUrls = new QStringList();
    it = hallImages.begin();
    while (it != hallImages.end()) {
        hallImageUrls->append(assetsPath + *it);
        ++it;
    }

//  ---------------------------------

    QGuiApplication app(argc, argv);

    QList<QObject*> hallList;
    it = hallImageUrls->begin();
    while (it != hallImageUrls->end()) {
        Hall* hall = new Hall();
        hall->setName(*it);
        hall->setImage(*it);
        hallList.append(hall);
        ++it;
    }

    QQmlApplicationEngine engine;

    QQmlContext* context = engine.rootContext();
    context->setContextProperty("MenuModel", QVariant::fromValue(hallList));
    context->setContextProperty("HallModels", QVariant::fromValue(exhibitLists));
    context->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
