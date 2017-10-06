#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "src/stomt.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Stomt stomt("");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("stomtPlugin", &stomt);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
