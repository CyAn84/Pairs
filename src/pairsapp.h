#ifndef PAIRSAPP_H
#define PAIRSAPP_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>


class PairsApp : public QGuiApplication
{
public:
    PairsApp(int &argc, char **argv);
    ~PairsApp();

private:
    QQmlApplicationEngine engine_;
    const QUrl startScreen_ = QStringLiteral("qrc:/qml/main.qml");

};

#endif // PAIRSAPP_H
