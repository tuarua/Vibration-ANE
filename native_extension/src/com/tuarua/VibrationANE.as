/*
 *  Copyright 2018 Tua Rua Ltd.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package com.tuarua {
import com.tuarua.fre.ANEError;
import com.tuarua.vibration.android.VibrationEffect;
import com.tuarua.vibration.ios.SystemSoundID;

import flash.events.EventDispatcher;

public class VibrationANE extends EventDispatcher {
    private static var _isInited:Boolean;
    private static var _vibrator:VibrationANE;

    /** @private */
    public function VibrationANE() {
        if (_vibrator) {
            throw new Error(VibrationANEContext.NAME + " is a singleton, use .vibrator");
        }

        if (VibrationANEContext.context) {
            var theRet:* = VibrationANEContext.context.call("init");
            if (theRet is ANEError) throw theRet as ANEError;
            _isInited = theRet as Boolean;
        }
        _vibrator = this;
    }

    public static function get vibrator():VibrationANE {
        if (!_vibrator) new VibrationANE();
        return _vibrator;
    }
    
    /**
     * Vibrate with a given pattern.
     *
     * @param vibe
     */
    android function vibrate(vibe:VibrationEffect):void {
        if (!safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("vibrate", vibe);
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /** Vibrate with a given pattern. */
    ios function vibrate(systemSound:int = SystemSoundID.DEFAULT):void {
        if (!safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("vibrate", systemSound);
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /** Turn the vibrator off. */
    public function cancel():void {
        if (!safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("cancel");
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /**
     * Check whether the hardware has a vibrator.
     *
     * @return True if the hardware has a vibrator, else false.
     */
    public function get hasVibrator():Boolean {
        if (!safetyCheck()) return false;
        var theRet:* = VibrationANEContext.context.call("hasVibrator");
        if (theRet is ANEError) throw theRet as ANEError;
        return theRet as Boolean;
    }

    /**
     * Check whether the hardware has haptic feedback.
     *
     * @return True if the hardware has haptic feedback, else false. Always returns false on Android.
     */
    public function get hasHapticFeedback():Boolean {
        if (!safetyCheck()) return false;
        var theRet:* = VibrationANEContext.context.call("hasHapticFeedback");
        if (theRet is ANEError) throw theRet as ANEError;
        return theRet as Boolean;
    }

    /**
     * Check whether the hardware has taptic engine.
     *
     * @return True if the hardware has taptic engine, else false. Always returns false on Android.
     */
    public function get hasTapticEngine():Boolean {
        if (!safetyCheck()) return false;
        var theRet:* = VibrationANEContext.context.call("hasTapticEngine");
        if (theRet is ANEError) throw theRet as ANEError;
        return theRet as Boolean;
    }

    /** Disposes the ANE */
    public static function dispose():void {
        if (VibrationANEContext.context) {
            VibrationANEContext.dispose();
        }
    }

    /** @return whether we have inited */
    public function get isInited():Boolean {
        return _isInited;
    }

    /** @private */
    public static function safetyCheck():Boolean {
        if (!_isInited || VibrationANEContext.isDisposed) {
            trace("You need to init first");
            return false;
        }
        return true;
    }

}
}