import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_library_universal_swiss_tool_plugin/flutter_library_universal_swiss_tool_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_library_universal_swiss_tool_plugin');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterLibraryUniversalSwissToolPlugin.platformVersion, '42');
  });
}
