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
import AudioToolbox

@available(iOS 10.0, *)
class TapticController: NSObject {
    var notificationFeedbackGenerator: UINotificationFeedbackGenerator?
    var lightImpactFeedbackGenerator: UIImpactFeedbackGenerator?
    var mediumImpactFeedbackGenerator: UIImpactFeedbackGenerator?
    var heavyImpactFeedbackGenerator: UIImpactFeedbackGenerator?
    var selectionFeedbackGenerator: UISelectionFeedbackGenerator?
    
    func prepareNotification() {
        notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator?.prepare()
    }
    
    func releaseNotification() {
        notificationFeedbackGenerator = nil
    }
    
    func notificationOccurred(type: Int) {
        guard let freedbackType = UINotificationFeedbackType(rawValue: type) else { return }
        notificationFeedbackGenerator?.notificationOccurred(freedbackType)
    }
    
    func initImpact(type: Int) {
        switch type {
        case 0:
            lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        case 1:
            mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        case 2:
            heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        default: break
        }
    }
    
    func prepareImpact(type: Int) {
        switch type {
        case 0:
            lightImpactFeedbackGenerator?.prepare()
        case 1:
            mediumImpactFeedbackGenerator?.prepare()
        case 2:
            heavyImpactFeedbackGenerator?.prepare()
        default: break
        }
    }
    
    func releaseImpact(type: Int) {
        switch type {
        case 0:
            lightImpactFeedbackGenerator = nil
        case 1:
            mediumImpactFeedbackGenerator = nil
        case 2:
            heavyImpactFeedbackGenerator = nil
        default: break
        }
    }
    
    func impactOccurred(type: Int) {
        switch type {
        case 0:
            lightImpactFeedbackGenerator?.impactOccurred()
        case 1:
            mediumImpactFeedbackGenerator?.impactOccurred()
        case 2:
            heavyImpactFeedbackGenerator?.impactOccurred()
        default: break
        }
    }
    
    func prepareSelection() {
        selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator?.prepare()
    }
    
    func releaseSelection() {
        selectionFeedbackGenerator = nil
    }
    
    func selectionChanged() {
        selectionFeedbackGenerator?.selectionChanged()
    }
    
    func dispose() {
        notificationFeedbackGenerator = nil
        lightImpactFeedbackGenerator = nil
        mediumImpactFeedbackGenerator = nil
        heavyImpactFeedbackGenerator = nil
        selectionFeedbackGenerator = nil
    }
    
}
