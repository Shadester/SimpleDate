include theos/makefiles/common.mk

ARCHS = armv7
BUNDLE_NAME = SimpleDate
SimpleDate_FILES = SimpleDateController.m
SimpleDate_INSTALL_PATH = /System/Library/WeeAppPlugins/
SimpleDate_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
