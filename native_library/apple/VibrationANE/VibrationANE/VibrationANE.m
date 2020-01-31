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

#import "FreMacros.h"
#import "VibrationANE_oc.h"
#import <VibrationANE_FW/VibrationANE_FW.h>

#define FRE_OBJC_BRIDGE TRVIB_FlashRuntimeExtensionsBridge
@interface FRE_OBJC_BRIDGE : NSObject<FreSwiftBridgeProtocol>
@end
@implementation FRE_OBJC_BRIDGE {
}
FRE_OBJC_BRIDGE_FUNCS
@end

@implementation VibrationANE_LIB
SWIFT_DECL(TRVIB)
CONTEXT_INIT(TRVIB) {
    SWIFT_INITS(TRVIB)

    static FRENamedFunction extensionFunctions[] =
    {
         MAP_FUNCTION(TRVIB, init)
        ,MAP_FUNCTION(TRVIB, vibrate)
        ,MAP_FUNCTION(TRVIB, cancel)
        ,MAP_FUNCTION(TRVIB, hasVibrator)
        ,MAP_FUNCTION(TRVIB, prepareNotification)
        ,MAP_FUNCTION(TRVIB, releaseNotification)
        ,MAP_FUNCTION(TRVIB, notificationOccurred)
        ,MAP_FUNCTION(TRVIB, initImpact)
        ,MAP_FUNCTION(TRVIB, prepareImpact)
        ,MAP_FUNCTION(TRVIB, releaseImpact)
        ,MAP_FUNCTION(TRVIB, impactOccurred)
        ,MAP_FUNCTION(TRVIB, prepareSelection)
        ,MAP_FUNCTION(TRVIB, releaseSelection)
        ,MAP_FUNCTION(TRVIB, selectionChanged)
        ,MAP_FUNCTION(TRVIB, hasHapticFeedback)
        ,MAP_FUNCTION(TRVIB, hasTapticEngine)
        ,MAP_FUNCTION(TRVIB, hasHapticEngine)
        ,MAP_FUNCTION(TRVIB, initHapticEngine)
        ,MAP_FUNCTION(TRVIB, stoppedHandler)
        ,MAP_FUNCTION(TRVIB, resetHandler)
        ,MAP_FUNCTION(TRVIB, startHapticEngine)
        ,MAP_FUNCTION(TRVIB, stopHapticEngine)
        ,MAP_FUNCTION(TRVIB, playPattern)
    };
    
    SET_FUNCTIONS
    
}

CONTEXT_FIN(TRVIB) {
    [TRVIB_swft dispose];
    TRVIB_swft = nil;
    TRVIB_freBridge = nil;
    TRVIB_swftBridge = nil;
    TRVIB_funcArray = nil;
}
EXTENSION_INIT(TRVIB)
EXTENSION_FIN(TRVIB)
@end
