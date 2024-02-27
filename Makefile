export PREFIX = $(THEOS)/toolchain/Xcode11.xctoolchain/usr/bin/

PACKAGE_VERSION=$(THEOS_PACKAGE_BASE_VERSION)

export ARCHS = arm64 arm64e
export TARGET = iphone:clang:13.0:13.0

include $(THEOS)/makefiles/common.mk
TWEAK_NAME = SugarCane
SugarCane_FILES = Tweak.xm
SugarCane_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
