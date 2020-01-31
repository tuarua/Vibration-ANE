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
import flash.events.StatusEvent;
import flash.external.ExtensionContext;
import flash.utils.Dictionary;

/** @private */
public class VibrationANEContext {
    internal static const NAME:String = "VibrationANE";
    internal static const TRACE:String = "TRACE";
    private static const HAPTIC_ENGINE_STOPPED:String = "HapticEngineEvent.Stopped";
    private static const HAPTIC_ENGINE_RESTART:String = "HapticEngineEvent.Restart";
    private static var _context:ExtensionContext;
    public static var callbacks:Dictionary = new Dictionary();
    private static var _isDisposed:Boolean;
    private static var argsAsJSON:Object;
    public function VibrationANEContext() {
    }
    public static function get context():ExtensionContext {
        if (_context == null) {
            try {
                _context = ExtensionContext.createExtensionContext("com.tuarua." + NAME, null);
                _context.addEventListener(StatusEvent.STATUS, gotEvent);
                _isDisposed = false;
            } catch (e:Error) {
                throw new Error("ANE " + NAME + " not created properly.  Future calls will fail.");
            }
        }
        return _context;
    }

    public static function createCallback(listener:Function):String {
        var id:String;
        if (listener) {
            id = context.call("createGUID") as String;
            callbacks[id] = listener;
        }
        return id;
    }

    public static function callCallback(callbackId:String, clear:Boolean = true, ... args):void {
        var callback:Function = callbacks[callbackId];
        if (callback == null) return;
        callback.apply(null, args);
        if (clear) {
            delete callbacks[callbackId];
        }
    }

    private static function gotEvent(event:StatusEvent):void {
        switch (event.level) {
            case TRACE:
                trace("[" + NAME + "]", event.code);
                break;
            case HAPTIC_ENGINE_STOPPED:
                argsAsJSON = JSON.parse(event.code);
                callCallback(argsAsJSON.callbackId, false, argsAsJSON.reason);
                break;
            case HAPTIC_ENGINE_RESTART:
                argsAsJSON = JSON.parse(event.code);
                callCallback(argsAsJSON.callbackId);
                break;
        }
    }

    public static function dispose():void {
        if (!_context) {
            return;
        }
        _isDisposed = true;
        trace("[" + NAME + "] Unloading ANE...");
        _context.removeEventListener(StatusEvent.STATUS, gotEvent);
        _context.dispose();
        _context = null;
    }

    public static function get isDisposed():Boolean {
        return _isDisposed;
    }
}
}
