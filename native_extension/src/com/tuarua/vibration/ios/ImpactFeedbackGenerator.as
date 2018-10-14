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

package com.tuarua.vibration.ios {
import com.tuarua.VibrationANE;
import com.tuarua.VibrationANEContext;
import com.tuarua.fre.ANEError;

/** ImpactFeedbackGenerator is used to give user feedback when an impact between UI elements occurs */
public class ImpactFeedbackGenerator {
    private var type:uint;

    public function ImpactFeedbackGenerator(type:uint) {
        this.type = type;
        if (!VibrationANE.safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("initImpact", type);
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /** Informs self that it will likely receive events soon, so that it can ensure minimal latency for
     * any feedback generated safe to call more than once before the generator receives an event,
     * if events are still imminently possible */
    public function prepare():void {
        if (!VibrationANE.safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("prepareImpact", type);
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /** Release the ImpactFeedbackGenerator. */
    public function release():void {
        if (!VibrationANE.safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("releaseImpact", type);
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /** Call when your UI element impacts something else */
    public function impactOccurred():void {
        if (!VibrationANE.safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("impactOccurred", type);
        if (theRet is ANEError) throw theRet as ANEError;
    }

}
}
