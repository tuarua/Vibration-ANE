# Vibration-ANE

Vibration Adobe Air Native Extension for iOS 9.0+ and Android 19+.    

[ASDocs Documentation](https://tuarua.github.io/asdocs/vibrationane/index.html)

-------------

## Prerequisites

You will need:

- IntelliJ IDEA
- AIR 33.1.1.217+
- Xcode 12.3
- [.Net Core Runtime](https://dotnet.microsoft.com/download/dotnet-core/3.1)
- [AIR-Tools](https://github.com/tuarua/AIR-Tools/)

### The ANE + Dependencies

Change directory into the _example_ folder eg

```bash
cd /MyMac/dev/AIR/Vibration-ANE/example
```

Run the _"air-tools"_ command (You will need [AIR-Tools](https://github.com/tuarua/AIR-Tools/) installed)

```bash
air-tools install
```


**NEW** This tool now: 

1. Downloads the ANE and dependencies.
1. Applies all required Android Manifest, InfoAdditons and Entitlements to your app.xml. See air package.json


-------------

## iOS

>N.B. You must use a Mac to build an iOS app using this ANE. Windows is **NOT** supported.

#### iOS: Packaging Frameworks Dependencies

The iOS ANEs are written in Swift. We need to package the Swift libraries (along with a couple of dynamic frameworks) with our AIR app

![https://raw.githubusercontent.com/wiki/tuarua/Firebase-ANE/images/frameworks-package.png](https://raw.githubusercontent.com/wiki/tuarua/Firebase-ANE/images/frameworks-package.png)


### References
* [https://developer.android.com/reference/android/os/Vibrator.html]
* [https://kotlinlang.org/docs/reference/android-overview.html] 
