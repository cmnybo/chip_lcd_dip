# Software

## Files
* lcd_panel.dts The device tree overlay source for this DIP
* dip-d653-1.dtbo The compiled device tree overlay for this dip
* er-tft050-3.patch The patch for the kernel driver to support the 5" & 7" LCDs
* lcd.img The EEPROM image for the DIP
* Linux_Kernel_4.4.11_Patched.tar.gz My custom kernel with the LCD patch already installed
* bl.sh A bash script to control the LCD backlight

## Installation
1. Install the patched kernel. 
2. Install the DTBO file. Run "`cp dip-d653-1.dtbo /lib/firmware/nextthingco/chip/early/`"
3. Flash lcd.img to the EEPROM. Run "`cat lcd.img > /sys/bus/w1/devices/2d-*/eeprom`"
4. Reboot C.H.I.P. It takes several seconds for the LCD to come on.
5. Calibrate the touch screen. 

## Touch Screen Calibration
You will probably need to connect a mouse until the tough screen is calibrated.<br/>
Install xinput_calibrator.<br/>
Run "`mkdir -p /etc/X11/xorg.conf.d/`" to create the directory for the calibration data.<br/>
Select "System > Calibrate Touchscreen" from the applications menu. <br/>
Follow the instructions, then paste its output in `/etc/X11/xorg.conf.d/99-calibration.conf`<br/>
Reboot or run "`systemctl restart lightdm`" to restart the X server.

You can add the following lines to the calibration file to enable right click emulation.<br/>
>
`Option	"EmulateThirdButton" "1"`<br/>
`Option	"EmulateThirdButtonTimeout" "750"`<br/>
`Option	"EmulateThirdButtonMoveThreshold" "30"`<br/>


## Controlling the backlight
Put the bl.sh script in a directory that's included in your $PATH variable.<br/>
Run `bl.sh` with the `--up` or `--dn` options to adjust the brightness.<br/>
Run `bl.sh` with the `--toggle` option to toggle the display on and off.<br/>
For easier control, you can add these to some shortcuts in the 
"Application Shortcuts" tab of the Keyboard settings window.

The system power management can automatically turn off the display when idle, 
but I have noticed some problems when turning the screen back on. If you have 
trouble with this, you can disable power management for the LCD in the 
"Power Manager" window.
