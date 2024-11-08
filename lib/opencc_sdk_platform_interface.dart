import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'opencc_sdk_method_channel.dart';

abstract class OpenccSdkPlatform extends PlatformInterface {
  /// Constructs a OpenccSdkPlatform.
  OpenccSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static OpenccSdkPlatform _instance = MethodChannelOpenccSdk();

  /// The default instance of [OpenccSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelOpenccSdk].
  static OpenccSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OpenccSdkPlatform] when
  /// they register themselves.
  static set instance(OpenccSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> convertToTraditional({
    required String simplifiedText,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
