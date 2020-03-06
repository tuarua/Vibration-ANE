package com.tuarua.vibration.android {
public class OneShot extends VibrationEffect {
    private var _milliseconds:uint;
    private var _amplitude:int = DEFAULT_AMPLITUDE;

    /**
     * Create a one shot vibration.
     *
     * One shot vibrations will vibrate constantly for the specified period of time at the
     * specified amplitude, and then stop.
     *
     * @param milliseconds The number of milliseconds to vibrate. This must be a positive number.
     * @param amplitude The strength of the vibration. This must be a value between 1 and 255, or
     * DEFAULT_AMPLITUDE.
     *
     */
    public function OneShot(milliseconds:uint, amplitude:int = -1) {
        this._milliseconds = milliseconds;
        this._amplitude = amplitude;
    }

    /** @private */
    public function get milliseconds():int {
        return _milliseconds;
    }

    /** @private */
    public function get amplitude():int {
        return _amplitude;
    }
}
}
