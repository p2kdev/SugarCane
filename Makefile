#export THEOS_PACKAGE_SCHEME=rootless
export TARGET = iphone:clang:12.4:12.0

THEOS_DEVICE_IP = 192.168.1.145

PACKAGE_VERSION=$(THEOS_PACKAGE_BASE_VERSION)

export ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk
TWEAK_NAME = SugarCane
SugarCane_FILES = Tweak.xm
SugarCane_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
