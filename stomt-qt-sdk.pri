QT +=  quick network
CONFIG += c++11

INCLUDEPATH += \
    $$PWD/src

HEADERS += \
    $$PWD\src\stomt.h

SOURCES += \
    $$PWD\src\stomt.cpp

RESOURCES += \
	$$PWD\qml.qrc

DISTFILES += \
    $$PWD/README.md \
    $$PWD/LICENSE
