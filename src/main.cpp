#include "pairsapp.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    PairsApp app(argc, argv);

    return app.exec();
}
