include $(THEOS)/makefiles/common.mk
TARGET = iphone:clang:13.0
ARCHS = arm64 arm64e
FINALPACKAGE = 1
TWEAK_NAME = SugarCane
SugarCane_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
