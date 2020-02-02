package com.tuarua.vibration.android {
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

public class VibrationEffect {
    /** The default vibration strength of the device.*/
    public static var DEFAULT_AMPLITUDE:int = -1;

    public function VibrationEffect() {
        var className:String = getQualifiedClassName(this);
        if (getDefinitionByName(className) == VibrationEffect) {
            throw new ArgumentError(getQualifiedClassName(this) + "Class can not be instantiated.");
        }
    }
}
}
