ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
	ARCHS = arm64 arm64e
	TARGET = iphone:clang:15.5:15.0
else
	ARCHS = armv7 armv7s arm64 arm64e
	TARGET = iphone:clang:14.2:7.0
endif

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = statusbar

statusbar_FILES = Tweak.x
statusbar_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
