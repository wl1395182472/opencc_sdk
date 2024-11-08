import 'package:flutter_test/flutter_test.dart';
import 'package:opencc_sdk/opencc_sdk.dart';
import 'package:opencc_sdk/opencc_sdk_platform_interface.dart';
import 'package:opencc_sdk/opencc_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOpenccSdkPlatform
    with MockPlatformInterfaceMixin
    implements OpenccSdkPlatform {
  @override
  Future<String> convertToTraditional({
    required String simplifiedText,
  }) =>
      Future.value('42');
}

void main() {
  final OpenccSdkPlatform initialPlatform = OpenccSdkPlatform.instance;

  test('$MethodChannelOpenccSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOpenccSdk>());
  });

  test('getPlatformVersion', () async {
    MockOpenccSdkPlatform fakePlatform = MockOpenccSdkPlatform();
    OpenccSdkPlatform.instance = fakePlatform;

    expect(await OpenccSdk.convertToTraditional(simplifiedText: '简体中文'), '42');
  });
}
