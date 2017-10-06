#include "stomt.h"

Stomt::Stomt(QByteArray stomtID, QByteArray targetID, QObject* parent)
    : QObject(parent)
{
    m_stomtID = stomtID;
    m_targetID = targetID;
    m_netManager = new QNetworkAccessManager(this);
    m_netRequest.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    m_netRequest.setRawHeader(QByteArray("appid"), m_stomtID);
    getTargetInfo();
}

void Stomt::getTargetInfo()
{
    connect(m_netManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(targetInfoReceived(QNetworkReply*)));
    m_netRequest.setUrl(QUrl(QString("https://rest.stomt.com/targets/" + m_targetID)));
    m_netManager->get(m_netRequest);
}

void Stomt::targetInfoReceived(QNetworkReply* reply)
{
    QScopedPointer<QJsonParseError> err(new QJsonParseError());
    QByteArray tmpBA = reply->readAll();
    QJsonDocument tmp = QJsonDocument::fromJson(tmpBA, err.data());
    if (!(err.data()->error == QJsonParseError::NoError)) {
        return;
    }

    auto ob = QJsonObject(tmp.object());
    QString imgUrl = ob.value("data").toObject().value("images").toObject().value("avatar").toObject().value("url").toString();

    if (imgUrl.isEmpty())
        return;

    setProfileImageUrl(QUrl(imgUrl));
}

QString Stomt::getTargetID()
{
    return m_targetID;
}

void Stomt::sendStomt(QString text, bool isPositive)
{
    connect(m_netManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(handleNetworkData(QNetworkReply*)));
    QJsonObject tmpObj;
    tmpObj.insert("target_id", QString(m_targetID));
    tmpObj.insert("positive", isPositive);
    tmpObj.insert("text", text);
    tmpObj.insert("anonym", true);
    m_netRequest.setUrl(QUrl(QString("https://rest.stomt.com/stomts")));
    m_netReply = m_netManager->post(m_netRequest, QJsonDocument(tmpObj).toJson());
}

void Stomt::handleNetworkData(QNetworkReply* reply)
{
    if(reply->readAll() == "")
        emit stomtSuccessfulSend();
}
