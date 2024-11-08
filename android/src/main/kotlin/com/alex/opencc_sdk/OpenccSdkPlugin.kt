package com.alex.opencc_sdk

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.github.houbb.opencc4j.util.ZhConverterUtil

/** OpenccSdkPlugin */
class OpenccSdkPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "opencc_sdk")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "convertToTraditional") {
            val simplifiedText = call.argument<String>("simplified_text")
            if (simplifiedText != null) {
                try {
                    val traditionalText = ZhConverterUtil.toTraditional(simplifiedText)
                    result.success(traditionalText)
                } catch (e: Exception) {
                    // 捕获并返回错误信息
                    result.error("CONVERSION_ERROR", "Failed to convert text to traditional Chinese", e.localizedMessage)
                }
            } else {
                result.error("INVALID_ARGUMENT", "Argument 'simplified_text' is missing or null", null)
            }
        } else {
            result.notImplemented()
        }
    }
}
