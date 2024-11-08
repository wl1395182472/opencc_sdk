import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'opencc_sdk_platform_interface.dart';

/// An implementation of [OpenccSdkPlatform] that uses method channels.
class MethodChannelOpenccSdk extends OpenccSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('opencc_sdk');

  @override
  Future<String> convertToTraditional({
    required String simplifiedText,
  }) async {
    final data = await methodChannel.invokeMethod<String>(
      'convertToTraditional',
      {
        'simplified_text': simplifiedText,
      },
    );
    return data ?? simplifiedText;
  }
}
