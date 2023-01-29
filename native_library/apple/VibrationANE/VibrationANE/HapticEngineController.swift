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
import CoreHaptics

class HapticEngineController: FreSwiftController {
    var context: FreContextSwift!
    static var TAG: String = "HapticEngineController"
    lazy var supportsHaptics = CHHapticEngine.capabilitiesForHardware().supportsHaptics
    private var engine: CHHapticEngine?
    private var _stoppedCallbackId: String?
    var stoppedCallbackId: String? {
        set { _stoppedCallbackId = newValue }
        get { return _stoppedCallbackId }
    }
    
    private var _resetCallbackId: String?
    var resetCallbackId: String? {
        set { _resetCallbackId = newValue }
        get { return _resetCallbackId }
    }
    
    init(ctx: FreContextSwift) {
        self.context = ctx
    }
    
    func createEngine() -> String? {
        do {
            engine = try CHHapticEngine()
        } catch let error {
            return error.localizedDescription
        }
        
        engine?.stoppedHandler = { reason in
            if let callbackId = self.resetCallbackId {
                self.dispatchEvent(name: HapticEngineEvent.HAPTIC_ENGINE_STOPPED,
                value: HapticEngineEvent(callbackId: callbackId, reason: reason).toJSONString())
            }
        }
        
        engine?.resetHandler = {
            if let callbackId = self.stoppedCallbackId {
                self.dispatchEvent(name: HapticEngineEvent.HAPTIC_ENGINE_RESTART,
                value: HapticEngineEvent(callbackId: callbackId).toJSONString())
            }
        }
        return nil
    }
    
    func start() -> String? {
        do {
            try engine?.start()
        } catch let error {
            return error.localizedDescription
        }
        return nil
    }
    
    func stop() -> String? {
        engine?.stop()
        return nil
    }
    
    func playPattern(path: String) -> String? {
        do {
            try engine?.playPattern(from: URL(fileURLWithPath: path))
        } catch let error {
            return error.localizedDescription
        }
        return nil
    }
}
