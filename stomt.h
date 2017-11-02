#pragma once

#include <QQuickItem>
#include <QByteArray>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>
#include <QObject>
#include <QQmlExtensionPlugin>
#include <QScopedPointer>
#include <QString>
#include <QUrl>
#include <QtNetwork>
#include <QtQml>
#include <QQmlEngine>

class Stomt : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(Stomt)

public:
    Stomt(QQuickItem *parent = nullptr);
    ~Stomt();

    Q_PROPERTY(QUrl profileImageUrl READ profileImageUrl WRITE setProfileImageUrl NOTIFY profileImageUrlChanged)
    Q_PROPERTY(QString appID READ appID WRITE setAppID NOTIFY appIDChanged)
    Q_PROPERTY(QString targetID READ targetID WRITE setTargetID NOTIFY targetIDChanged)

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

signals:
    void profileImageUrlChanged(QUrl profileImageUrl);
    void stomtSuccessfulSend();
    void targetIDChanged(QString targetID);
    void appIDChanged(QString appID);

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
        emit targetIDChanged(m_targetID);
        setup();
    }

    void setAppID(QString appID)
    {
        if (m_appID == appID)
            return;

        m_appID = appID;
        m_appIDSet = true;
        emit appIDChanged(m_appID);
        setup();
    }
    void setup(){
        if(m_appIDSet && m_targetIDSet)
            init();
    }

private:
    QNetworkAccessManager* m_netManager;
    QNetworkReply* m_netReply;
    QNetworkRequest m_netRequest;

    QUrl m_profileImageUrl;
    QString m_appID, m_targetID;
    bool m_appIDSet = false;
    bool m_targetIDSet = false;
};


