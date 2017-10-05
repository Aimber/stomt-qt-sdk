#ifndef STOMT_H
#define STOMT_H

#include <QObject>
#include <QtNetwork>
#include <QUrl>
#include <QDebug>
#include <QString>
#include <QJsonObject>
#include <QJsonDocument>

class Stomt : public QObject
{
    Q_OBJECT
public:
    explicit Stomt(QObject *parent = nullptr);
    void setStomtID(QString id);

signals:
    void targetImageUrlReceived(QUrl url);

public slots:
    void getTargetImageUrl(QString targetName);
    void sendStomt(QString targetName, QString text, bool isPositive);
    void handleNetworkData(QNetworkReply* reply);

private:
    QNetworkAccessManager* m_netManager;
    QNetworkReply* m_netReply;
    QNetworkRequest m_netRequest;
    QString m_stomtID;

};

#endif // STOMT_H
