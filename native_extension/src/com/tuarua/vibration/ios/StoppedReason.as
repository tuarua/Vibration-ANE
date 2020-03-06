package com.tuarua.vibration.ios {
/** An enumeration of possible reasons the haptic engine stopped running. */
public final class StoppedReason {
    /** The audio session was interrupted. */
    public static const audioSessionInterrupt:int = 1;
    /** The app with haptics was suspended. */
    public static const applicationSuspended:int = 2;
    /** The haptic engine timed out during a task. */
    public static const idleTimeout:int = 3;
    /** You've asked to be notified notifyWhenPlayersFinished shuts down the engine. */
    public static const notifyWhenFinished:int = 4;
    /** A system error stopped the engine. */
    public static const systemError:int = -1;
}
}
