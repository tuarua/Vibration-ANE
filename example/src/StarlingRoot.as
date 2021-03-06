package {

import com.tuarua.Vibrator;
import com.tuarua.android;
import com.tuarua.fre.ANEError;
import com.tuarua.ios;
import com.tuarua.utils.os;
import com.tuarua.vibration.android.OneShot;
import com.tuarua.vibration.android.Waveform;
import com.tuarua.vibration.ios.HapticEngine;
import com.tuarua.vibration.ios.NotificationFeedbackGenerator;
import com.tuarua.vibration.ios.NotificationFeedbackType;
import com.tuarua.vibration.ios.StoppedReason;
import com.tuarua.vibration.ios.SystemSoundID;

import flash.desktop.NativeApplication;
import flash.events.Event;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

import views.SimpleButton;

public class StarlingRoot extends Sprite {
    private var btnSimple:SimpleButton = new SimpleButton("Simple Vibrate");
    private var btnMulti:SimpleButton = new SimpleButton("Multi Vibrate");
    private var btnRepeat:SimpleButton = new SimpleButton("Repeat Vibrate");
    private var btnCancel:SimpleButton = new SimpleButton("Cancel Vibrate");
    private var btnTaptic:SimpleButton = new SimpleButton("Notification Taptic");
    private var btnHapticEngine:SimpleButton = new SimpleButton("Haptic Engine");
    private var vibrator:Vibrator;
    private var hapticEngine:HapticEngine;

    public function StarlingRoot() {
        TextField.registerCompositor(Fonts.getFont("fira-sans-semi-bold-13"), "Fira Sans Semi-Bold 13");
        NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExiting);
    }

    public function start():void {
        vibrator = Vibrator.shared();
        trace("vibrator.hasVibrator:", vibrator.hasVibrator);
        trace("vibrator.hasTapticEngine:", vibrator.hasTapticEngine);
        trace("vibrator.hasHapticFeedback:", vibrator.hasHapticFeedback);
        trace("HapticEngine.supportsHaptics:", HapticEngine.supportsHaptics);
        if (vibrator.hasVibrator) {
            initMenu();
        }
    }

    private function initMenu():void {
        btnSimple.x = (stage.stageWidth - 200) * 0.5;
        btnSimple.y = 100;
        btnSimple.addEventListener(TouchEvent.TOUCH, onBasicClick);
        addChild(btnSimple);

        if (os.isAndroid) {
            btnMulti.y = 180;
            btnMulti.addEventListener(TouchEvent.TOUCH, onMultiClick);
            addChild(btnMulti);

            btnRepeat.y = 260;
            btnRepeat.addEventListener(TouchEvent.TOUCH, onRepeatClick);
            addChild(btnRepeat);

            btnCancel.x = btnRepeat.x = btnMulti.x = btnSimple.x;
            btnCancel.y = 340;
            btnCancel.addEventListener(TouchEvent.TOUCH, onCancelClick);
            btnCancel.visible = false;
            addChild(btnCancel);
        } else if (vibrator.hasHapticFeedback) {
            btnTaptic.y = 180;
            btnTaptic.addEventListener(TouchEvent.TOUCH, onTapticClick);
            addChild(btnTaptic);

            if (HapticEngine.supportsHaptics) {
                try {
                    hapticEngine = new HapticEngine();
                } catch (e:ANEError) {
                    trace(e.message);
                    return;
                }
                hapticEngine.stoppedHandler = function (reason:int):void {
                    switch (reason) {
                        case StoppedReason.applicationSuspended:
                            break;
                        case StoppedReason.audioSessionInterrupt:
                            break;
                        case StoppedReason.idleTimeout:
                            break;
                        case StoppedReason.notifyWhenFinished:
                            break;
                        case StoppedReason.systemError:
                            break;
                    }
                };
                hapticEngine.resetHandler = function ():void {
                    try {
                        trace("The engine reset --> Restarting now!");
                        hapticEngine.start();
                    } catch (e:ANEError) {
                        trace(e.message);
                    }
                };
                btnHapticEngine.y = 260;
                btnHapticEngine.addEventListener(TouchEvent.TOUCH, onHapticEngineClick);
                addChild(btnHapticEngine);
            }

        }
    }

    private function onTapticClick(event:TouchEvent):void {
        var touch:Touch = event.getTouch(btnTaptic);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            var notificationFeedbackGenerator:NotificationFeedbackGenerator = new NotificationFeedbackGenerator();
            notificationFeedbackGenerator.prepare();
            notificationFeedbackGenerator.notificationOccurred(NotificationFeedbackType.SUCCESS);
            notificationFeedbackGenerator.release();
        }
    }

    private function onBasicClick(event:TouchEvent):void {
        var touch:Touch = event.getTouch(btnSimple);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            if (os.isAndroid) {
                vibrator.android::vibrate(new OneShot(150));
            } else if (os.isIos) {
                vibrator.ios::vibrate(vibrator.hasTapticEngine ? SystemSoundID.POP : SystemSoundID.DEFAULT);
            }
        }
    }

    private function onMultiClick(event:TouchEvent):void {
        var touch:Touch = event.getTouch(btnMulti);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            vibrator.android::vibrate(new Waveform([0, 100, 1000, 300]));
        }
    }

    private function onRepeatClick(event:TouchEvent):void {
        var touch:Touch = event.getTouch(btnRepeat);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            btnCancel.visible = true;
            vibrator.android::vibrate(new Waveform([0, 100, 1000, 300], null, 0));
        }
    }

    private function onCancelClick(event:TouchEvent):void {
        var touch:Touch = event.getTouch(btnCancel);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            btnCancel.visible = false;
            vibrator.cancel();
        }
    }

    private function onHapticEngineClick(event:TouchEvent):void {
        var touch:Touch = event.getTouch(btnHapticEngine);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            try {
                hapticEngine.start();
                hapticEngine.playPattern("AHAP/Heartbeats");
            } catch (e:ANEError) {
                trace(e.message);
            }
        }
    }

    private function onExiting(event:Event):void {
        Vibrator.dispose();
    }

}
}