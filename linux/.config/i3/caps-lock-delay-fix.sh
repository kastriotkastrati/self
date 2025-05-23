#!/bin/sh

caps_lock_remap='key <CAPS> \{ repeat=no, type\[group1\]=\"ALPHABETIC\", symbols\[group1\]=\[ Caps_Lock, Caps_Lock \],actions\[group1\]=\[LockMods\(modifiers=Lock\),Private\(type=3,data\[0\]=1,data\[1\]=3,data\[2\]=3\) \] \}'

xkbcomp -xkb $DISPLAY keyboardmap
sed -i "s/key <CAPS>[^;]*/$caps_lock_remap/" keyboardmap
xkbcomp keyboardmap $DISPLAY
rm keyboardmap
