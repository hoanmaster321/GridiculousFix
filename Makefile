THEOS_DEVICE_IP = 192.168.1.245

ARCHS = arm64 arm64e

FINALPACKAGE = 1

TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = StatusBar
StatusBar_FILES = Tweak.x
StatusBar_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
