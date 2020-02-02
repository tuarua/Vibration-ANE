package com.tuarua.vibration.android {
public class Waveform extends VibrationEffect {
    private var _timings:Array;
    private var _amplitudes:Array;
    private var _repeat:int;

    /**
     * Create a waveform vibration.
     *
     * Waveform vibrations are a potentially repeating series of timing and amplitude pairs. For
     * each pair, the value in the amplitude array determines the strength of the vibration and the
     * value in the timing array determines how long it vibrates for. An amplitude of 0 implies no
     * vibration (i.e. off), and any pairs with a timing value of 0 will be ignored.
     * <p>
     * The amplitude array of the generated waveform will be the same size as the given
     * timing array with alternating values of 0 (i.e. off) and DEFAULT_AMPLITUDE,
     * starting with 0. Therefore the first timing value will be the period to wait before turning
     * the vibrator on, the second value will be how long to vibrate at DEFAULT_AMPLITUDE
     * strength, etc.
     * </p><p>
     * To cause the pattern to repeat, pass the index into the timings array at which to start the
     * repetition, or -1 to disable repeating.
     * </p>
     *
     * @param timings The pattern of alternating on-off timings, starting with off. Timing values
     *                of 0 will cause the timing / amplitude pair to be ignored.
     * @param amplitudes The amplitude values of the timing / amplitude pairs. Amplitude values
     *                   must be between 0 and 255, or equal to DEFAULT_AMPLITUDE. An
     *                   amplitude value of 0 implies the motor is off.
     * @param repeat The index into the timings array at which to repeat, or -1 if you you don't
     *               want to repeat.
     *
     */
    public function Waveform(timings:Array, amplitudes:Array = null, repeat:int = -1) {
        this._timings = timings;
        this._amplitudes = amplitudes ? amplitudes : [];
        this._repeat = repeat;
    }

    /** @private*/
    public function get timings():Array {
        return _timings;
    }

    /** @private*/
    public function get amplitudes():Array {
        return _amplitudes;
    }

    /** @private*/
    public function get repeat():int {
        return _repeat;
    }
}
}
