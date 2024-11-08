package com.example.opencc_sdk

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import com.github.houbb.opencc4j.util.ZhConverterUtil

/** OpenccSdkPlugin */
class OpenccSdkPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "opencc_sdk")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "convertToTraditional") {
            val simplifiedText = call.argument<String>("simplified_text")
            if (simplifiedText != null) {
                result.success(convertToTraditional(simplifiedText))
            } else {
                result.notImplemented()
            }
        } else {
            result.notImplemented()
        }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }   
  
   private fun convertToTraditional(simplifiedText: String): String {
        return ZhConverterUtil.toTraditional(simplifiedText)
    }
}
