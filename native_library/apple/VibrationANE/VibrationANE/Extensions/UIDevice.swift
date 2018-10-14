import UIKit

extension UIDevice {
    enum DevicePlatform: String {
        case other = "Other Device"
        case iPhone6S = "iPhone 6S"
        case iPhone6SPlus = "iPhone 6S Plus"
        case iPhone7 = "iPhone 7"
        case iPhone7Plus = "iPhone 7 Plus"
        case iPhone8 = "iPhone 8"
        case iPhone8Plus = "iPhone 8 Plus"
        case iPhoneSE = "iPhone SE"
        case iPhoneX = "iPhone X"
        case iPhoneXS = "iPhone XS"
        case iPhoneXSMax = "iPhone XS Max"
        case iPhoneXR = "iPhone XR"
    }
    
    var platform: DevicePlatform {
            var sysinfo = utsname()
            uname(&sysinfo)
            let platform = String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
            switch platform {
            case "iPhone11,2":
                return .iPhoneXS
            case "iPhone11,4", "iPhone11,6":
                return .iPhoneXSMax
            case "iPhone11,8":
                return .iPhoneXR
            case "iPhone10,3", "iPhone10,6":
                return .iPhoneX
            case "iPhone10,2", "iPhone10,5":
                return .iPhone8Plus
            case "iPhone10,1", "iPhone10,4":
                return .iPhone8
            case "iPhone9,2", "iPhone9,4":
                return .iPhone7Plus
            case "iPhone9,1", "iPhone9,3":
                return .iPhone7
            case "iPhone8,4":
                return .iPhoneSE
            case "iPhone8,2":
                return .iPhone6SPlus
            case "iPhone8,1":
                return .iPhone6S
            default:
                return .other
            }
    }
    
    var hasTapticEngine: Bool {
        return platform == .iPhone6S
            || platform == .iPhone6SPlus
            || platform == .iPhoneSE
            || hasHapticFeedback
    }
    
    var hasHapticFeedback: Bool {
        return platform == .iPhone7
            || platform == .iPhone7Plus
            || platform == .iPhone8
            || platform == .iPhone8Plus
            || platform == .iPhoneX
            || platform == .iPhoneXR
            || platform == .iPhoneXS
            || platform == .iPhoneXSMax
    }
}
