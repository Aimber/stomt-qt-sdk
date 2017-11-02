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

pluginfiles.files +=  qmldir \
    qml/StomtWidget.qml \
    qml/SubmitBtn.qml \
    qml/Target.qml \
    qml/WishLikeSwitcher.qml \

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir

installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
qmldir.path = $$installPath
target.path = $$installPath
pluginfiles.path = $$installPath
INSTALLS += target qmldir pluginfiles

