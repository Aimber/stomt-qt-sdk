#include "stomt.h"

Stomt::Stomt(QQuickItem* parent)
    : QQuickItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    setFlag(ItemHasContents, true);
}

Stomt::~Stomt()
{
}

void Stomt::init()
{
    m_netManager = new QNetworkAccessManager(this);
    m_netRequest.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    m_netRequest.setRawHeader(QByteArray("appid"), QByteArray(QByteArray::fromStdString(m_appID.toStdString())));
}

void Stomt::sendStomt(QString text, bool isPositive)
{
    connect(m_netManager, &QNetworkAccessManager::finished, this, &Stomt::sendStomtResponse);
    QJsonObject tmpObj;
    tmpObj.insert("target_id", QString(m_targetID));
    tmpObj.insert("positive", isPositive);
    tmpObj.insert("text", text);
    tmpObj.insert("anonym", true);
    m_netRequest.setUrl(QUrl(QString(m_baseUrlStomt + "/stomts")));
    m_netManager->post(m_netRequest, QJsonDocument(tmpObj).toJson());
}

void Stomt::sendStomtResponse(QNetworkReply* reply)
{
    QJsonParseError err;
    QByteArray tmpBA = reply->readAll();
    QJsonDocument tmp = QJsonDocument::fromJson(tmpBA, &err);
    if (!(err.error == QJsonParseError::NoError)) {
        return;
    }
    auto ob = QJsonObject(tmp.object());
    if(!ob.contains("data")){
        return;
    }
    QString shortlink = ob.value("data").toObject().value("shortlink").toString();

    emit stomtSuccessfulSend(shortlink);
}

QString Stomt::getTargetID()
{
    return m_targetID;
}
