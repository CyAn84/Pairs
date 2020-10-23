#include "pairsapp.h"


PairsApp::PairsApp(int &argc, char **argv)
    : QGuiApplication(argc, argv)
{
    QObject::connect(&engine_, &QQmlApplicationEngine::objectCreated,
                     this, [this](QObject *obj, const QUrl &objUrl) {
        if (!obj && startScreen_ == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine_.load(startScreen_);
}

PairsApp::~PairsApp()
{

}
