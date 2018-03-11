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
import com.adobe.fre.FREArray
import com.adobe.fre.FREContext
import com.adobe.fre.FREObject
import com.tuarua.frekotlin.*

// TODO bring into FreKotlin library
fun LongArray(freArray: FREArray?): LongArray? {
    if (freArray != null) {
        val count = freArray.length.toInt()
        val kotArr: LongArray = kotlin.LongArray(count)
        for (i in 0 until count) {
            val v = Long(freArray.getObjectAt(i.toLong()))
            when {
                v != null -> kotArr[i] = v
                else -> return null
            }
        }
        return kotArr
    }
    return null
}

fun LongArray(freObject: FREObject?): LongArray? {
    if (freObject != null) {
        return LongArray(FREArray(freObject))
    }
    return null
}
// TODO End

@Suppress("unused", "UNUSED_PARAMETER", "UNCHECKED_CAST")
class KotlinController : FreKotlinMainController {
    private var vibrator: Vibrator? = null
    private var packageManager: PackageManager? = null
    private var packageInfo: PackageInfo? = null
    private var permissionsGranted = false
    private val permissionsNeeded: Array<String> = arrayOf(Manifest.permission.VIBRATE)

    fun init(ctx: FREContext, argv: FREArgv): FREObject? {
        val appActivity = ctx.activity ?: return false.toFREObject()
        vibrator = ctx.activity.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
        packageManager = appActivity.packageManager
        val pm = packageManager ?: return false.toFREObject()
        packageInfo = pm.getPackageInfo(appActivity.packageName, PackageManager.GET_PERMISSIONS)
        return hasRequiredPermissions().toFREObject()
    }

    fun vibrate(ctx: FREContext, argv: FREArgv): FREObject? {
        argv.takeIf { argv.size > 2 } ?: return ArgCountException().getError(Thread.currentThread().stackTrace)
        val milliseconds = Long(argv[0])
                ?: return FreException("cannot convert milliseconds").getError(arrayOf())
        val pattern = LongArray(argv[1])
                ?: return FreException("cannot convert pattern").getError(arrayOf())
        val repeat = Int(argv[2])
                ?: return FreException("cannot convert repeat").getError(arrayOf())

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            when {
                pattern.isEmpty() -> vibrator?.vibrate(VibrationEffect.createOneShot(milliseconds,
                        VibrationEffect.DEFAULT_AMPLITUDE))
                else -> vibrator?.vibrate(VibrationEffect.createWaveform(pattern, repeat))
            }
        } else {
            when {
                pattern.isEmpty() -> vibrator?.vibrate(milliseconds)
                else -> vibrator?.vibrate(pattern, repeat)
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

    override val TAG: String
        get() = this::class.java.simpleName
    private var _context: FREContext? = null
    override var context: FREContext?
        get() = _context
        set(value) {
            _context = value
        }
}