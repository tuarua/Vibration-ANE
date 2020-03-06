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
import com.tuarua.VibrationANEContext;
import com.tuarua.fre.ANEError;

/** NotificationFeedbackGenerator is used to give user feedback when an notification is displayed */
public class NotificationFeedbackGenerator {
    public function NotificationFeedbackGenerator() {
    }

    /** Informs self that it will likely receive events soon, so that it can ensure minimal latency for
     * any feedback generated safe to call more than once before the generator receives an event,
     * if events are still imminently possible */
    public function prepare():void {
        var ret:* = VibrationANEContext.context.call("prepareNotification");
        if (ret is ANEError) throw ret as ANEError;
    }

    /** Release the NotificationFeedbackGenerator.*/
    public function release():void {
        var ret:* = VibrationANEContext.context.call("releaseNotification");
        if (ret is ANEError) throw ret as ANEError;
    }

    /** Call when a notification is displayed, passing the corresponding type */
    public function notificationOccurred(notificationType:uint):void {
        var ret:* = VibrationANEContext.context.call("notificationOccurred", notificationType);
        if (ret is ANEError) throw ret as ANEError;
    }


}
}
