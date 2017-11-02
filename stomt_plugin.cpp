#include "stomt_plugin.h"
#include "stomt.h"
#include <QtQml>



QObject *StomtSingleton(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    return new Stomt();
}


void StomtPlugin::registerTypes(const char *uri)
{
    // @uri com.stomt.qmlSDK
    qmlRegisterSingletonType<Stomt>(uri, 1, 0, "Stomt", StomtSingleton);
}

