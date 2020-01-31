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

@available(iOS 13.0, *)
class HapticEngineController: FreSwiftController {
    var context: FreContextSwift!
    static var TAG: String = "HapticEngineController"
    lazy var supportsHaptics = CHHapticEngine.capabilitiesForHardware().supportsHaptics
    private var engine: CHHapticEngine?
    
    init(ctx: FreContextSwift) {
        self.context = ctx
    }
    
    func createEngine(callbackId: String) -> String? {
        do {
            engine = try CHHapticEngine()
        } catch let error {
            return error.localizedDescription
        }
        engine?.stoppedHandler = { reason in
            self.dispatchEvent(name: HapticEngineEvent.HAPTIC_ENGINE_STOPPED,
                               value: HapticEngineEvent(callbackId: callbackId, reason: reason).toJSONString())
        }
        
        engine?.resetHandler = {
            do {
                try self.engine?.start()
            } catch {
                self.warning("Failed to restart the engine: \(error)")
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
