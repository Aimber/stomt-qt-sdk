#pragma once

#include <QByteArray>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>
#include <QObject>
#include <QQmlEngine>
#include <QQmlExtensionPlugin>
#include <QQuickItem>
#include <QScopedPointer>
#include <QString>
#include <QUrl>
#include <QtConcurrent/QtConcurrent>
#include <QtNetwork>
#include <QtQml>

class Stomt : public QQuickItem {
    Q_OBJECT
    Q_DISABLE_COPY(Stomt)

public:
    Stomt(QQuickItem* parent = nullptr);
    ~Stomt();

    Q_PROPERTY(QUrl profileImageUrl READ profileImageUrl WRITE setProfileImageUrl NOTIFY profileImageUrlChanged)
    Q_PROPERTY(QString appID READ appID WRITE setAppID NOTIFY appIDChanged)
    Q_PROPERTY(QString targetID READ targetID WRITE setTargetID NOTIFY targetIDChanged)
    Q_PROPERTY(bool useTestServer READ useTestServer WRITE setUseTestServer NOTIFY useTestServerChanged)

    QUrl profileImageUrl() const
    {
        return m_profileImageUrl;
    }

    QString targetID() const
    {
        return m_targetID;
    }

    QString appID() const
    {
        return m_appID;
    }

    bool useTestServer() const
    {
        return m_useTestServer;
    }


signals:
    void profileImageUrlChanged(QUrl profileImageUrl);
    void stomtSuccessfulSend();
    void targetIDChanged(QString targetID);
    void appIDChanged(QString appID);
    void useTestServerChanged(bool useTestServer);


public slots:
    void init();
    void getTargetInfo();
    void sendStomt(QString text, bool isPositive);
    void handleNetworkData(QNetworkReply* reply);
    void targetInfoReceived(QNetworkReply* reply);
    QString getTargetID();
    void setProfileImageUrl(QUrl profileImageUrl);

    void setTargetID(QString targetID)
    {
        if (m_targetID == targetID)
            return;

        m_targetID = targetID;
        m_targetIDSet = true;
        setup();
        emit targetIDChanged(m_targetID);
    }

    void setAppID(QString appID)
    {
        if (m_appID == appID)
            return;

        m_appID = appID;
        m_appIDSet = true;
        setup();
        emit appIDChanged(m_appID);
    }
    inline void setup()
    {
        if (m_appIDSet && m_targetIDSet)
            init();
    }

    void setUseTestServer(bool useTestServer)
    {
        if (m_useTestServer == useTestServer)
            return;

        m_useTestServer = useTestServer;

        m_baseUrlStomt = "https://test.rest.stomt.com";
        emit useTestServerChanged(m_useTestServer);
    }

private:
    QNetworkAccessManager* m_netManager;
    QNetworkRequest m_netRequest;

    QString m_baseUrlStomt = "https://rest.stomt.com";
    QUrl m_profileImageUrl;
    QString m_appID, m_targetID, m_accessToken;
    bool m_appIDSet = false;
    bool m_targetIDSet = false;
    bool m_useTestServer = false;
};
