package com.tuarua.vibration.ios {
import com.tuarua.VibrationANE;
import com.tuarua.VibrationANEContext;
import com.tuarua.fre.ANEError;

public class HapticEngine {
    /**
     * An object that manages your app's requests to play haptic patterns.
     *
     * <p>If you want your app to play custom haptics, you need to create a haptic engine.
     * The haptic engine establishes the connection between your app and the underlying device hardware.
     * Even though you can define a haptic pattern without an engine, you need the engine to play that pattern.
     * Even though your app makes a request through the haptic engine, the operating system could still
     * override the request with system services, like haptics from system notifications.</p>
     *
     * @throws An ANEError if the engine cannot be created
     * */
    public function HapticEngine() {
        if (!VibrationANE.safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("initHapticEngine");
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /**
     * Plays a plist pattern from the specified URL.
     *
     * <p>This method blocks processing on the current thread until the pattern has finished playing.</p>
     * @throws An ANEError if the pattern cannot be played.
     * @param fileName The file name of the AHAP file containing the haptic event dictionary.
     * */
    public function playPattern(fileName:String):void {
        if (!VibrationANE.safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("playPattern", fileName);
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /**
     * Synchronously starts the haptic engine.
     *
     * <p>This method blocks all subsequent event processing on the current thread until the engine has started.
     * It throws an error if the engine can't start.</p>
     * @throws An ANEError if the pattern cannot be played.
     * */
    public function start():void {
        if (!VibrationANE.safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("startHapticEngine");
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /**
     * Asynchronously stop the engine. The handler will be called when the operation completes.
     *
     * <p>The handler is guaranteed to be called on either success or failure.</p>
     * */
    public function stop():void {
        if (!VibrationANE.safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("stopHapticEngine");
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /**
     * A function that the haptic engine calls after recovering from a haptic server error.
     *
     * <p>External causes that can trigger this block include audio session interruption, application suspension,
     * or system error. Calling stop doesn't trigger this block.
     * Callbacks to this block arrive on a non-main thread, so handle them in a thread-safe manner.</p>
     * */
    public function set stoppedHandler(value:Function):void {
        if (!VibrationANE.safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("stoppedHandler",
                VibrationANEContext.createCallback(value));
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /**
     * A function that the haptic engine calls when it stops due to external causes.
     *
     * <p>If the handler has to reset itself after a server failure, the system calls this block asynchronously.
     * In this block, release all haptic pattern players and recreate them. The system preserves HapticPattern
     * objects and HapticEngine properties across restarts. Consider trying to restart the engine inside the
     * reset block.</p>
     * */
    public function set resetHandler(value:Function):void {
        if (!VibrationANE.safetyCheck()) return;
        var theRet:* = VibrationANEContext.context.call("resetHandler",
                VibrationANEContext.createCallback(value));
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /**
     * A Boolean value that indicates whether the device supports haptic event playback.
     * */
    public static function get supportsHaptics():Boolean {
        if (!VibrationANE.safetyCheck()) return false;
        return VibrationANEContext.context.call("hasHapticEngine") as Boolean;
    }

}
}
