#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

#/usr/bin/xmodmap $HOME/.Xmodmap

export BROWSER=chromium

#exec xscreensaver -no-splash &
#exec wicd-client &
#exec padevchooser &
#exec orage &

#if test x"$DBUS_SESSION_BUS_ADDRESS" = x""; then
#    dbuslaunch=`which dbus-launch`
#    if test x"$dbuslaunch" != x"" -a x"$dbuslaunch" != x"no"; then
#        eval `$dbuslaunch --sh-syntax --exit-with-session`
#    fi
#fi

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRES"; then
	eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

#grim's buildbot
#exec buildbot start /home/salinasv/src/guifications/gplate/.

#exec wmaker
# exec startkde
# exec icewm
# exec blackbox
#exec fluxbox
#exec startfluxbox
# exec gnome-session

#case "$1" in
#	fluxbox)
#	exec startfluxbox
	
#	;;
#	awesome)
	exec awesome
#	;;
#esac
