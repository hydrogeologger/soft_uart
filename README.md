# soft_uart

Software-based serial port module for Raspberry Pi.

This module creates a software-based serial port using a configurable pair of GPIO pins. The serial port will appear as `/dev/ttySOFT0`.


## Features

* Works exactly as a hardware-based serial port.
* Works with any application, e.g. cat, echo, minicom.
* Configurable baud rate.
* TX buffer of 256 bytes.
* RX buffer managed by the kernel.


## Compiling

Fetch the source:
```
git clone --depth 1 https://github.com/hydrogeologger/soft_uart
```

Install the package `raspberrypi-kernel-headers`:
```
sudo apt install raspberrypi-kernel-headers
```
If compilation error of kernel version not found, may need to install 'raspberrypi-kernel'
```
sudo apt install raspberrypi-kernel raspberrypi-kernel-headers
```

Run `make install`, as usual.
```
cd soft_uart
make
sudo make install
```

I haven't tried cross-compiling this module, but it should work as well.


## Loading

Module parameters:

* gpio_tx: int [default = 16]
* gpio_rx: int [default = 13]

Loading the module with default parameters:
```
sudo insmod soft_uart.ko
```
or
```
make load
```

Loading module with custom parameters:
```
sudo insmod soft_uart.ko gpio_tx=10 gpio_rx=11
```

## Unloading
To unload:
`sudo rmmod soft_uart` or `make unload`

## Reload module
`make reload`


## Usage

The device will appear as `/dev/ttySOFT0`. Use it as any usual TTY device.

You must be included in the group `dialout`. You can verify in what groups you are included by typing `groups`. To add an user to the group `dialout`, type:
```
sudo usermod -aG dialout <username>
```

Usage examples:
```
minicom -b 4800 -D /dev/ttySOFT0
cat /dev/ttySOFT0
echo "hello" > /dev/ttySOFT0
```

## Baud rate

When choosing the baud rate, take into account that:
* The Raspberry Pi is not very fast.
* You will probably not be running a real-time operating system.
* There will be other processes competing for CPU time.

As a result, you can expect communication errors when using fast baud rates. So I would not try to go any faster than 4800 bps.
