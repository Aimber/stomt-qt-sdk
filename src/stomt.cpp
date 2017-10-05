#include "stomt.h"

Stomt::Stomt(QObject *parent) : QObject(parent)
{
    m_netManager = new QNetworkAccessManager(this);
    m_netRequest.setUrl(QUrl(QString("https://rest.stomt.com/stomts")));
    m_netRequest.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    m_netRequest.setRawHeader(QByteArray("appid"),QByteArray("C1IfJAruqWFdkM8e7BMPK3dx1"));
}

void Stomt::setStomtID(QString id)
{
    m_stomtID = id;
}

void Stomt::getTargetImageUrl(QString targetName)
{
    QString url = "https://rest.stomt.com/targets/";
    //QNetworkRequest request = QNetworkRequest(QUrl(url));
}

void Stomt::sendStomt(QString targetName, QString text, bool isPositive)
{
    connect(m_netManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(handleNetworkData(QNetworkReply*)));
    QJsonObject tmpObj;
    tmpObj.insert("target_id",targetName);
    tmpObj.insert("positive", isPositive);
    tmpObj.insert("text",text);
    tmpObj.insert("anonym", true);

    m_netReply = m_netManager->post(m_netRequest,QJsonDocument(tmpObj).toJson());
}

void Stomt::handleNetworkData(QNetworkReply *reply)
{
    qDebug()<< reply->readAll();
}
