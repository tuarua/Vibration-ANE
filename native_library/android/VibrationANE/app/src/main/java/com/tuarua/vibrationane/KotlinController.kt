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
package com.tuarua.vibrationane

import android.Manifest
import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import com.adobe.fre.FREContext
import com.adobe.fre.FREObject
import com.tuarua.frekotlin.*

@Suppress("unused", "UNUSED_PARAMETER", "UNCHECKED_CAST", "PropertyName", "DEPRECATION")
class KotlinController : FreKotlinMainController {
    private var vibrator: Vibrator? = null
    private var packageManager: PackageManager? = null
    private var packageInfo: PackageInfo? = null
    private var permissionsGranted = false
    private val permissionsNeeded: Array<String> = arrayOf(Manifest.permission.VIBRATE)
    private val oneShot = "OneShot"
    private val waveform = "Waveform"
    private fun hasRequiredPermissions(): Boolean {
        val pi = packageInfo ?: return false
        permissionsNeeded.forEach { p ->
            if (p !in pi.requestedPermissions) {
                trace("Please add $p to uses-permission list in your AIR manifest")
                return false
            }
        }
        return true
    }

    fun init(ctx: FREContext, argv: FREArgv): FREObject? {
        val appActivity = ctx.activity ?: return false.toFREObject()
        vibrator = ctx.activity.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
        packageManager = appActivity.packageManager
        val pm = packageManager ?: return false.toFREObject()
        packageInfo = pm.getPackageInfo(appActivity.packageName, PackageManager.GET_PERMISSIONS)
        return hasRequiredPermissions().toFREObject()
    }

    fun vibrate(ctx: FREContext, argv: FREArgv): FREObject? {
        argv.takeIf { argv.size > 0 } ?: return FreArgException()
        val freVibe = argv[0]
        val className = freVibe.className?.split("::")?.last() ?: return null
        var milliseconds: Long = 0
        var amplitude = 0
        var timings = longArrayOf()
        var amplitudes = intArrayOf()
        var repeat = 0

        when (className) {
            oneShot -> {
                milliseconds = Long(freVibe["milliseconds"]) ?: milliseconds
                amplitude = Int(freVibe["amplitude"]) ?: amplitude
            }
            waveform -> {
                timings = LongArray(freVibe["timings"]) ?: timings
                amplitudes = IntArray(freVibe["amplitudes"])
                repeat = Int(freVibe["repeat"]) ?: repeat
            }
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) when (className) {
            oneShot -> vibrator?.vibrate(VibrationEffect.createOneShot(milliseconds, amplitude))
            waveform -> if (amplitudes.isEmpty()) {
                vibrator?.vibrate(VibrationEffect.createWaveform(timings, repeat))
            } else {
                vibrator?.vibrate(VibrationEffect.createWaveform(timings, amplitudes, repeat))
            }
        } else {
            when (className) {
                oneShot -> vibrator?.vibrate(milliseconds)
                waveform -> vibrator?.vibrate(timings, repeat)
            }
        }
        return null
    }

    fun cancel(ctx: FREContext, argv: FREArgv): FREObject? {
        vibrator?.cancel()
        return null
    }

    fun hasVibrator(ctx: FREContext, argv: FREArgv): FREObject? {
        return vibrator?.hasVibrator()?.toFREObject() ?: false.toFREObject()
    }

    fun notificationOccurred(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun releaseNotification(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun prepareNotification(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun prepareImpact(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun initImpact(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun releaseImpact(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun prepareSelection(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun releaseSelection(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun selectionChanged(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun hasHapticFeedback(ctx: FREContext, argv: FREArgv): FREObject? = false.toFREObject()
    fun hasTapticEngine(ctx: FREContext, argv: FREArgv): FREObject? = false.toFREObject()
    fun hasHapticEngine(ctx: FREContext, argv: FREArgv): FREObject? = false.toFREObject()
    fun initHapticEngine(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun stoppedHandler(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun resetHandler(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun startHapticEngine(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun stopHapticEngine(ctx: FREContext, argv: FREArgv): FREObject? = null
    fun playPattern(ctx: FREContext, argv: FREArgv): FREObject? = null

    override val TAG: String?
        get() = this::class.java.simpleName
    private var _context: FREContext? = null
    override var context: FREContext?
        get() = _context
        set(value) {
            _context = value
            FreKotlinLogger.context = _context
        }
}