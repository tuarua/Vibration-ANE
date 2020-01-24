/* Copyright 2018 Tua Rua Ltd.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import FreSwift
import AudioToolbox

public class SwiftController: NSObject {
    public static var TAG = "SwiftController"
    public var context: FreContextSwift!
    public var functionsToSet: FREFunctionMap = [:]
    
    @available(iOS 10.0, *)
    lazy var tapticController: TapticController = TapticController()
    
    private var isPhone: Bool {
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        switch deviceIdiom {
        case .phone:
            return true
        default:
            return false
        }
    }
    
    func initController(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        return true.toFREObject()
    }
    
    func vibrate(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let systemSound = Int(argv[0])
            else {
                return FreArgError().getError()
        }
        
        var systemSoundID = SystemSoundID(kSystemSoundID_Vibrate)
        if UIDevice.current.hasTapticEngine {
            systemSoundID = SystemSoundID(systemSound)
        }
        AudioServicesPlayAlertSound(systemSoundID)
        return nil
    }
    
    func cancel(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        return nil
    }
    
    func hasVibrator(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        return isPhone.toFREObject()
    }
    
    func prepareNotification(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard #available(iOS 10.0, *), isPhone, UIDevice.current.hasHapticFeedback else { return nil }
        tapticController.prepareNotification()
        return nil
    }
    
    func releaseNotification(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard #available(iOS 10.0, *), isPhone, UIDevice.current.hasHapticFeedback else { return nil }
        tapticController.releaseNotification()
        return nil
    }
    
    func notificationOccurred(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let type = Int(argv[0])
            else {
                return FreArgError().getError()
        }
        guard #available(iOS 10.0, *), isPhone, UIDevice.current.hasHapticFeedback else { return nil }
        tapticController.notificationOccurred(type: type)
        return nil
    }
    
    func initImpact(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard #available(iOS 10.0, *), isPhone, UIDevice.current.hasHapticFeedback else { return nil }
        guard argc > 0,
            let type = Int(argv[0])
            else {
                return FreArgError().getError()
        }
        tapticController.initImpact(type: type)
        return nil
    }
    
    func prepareImpact(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard #available(iOS 10.0, *), isPhone, UIDevice.current.hasHapticFeedback else { return nil }
        guard argc > 0,
            let type = Int(argv[0])
            else {
                return FreArgError().getError()
        }
        tapticController.prepareImpact(type: type)
        return nil
    }
    
    func releaseImpact(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard #available(iOS 10.0, *), isPhone, UIDevice.current.hasHapticFeedback else { return nil }
        guard argc > 0,
            let type = Int(argv[0])
            else {
                return FreArgError().getError()
        }
        tapticController.releaseImpact(type: type)
        return nil
    }
    
    func impactOccurred(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard #available(iOS 10.0, *), isPhone, UIDevice.current.hasHapticFeedback else { return nil }
        guard argc > 0,
            let type = Int(argv[0])
            else {
                return FreArgError().getError()
        }
        tapticController.impactOccurred(type: type)
        return nil
    }
    
    func prepareSelection(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard #available(iOS 10.0, *), isPhone, UIDevice.current.hasHapticFeedback else { return nil }
        tapticController.prepareSelection()
        return nil
    }
    
    func releaseSelection(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard #available(iOS 10.0, *), isPhone, UIDevice.current.hasHapticFeedback else { return nil }
        tapticController.releaseSelection()
        return nil
    }
    
    func selectionChanged(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard #available(iOS 10.0, *), isPhone, UIDevice.current.hasHapticFeedback else { return nil }
        tapticController.selectionChanged()
        return nil
    }
    
    func hasHapticFeedback(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        return UIDevice.current.hasHapticFeedback.toFREObject()
    }
    
    func hasTapticEngine(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        return UIDevice.current.hasTapticEngine.toFREObject()
    }
    
    @objc public func dispose() {
        guard #available(iOS 10.0, *), isPhone, UIDevice.current.hasTapticEngine else { return }
        tapticController.dispose()
    }
    
}
