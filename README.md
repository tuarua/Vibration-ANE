# Vibration-ANE

Vibration Adobe Air Native Extension for iOS 9.0+ and Android 19+.    

[ASDocs Documentation](https://tuarua.github.io/asdocs/vibrationane/index.html)

-------------

## Android

#### The ANE + Dependencies

cd into /example and run:
- macOS (Terminal)
```shell
bash get_android_dependencies.sh
```
- Windows Powershell
```shell
PS get_android_dependencies.ps1
```

```xml
<extensions>
<extensionID>com.tuarua.frekotlin</extensionID>
<extensionID>com.tuarua.VibrationANE</extensionID>
...
</extensions>
```

You will also need to include the following in your app manifest. Update accordingly.

```xml
<manifest>
<uses-permission android:name="android.permission.VIBRATE"/>
</manifest>
```

-------------

## iOS

#### The ANE + Dependencies

N.B. You must use a Mac to build an iOS app using this ANE. Windows is NOT supported.

From the command line cd into /example and run:

```shell
bash get_ios_dependencies.sh
```

This folder, ios_dependencies/device/Frameworks, must be packaged as part of your app when creating the ipa. How this is done will depend on the IDE you are using.
After the ipa is created unzip it and confirm there is a "Frameworks" folder in the root of the .app package.

### Prerequisites

You will need:

- IntelliJ IDEA
- AIR 33.0.2.338+
- Xcode 11.3
- wget on macOS via `brew install wget`
- Android Studio 3 if you wish to edit the Android source
- Powershell on Windows

### References
* [https://developer.android.com/reference/android/os/Vibrator.html]
* [https://kotlinlang.org/docs/reference/android-overview.html] 
