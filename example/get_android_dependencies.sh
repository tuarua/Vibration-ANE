#!/bin/sh

AneVersion="1.3.0"
FreKotlinVersion="1.9.5"

wget -O android_dependencies/com.tuarua.frekotlin-$FreKotlinVersion.ane https://github.com/tuarua/Android-ANE-Dependencies/blob/master/anes/kotlin/com.tuarua.frekotlin-$FreKotlinVersion.ane?raw=true
wget -O ../native_extension/ane/VibrationANE.ane https://github.com/tuarua/Vibration-ANE/releases/download/$AneVersion/VibrationANE.ane?raw=true
