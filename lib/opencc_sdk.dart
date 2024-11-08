import 'opencc_sdk_platform_interface.dart';

class OpenccSdk {
  static Future<String> convertToTraditional({
    required String simplifiedText,
  }) {
    return OpenccSdkPlatform.instance.convertToTraditional(
      simplifiedText: simplifiedText,
    );
  }
}
