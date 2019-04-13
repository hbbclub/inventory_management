#import "PrinterPlugin.h"

@implementation PrinterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"printer_method"
            binaryMessenger:[registrar messenger]];
  PrinterPlugin* instance = [[PrinterPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  [self registerPostTimerWithRegistrar:registrar];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"printHello" isEqualToString:call.method]) {
    result(@{
        @"text":@"hello"
    });
  } else {
    result(FlutterMethodNotImplemented);
  }
}


+(void) registerPostTimerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar{
    FlutterBasicMessageChannel *channel = [FlutterBasicMessageChannel messageChannelWithName:@"printer_message" binaryMessenger:[registrar messenger]];

}




@end
