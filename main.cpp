#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "src/stomt.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Stomt stomt;
    stomt.setStomtID("C1IfJAruqWFdkM8e7BMPK3dx1");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("stomtPlugin", &stomt);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
