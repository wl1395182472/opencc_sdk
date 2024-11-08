import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencc_sdk/opencc_sdk_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelOpenccSdk platform = MethodChannelOpenccSdk();
  const MethodChannel channel = MethodChannel('opencc_sdk');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.convertToTraditional(simplifiedText: '简体中文'), '42');
  });
}
