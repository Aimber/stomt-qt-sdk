TEMPLATE = subdirs
SUBDIRS =   \
            sdk/stomt-qt-sdk.pro \
            example/StomtExample.pro

StomtExample.depends = stomt-qt-sdk
