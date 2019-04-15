#import "PrinterPlugin.h"
#import "ConnecterManager.h"

#define WeakSelf(type) __weak typeof(type) weak##type = type

@interface PrinterPlugin ()

@property(strong, nonatomic)FlutterBasicMessageChannel * messageChannel;
@property(nonatomic,strong)NSMutableDictionary *dicts;
@end


@implementation PrinterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel *channel =
    [FlutterMethodChannel methodChannelWithName:@"plugins.flutter.io/printer_method"
                                    binaryMessenger:[registrar messenger]];
    PrinterPlugin *instance =
    [[PrinterPlugin alloc] initWithRegistrar:registrar];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar>*)reg
{
    self = [super init];
    if (self) {
         _messageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"plugins.flutter.io/printer_message" binaryMessenger:[reg messenger]];
    }
    return self;
}




-(void)startScane {
    
    
    if (Manager.bleConnecter == nil) {
        [Manager didUpdateState:^(NSInteger state) {
            switch (state) {
                case CBCentralManagerStateUnsupported:
                    [self sendMessageWithType:@"state" data:@"The platform/hardware doesn't support Bluetooth Low Energy." code:0];
                    break;
                case CBCentralManagerStateUnauthorized:
                    [self sendMessageWithType:@"state" data:@"The app is not authorized to use Bluetooth Low Energy." code:0];
                    break;
                case CBCentralManagerStatePoweredOff:
                    [self sendMessageWithType:@"state" data:@"Bluetooth is currently powered off." code:0];
                    break;
                case CBCentralManagerStatePoweredOn:
                    [self sendMessageWithType:@"state" data:@"Bluetooth is currently powered on." code:0];
                    [self scan];
                    break;
                case CBCentralManagerStateUnknown:
                    [self sendMessageWithType:@"state" data:@"unKnown" code:0];
                default:
                    break;
            }
        }];
    } else {
        [self scan];
    }
}

-(void)scan{
    [Manager scanForPeripheralsWithServices:nil options:nil discover:^(CBPeripheral * _Nullable peripheral, NSDictionary<NSString *,id> * _Nullable advertisementData, NSNumber * _Nullable RSSI) {
        if (peripheral.name != nil) {
            NSUInteger oldCounts = [self.dicts count];
            [self.dicts setObject:peripheral forKey:peripheral.identifier.UUIDString];
            if (oldCounts < [self.dicts count]) {
                NSMutableArray *arr = [NSMutableArray array];
                for (NSString *key in   [self.dicts allKeys]){
                    CBPeripheral *peripheral = self.dicts[key];
                    [arr addObject:@{
                                     @"name":peripheral.name,
                                     @"uuid":peripheral.identifier.UUIDString,
                                     }];
                }
                if (arr.count>0) {
                    [self sendMessageWithType:@"data" data:arr code:0];
                }
                
            }
        }
    }];
}

-(void)sendMessageWithType:(NSString *)type data:(id)data code:(NSInteger)code{
    if (type == nil || data == nil ) {
        return;
    }
    [_messageChannel sendMessage:@{
                                   @"type":type,
                                   @"data":data,
                                   @"code":@(code)
                                   }];
}

-(void)resultWithType:(FlutterResult)result data:(id)data message:(NSString *)message code:(NSInteger)code{
    if (result == nil || data == nil || message==nil) {
        return;
    }
    result(@{
             @"message":message,
             @"data":data,
             @"code":@(code)
             });
    
}



-(void)connectDevice:(NSString *)uuid {
    CBPeripheral *target = nil;
    for (NSString *key in   [self.dicts allKeys]) {
        CBPeripheral *peripheral = self.dicts[key];
        if ([peripheral.identifier.UUIDString isEqualToString:uuid]) {
            target = peripheral;
            break;
        }
    }
    if (target) {
        [Manager connectPeripheral:target options:nil timeout:2 connectBlack:^(ConnectState state) {
            [self updateConnectState:state];
        }];
    }
}

-(void)updateConnectState:(ConnectState)state {
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (state) {
            case CONNECT_STATE_CONNECTING:
//                self.connState.text = @"连接状态：连接中....";
                [self sendMessageWithType:@"state" data:@"connecting..." code:0];

                break;
            case CONNECT_STATE_CONNECTED:
                [self sendMessageWithType:@"state" data:@"connected" code:0];

                break;
            case CONNECT_STATE_FAILT:
//                [SVProgressHUD showErrorWithStatus:@"连接失败"];
                [self sendMessageWithType:@"state" data:@"connect failt" code:0];
//                self.connState.text = @"连接状态：连接失败";
                break;
            case CONNECT_STATE_DISCONNECT:
                [self sendMessageWithType:@"state" data:@"disconnected" code:0];
                break;
            default:
                [self sendMessageWithType:@"state" data:@"timeout..." code:0];
                break;
        }
    });
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"connect" isEqualToString:call.method]) {
     NSString *uuid =  call.arguments;
      if (uuid) {
          [self connectDevice:uuid];
          [self resultWithType:result data:@{} message:@"" code:0];
      }else{
          [self resultWithType:result data:@{} message:@"参数非法" code:1];
      }
  } else if ([@"start" isEqualToString:call.method]) {
      [self startScane];
      [self resultWithType:result data:@{} message:@"" code:0];
  } else if([@"stop" isEqualToString:call.method]){
       [Manager stopScan];
      [self resultWithType:result data:@{} message:@"" code:0];
  }{
    result(FlutterMethodNotImplemented);
  }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"applicationWillTerminate:");
    [Manager close];
}

-(NSMutableDictionary *)dicts {
    if (!_dicts) {
        _dicts = [[NSMutableDictionary alloc]init];
    }
    return _dicts;
}

@end
