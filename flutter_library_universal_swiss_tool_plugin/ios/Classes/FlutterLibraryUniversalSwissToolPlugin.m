#import "FlutterLibraryUniversalSwissToolPlugin.h"

@implementation FlutterLibraryUniversalSwissToolPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_library_universal_swiss_tool_plugin"
            binaryMessenger:[registrar messenger]];
  FlutterLibraryUniversalSwissToolPlugin* instance = [[FlutterLibraryUniversalSwissToolPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
