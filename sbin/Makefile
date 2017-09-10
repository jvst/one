#
#内测版本,使用模拟加密机
export CLOSED_BETA = 1
export DEBUG = 1
PROJECT_NAME = ahnx_bts
NOW_DATE =  $(shell date +%m%d)
#TAR_POJ_NAME = $(PROJECT_NAME)_$(NOW_DATE)
TAR_POJ_NAME = $(PROJECT_NAME)

ifdef CLOSED_BETA
DIRS = ../logmgr ../baseapi \
	   ../package/xml ../package/json ../package/iso8583 ../package/mpos \
	   ../component/sys/bus ../component/sys/netmgr ../component/sys/pluginmgr \
	   ../component/sys/hsmutils \
	   ../component/sys/svrpubfunc ../component/sys/evprocess \
	   ../platform  ../plugins/src 
else
# 行里测试的版本HSM等模块不需要编译
DIRS = ../logmgr ../baseapi \
	   ../package/xml ../package/json ../package/iso8583 \
	   ../component/sys/bus ../component/sys/netmgr ../component/sys/pluginmgr \
	   ../component/sys/svrpubfunc ../component/sys/evprocess \
	   ../platform  ../plugins/src 
endif

BUILDDIRS = $(DIRS:%=build-%)
CLEANDIRS = $(DIRS:%=clean-%)
DISTCLEANDIRS = $(DIRS:%=distclean-%)



.PHONY: all clean distclean ts tb tsnl tbnl
all: info $(BUILDDIRS)

info:
	@printf  "system:"
	@uname -a
	@printf  "user:"
	@whoami
	@printf "time:"
	@date
	@gcc --version
	
$(BUILDDIRS):
	$(MAKE) -C $(@:build-%=%)

clean:$(CLEANDIRS)
$(CLEANDIRS):
	$(MAKE) -C $(@:clean-%=%) clean

distclean:$(DISTCLEANDIRS)
$(DISTCLEANDIRS):
	@rm -rf  ../lib/sys/.ftok
	@rm -rf  ../lib/sys/cfg  
	@rm -rf  ../lib/sys/cfgcache  
	@rm -rf  ../lib/sys/db2dump
	$(MAKE) -C $(@:distclean-%=%) distclean

#tar-src 打包源码(包括依赖的第三方库), 打包前请先执行make distclean
ts:
	@echo "tar a package of source code with libs"
	@(cd ../../; tar czvf  $(TAR_POJ_NAME).tar.gz $(PROJECT_NAME)/ \
		--exclude $(PROJECT_NAME)/log \
		--exclude $(PROJECT_NAME)/.git \
		--exclude $(PROJECT_NAME)/tags)

#tar-bin 打包可执行程序(包括依赖的第三方库), 打包前请先执行make
tb:		
	@echo "tar a package of executable program with libs"
	@(cd ../../; tar czvf  $(TAR_POJ_NAME).tar.gz $(PROJECT_NAME)/ \
		--exclude $(PROJECT_NAME)/platform \
		--exclude $(PROJECT_NAME)/log \
		--exclude $(PROJECT_NAME)/plugins/src \
		--exclude $(PROJECT_NAME)/logmgr \
		--exclude $(PROJECT_NAME)/package \
		--exclude $(PROJECT_NAME)/baseapi \
		--exclude $(PROJECT_NAME)/component \
		--exclude $(PROJECT_NAME)/.git \
		--exclude $(PROJECT_NAME)/tags)

#tar-src-without-libs 打包源码(不包括依赖的第三方库), 打包前请先执行make distclean
tsnl:
	@echo "tar a package of source code without libs"
	@(cd ../../; tar czvf  $(TAR_POJ_NAME).tar.gz $(PROJECT_NAME)/ \
		--exclude $(PROJECT_NAME)/lib \
		--exclude $(PROJECT_NAME)/log \
		--exclude $(PROJECT_NAME)/.git \
		--exclude $(PROJECT_NAME)/tags)

#tar-bin-without-libs 打包可执行程序(不包括依赖的第三方库), 打包前请先执行make
tbnl:
	@echo "tar a package of executable program without libs"
	@(cd ../../; tar czvf  $(TAR_POJ_NAME).tar.gz $(PROJECT_NAME)/ \
		--exclude $(PROJECT_NAME)/lib/sys \
		--exclude $(PROJECT_NAME)/platform \
		--exclude $(PROJECT_NAME)/log \
		--exclude $(PROJECT_NAME)/plugins/src \
		--exclude $(PROJECT_NAME)/logmgr \
		--exclude $(PROJECT_NAME)/package \
		--exclude $(PROJECT_NAME)/baseapi \
		--exclude $(PROJECT_NAME)/component \
		--exclude $(PROJECT_NAME)/.git \
		--exclude $(PROJECT_NAME)/tags)
