TEMPLATE = lib
TARGET = stomt
QT += qml quick
CONFIG += plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = com.stomt.qmlSDK

# Input
SOURCES += \
    stomt_plugin.cpp \
    stomt.cpp

RESOURCES += \
    qml.qrc \

HEADERS += \
    stomt_plugin.h \
    stomt.h

pluginfiles.files +=  \
    qmldir \
    qml/SendSuccessful.qml \
    qml/StomtWidget.qml \
    qml/SubmitBtn.qml \
    qml/Target.qml \
    qml/WishLikeSwitcher.qml \

installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
pluginfiles.path = $$installPath
INSTALLS +=   pluginfiles
