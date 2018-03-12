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

import flash.events.EventDispatcher;

public class VibrationANE extends EventDispatcher {
    private var _isInited:Boolean;
    private static var _vibrator:VibrationANE;
    /** @private */
    public function VibrationANE() {
        if (_vibrator) {
            throw new Error(VibrationANEContext.NAME + " is a singleton, use .mapView");
        }

        if (VibrationANEContext.context) {
            var theRet:* = VibrationANEContext.context.call("init");
            if (theRet is ANEError) {
                throw theRet as ANEError;
            }
            _isInited = theRet as Boolean;
        }
        _vibrator = this;
    }

    public static function get vibrator():VibrationANE {
        if (!_vibrator) {
            new VibrationANE();
        }
        return _vibrator;
    }

    /**
     * Vibrate with a given pattern.
     *
     * <p>
     * Pass in an array of ints that are the durations for which to turn on or off
     * the vibrator in milliseconds.  The first value indicates the number of milliseconds
     * to wait before turning the vibrator on.  The next value indicates the number of milliseconds
     * for which to keep the vibrator on before turning it off.  Subsequent values alternate
     * between durations in milliseconds to turn the vibrator off or to turn the vibrator on.
     * </p><p>
     * To cause the pattern to repeat, pass the index into the pattern array at which
     * to start the repeat, or -1 to disable repeating.
     * </p>
     *
     * @param milliseconds the number of milliseconds to vibrate. Set to 0 when using a pattern. Ignored on iOS
     * @param pattern an array of longs of times for which to turn the vibrator on or off. Ignored on iOS
     * @param repeat the index into pattern at which to repeat, or -1 if
     *        you don't want to repeat. Ignored on iOS
     */
    public function vibrate(milliseconds:int = 0, pattern:Array = null, repeat:int = -1):void {
        if (safetyCheck()) {
            var theRet:* = VibrationANEContext.context.call("vibrate", milliseconds, pattern ? pattern : [], repeat);
            if (theRet is ANEError) {
                throw theRet as ANEError;
            }
        }
    }
    /** Turn the vibrator off. */
    public function cancel():void {
        if (safetyCheck()) {
            var theRet:* = VibrationANEContext.context.call("cancel");
            if (theRet is ANEError) {
                throw theRet as ANEError;
            }
        }
    }

    /**
     * Check whether the hardware has a vibrator.
     *
     * @return True if the hardware has a vibrator, else false.
     */
    public function get hasVibrator():Boolean {
        if (safetyCheck()) {
            var theRet:* = VibrationANEContext.context.call("hasVibrator");
            if (theRet is ANEError) {
                throw theRet as ANEError;
            }
            return theRet as Boolean;
        }
        return false;
    }

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
    private function safetyCheck():Boolean {
        if (!_isInited || VibrationANEContext.isDisposed) {
            trace("You need to init first");
            return false;
        }
        return true;
    }

}
}