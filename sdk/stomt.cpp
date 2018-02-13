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

void Stomt::getTargetInfo()
{
    connect(m_netManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(targetInfoReceived(QNetworkReply*)));
    m_netRequest.setUrl(QUrl(QString(m_baseUrlStomt + "/targets" + m_targetID)));
    m_netManager->get(m_netRequest);
}

void Stomt::sendStomt(QString text, bool isPositive)
{
    connect(m_netManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(handleNetworkData(QNetworkReply*)));
    QJsonObject tmpObj;
    tmpObj.insert("target_id", QString(m_targetID));
    tmpObj.insert("positive", isPositive);
    tmpObj.insert("text", text);
    tmpObj.insert("anonym", true);
    m_netRequest.setUrl(QUrl(QString( m_baseUrlStomt +"/stomts")));
    m_netManager->post(m_netRequest, QJsonDocument(tmpObj).toJson());
}

void Stomt::handleNetworkData(QNetworkReply* reply)
{
        emit stomtSuccessfulSend();
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

void Stomt::setProfileImageUrl(QUrl profileImageUrl)
{
    if (m_profileImageUrl == profileImageUrl)
        return;

    m_profileImageUrl = profileImageUrl;
    emit profileImageUrlChanged(m_profileImageUrl);
}
