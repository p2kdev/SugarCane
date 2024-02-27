export PREFIX = $(THEOS)/toolchain/Xcode11.xctoolchain/usr/bin/

PACKAGE_VERSION=$(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS)/makefiles/common.mk
ARCHS = arm64 arm64e
TWEAK_NAME = SugarCane
SugarCane_FILES = Tweak.xm
SugarCane_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
