obj-m += soft_uart.o

soft_uart-objs := module.o raspberry_soft_uart.o queue.o

RELEASE = $(shell uname -r)
# RELEASE = 4.19.66+
LINUX = /usr/src/linux-headers-$(RELEASE)

.PHONY: all clean install uninstall load unload reload

all:
	$(MAKE) -C $(LINUX) M=$(PWD) modules

clean:
	$(MAKE) -C $(LINUX) M=$(PWD) clean

install: all
	sudo install -m 644 -c soft_uart.ko /lib/modules/$(RELEASE)
	sudo depmod

uninstall:
	sudo rm /lib/modules/$(RELEASE)/soft_uart.ko
	sudo depmod

load:
	sudo insmod soft_uart.ko

unload:
	sudo rmmod soft_uart

reload: unload load
