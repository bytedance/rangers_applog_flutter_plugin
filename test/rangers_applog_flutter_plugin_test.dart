import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rangers_applog_flutter_plugin/rangers_applog_flutter_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('rangers_applog_flutter_plugin');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await RangersApplogFlutterPlugin.sdkVersion, '4.0.0');
  });
}
