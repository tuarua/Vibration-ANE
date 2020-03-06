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

public class Vibrator {
    private static var _shared:Vibrator;

    /** @private */
    public function Vibrator() {
        if (_shared) {
            throw new Error(VibrationANEContext.NAME + " is a singleton, use .shared()");
        }

        if (VibrationANEContext.context) {
            var ret:* = VibrationANEContext.context.call("init");
            if (ret is ANEError) throw ret as ANEError;
        }
        _shared = this;
    }

    public static function shared():Vibrator {
        if (!_shared) new Vibrator();
        return _shared;
    }
    
    /**
     * Vibrate with a given pattern.
     *
     * @param vibe
     */
    android function vibrate(vibe:VibrationEffect):void {
        var ret:* = VibrationANEContext.context.call("vibrate", vibe);
        if (ret is ANEError) throw ret as ANEError;
    }

    /** Vibrate with a given pattern. */
    ios function vibrate(systemSound:int = SystemSoundID.DEFAULT):void {
        var ret:* = VibrationANEContext.context.call("vibrate", systemSound);
        if (ret is ANEError) throw ret as ANEError;
    }

    /** Turn the vibrator off. */
    public function cancel():void {
        var ret:* = VibrationANEContext.context.call("cancel");
        if (ret is ANEError) throw ret as ANEError;
    }

    /**
     * Check whether the hardware has a vibrator.
     *
     * @return True if the hardware has a vibrator, else false.
     */
    public function get hasVibrator():Boolean {
        var ret:* = VibrationANEContext.context.call("hasVibrator");
        if (ret is ANEError) throw ret as ANEError;
        return ret as Boolean;
    }

    /**
     * Check whether the hardware has haptic feedback.
     *
     * @return True if the hardware has haptic feedback, else false. Always returns false on Android.
     */
    public function get hasHapticFeedback():Boolean {
        var ret:* = VibrationANEContext.context.call("hasHapticFeedback");
        if (ret is ANEError) throw ret as ANEError;
        return ret as Boolean;
    }

    /**
     * Check whether the hardware has taptic engine.
     *
     * @return True if the hardware has taptic engine, else false. Always returns false on Android.
     */
    public function get hasTapticEngine():Boolean {
        var ret:* = VibrationANEContext.context.call("hasTapticEngine");
        if (ret is ANEError) throw ret as ANEError;
        return ret as Boolean;
    }

    /** Disposes the ANE */
    public static function dispose():void {
        if (VibrationANEContext.context) {
            VibrationANEContext.dispose();
        }
    }


}
}