#ifndef STOMT_H
#define STOMT_H

#include <QObject>
#include <QtNetwork>
#include <QUrl>
#include <QDebug>
#include <QString>
#include <QJsonObject>
#include <QJsonDocument>
#include <QByteArray>
#include <QJsonParseError>
#include <QScopedPointer>

class Stomt : public QObject
{
    Q_OBJECT
public:
    explicit Stomt(QByteArray stomtID, QObject *parent = nullptr);
    Q_PROPERTY(QUrl profileImageUrl READ profileImageUrl WRITE setProfileImageUrl NOTIFY profileImageUrlChanged)

    QUrl profileImageUrl() const
    {
        return m_profileImageUrl;
    }

signals:
    void targetImageUrlReceived(QUrl url);

    void profileImageUrlChanged(QUrl profileImageUrl);

public slots:
    void getTargetInfo(QString targetName);
    void sendStomt(QString targetName, QString text, bool isPositive);
    void handleNetworkData(QNetworkReply* reply);
    void targetInfoReceived(QNetworkReply* reply);

    void setProfileImageUrl(QUrl profileImageUrl)
    {
        if (m_profileImageUrl == profileImageUrl)
            return;

        m_profileImageUrl = profileImageUrl;
        emit profileImageUrlChanged(m_profileImageUrl);
    }

private:
    QNetworkAccessManager* m_netManager;
    QNetworkReply* m_netReply;
    QNetworkRequest m_netRequest;
    QByteArray m_stomtID;

    QUrl m_profileImageUrl;
};

#endif // STOMT_H
