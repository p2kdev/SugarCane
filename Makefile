include $(THEOS)/makefiles/common.mk
ARCHS = arm64 arm64e
FINALPACKAGE = 1
TWEAK_NAME = SugarCane 13/14
SugarCane_FILES = Tweak.xm
SugarCane_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
