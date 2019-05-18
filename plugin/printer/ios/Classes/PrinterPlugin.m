#import "PrinterPlugin.h"
#import "ConnecterManager.h"
#import "TscCommand.h"

#define WeakSelf(type) __weak typeof(type) weak##type = type

@interface PrinterPlugin ()

@property(strong, nonatomic)FlutterBasicMessageChannel * messageChannel;
@property(nonatomic,strong)NSMutableDictionary *dicts;
@property(nonatomic,assign)NSInteger state;

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
                    [self sendMessageWithType:@"state" data:@"Bluetooth be not supported " code:1];
                    break;
                case CBCentralManagerStateUnauthorized:
                    [self sendMessageWithType:@"state" data:@"Bluetooth be not authorized " code:2];
                    break;
                case CBCentralManagerStatePoweredOff:
                    [self sendMessageWithType:@"state" data:@"Bluetooth powered off." code:3];
                    break;
                case CBCentralManagerStatePoweredOn:
                    [self sendMessageWithType:@"state" data:@"Bluetooth powered on." code:4];
                    [self scan];
                    break;
                case CBCentralManagerStateUnknown:
                    [self sendMessageWithType:@"state" data:@"unKnown" code:5];
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
                [self sendMessageWithType:@"state" data:@"connecting..." code:-1];
                self.state = CONNECT_STATE_CONNECTING;
                break;
            case CONNECT_STATE_CONNECTED:
                [self sendMessageWithType:@"state" data:@"connected" code:-2];
                self.state = CONNECT_STATE_CONNECTED;
                break;
            case CONNECT_STATE_FAILT:
//                [SVProgressHUD showErrorWithStatus:@"连接失败"];
                [self sendMessageWithType:@"state" data:@"connect failt" code:-3];
                self.state = CONNECT_STATE_FAILT;
//                self.connState.text = @"连接状态：连接失败";
                break;
            case CONNECT_STATE_DISCONNECT:
                [self sendMessageWithType:@"state" data:@"disconnected" code:-4];
                self.state = CONNECT_STATE_DISCONNECT;
                break;
            default:
                [self sendMessageWithType:@"state" data:@"timeout..." code:-5];
                break;
        }
    });
}


//{type: stk, data: {_id: 5c76591dd33ed7d8ff5adb66, part_no: AS11234AD, loc: SB01, desc: LH ARM AND BLADE ASY, uom: EA, unitCost: null, sap_qty: 22, tech_spec: null, imgs: [Instance of 'Img'], count: 1}
-(TscCommand *)printAllInfoLabel:( TscCommand *) command info:(NSDictionary *)info{
    [command addSize:75 :50];
    [command addGapWithM:2 withN:0];
    [command addQueryPrinterStatus:BATCH];
    [command addReference:0 :0];
    [command addTear:@"ON"];
    [command addCls];
    [command addBox:0: 20: 560: 390: 1];
    [command addBox:0: 20: 560: 150: 1];
    [command addBox:0: 20: 560: 270: 1];
    [command addBox:0: 270: 260: 390: 1];
    [command addBox:0: 270: 400: 390: 1];
    //TOP LEFT
   
    [command addTextwithX:5 withY:24 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText:@"STOCK NO."];
    
    [command addTextwithX:25 withY:48 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText:info[@"part_no_to_show"]];

    [command add1DBarcode:25 :86 :@"128"  :40 :0 :0 :3 :5 :info[@"part_no"]];
    
    // Middle

    [command addTextwithX:25 withY:179 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText:info[@"desc"]];
//    [command addTextwithX:25 withY:215 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText:@"CHILD SEAT TETHER BRACKET CHILD"];

    //BOTTOM LEFT
 
    [command addTextwithX:5 withY:274 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText:@"LOT NO."];

    [command addTextwithX:25 withY:298 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText:info[@"lot_to_show"]];

    
    [command add1DBarcode:25 :330 :@"128"  :50 :0 :0 :2 :4 :info[@"lot"]];
    
    //BOTTOM Middle

     [command addTextwithX:265 withY:274 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText:@"QTY"];

    [command addTextwithX:290 withY:320 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText:info[@"sap_qty"]];

    //BOTTOM RIGHT
  
    [command addTextwithX:405 withY:274 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText:@"LOCATION"];
    [command addTextwithX:435 withY:320 withFont:@"TSS24.BF2" withRotation:0 withXscal:1 withYscal:1 withText:info[@"loc_to_show"]];
  
    return command;
}


-(TscCommand *)printCountedLabel:( TscCommand *) command data:(NSData *)data{
    [command addSize:48 :80];
    [command addGapWithM:2 withN:0];
    [command addReference:0 :0];
    [command addTear:@"ON"];
    [command addQueryPrinterStatus:BATCH];
    [command addCls];
    [command addTextwithX:120 withY:60 withFont:@"TSS24.BF2"  withRotation:0 withXscal:2 withYscal:2 withText:@"COUNTED"];
    [command addBox:20: 378: 560: 380: 2];
    return command;
}

-(TscCommand *)printHoldLabel:( TscCommand *) command data:(NSData *)data{

    [command addSize:48 :80];
    [command addGapWithM:2 withN:0];
    [command addReference:0 :0];
    [command addTear:@"ON"];
    [command addQueryPrinterStatus:BATCH];
    [command addCls];
    [command addTextwithX:120 withY:160 withFont:@"TSS24.BF2"  withRotation:0 withXscal:4 withYscal:4 withText:@"HOLD"];
    return command;
}

-(TscCommand *)printStdLabel:( TscCommand *) command data:(NSData *)data{
    
    [command addSize:100 :300];
    [command addGapWithM:2 withN:0];
    [command addReference:0 :0];
    [command addTear:@"ON"];
    [command addQueryPrinterStatus:BATCH];
    [command addCls];
    
    [command addBitmapwithX:100 withY:30 withMode:0 withWidth:400 withImage:[UIImage imageWithData:data]];
//    [command addBitmapwithX:0 withY:0 withWidth:200 withHeight:100 withMode:0 withData:data];
    return command;
}
//[{id: null, cd: hold, name: HOLD, type: IMG, paper: , size: , printer: , desc: HOLD, imgs: [Instance of 'Img'], count: 0}, {id: null, cd: counted, name: COUNTED, type: IMG, paper: , size: , printer: , desc: COUNTED, imgs: [Instance of 'Img'], count: 0}, {id: null, cd: passed, name: QC PASSED, type: IMG, paper: , size: , printer: , desc: QC PASSED, imgs: [Instance of 'Img'], count: 0}]
-(void)print:(NSDictionary *)args{
    NSString *type = args[@"type"];
    if ([type isEqualToString:@"std"]) {
        for (NSDictionary *dic in args[@"data"]) {
            FlutterStandardTypedData *flutterData = dic[@"imageData"];
            NSData *data =  flutterData.data;
            TscCommand *comm = [[TscCommand alloc] init];
            int count = [dic[@"count"] intValue];
//            if([dic[@"cd"] isEqualToString:@"counted"]){
//               comm=  [self printCountedLabel:comm data:data];
//            }else if ([dic[@"cd"] isEqualToString:@"hold"]){
//               comm=  [self printHoldLabel:comm data:data];
//            }else if ([dic[@"cd"] isEqualToString:@"passed"]){
               comm=  [self printStdLabel:comm data:data] ;
//            }
            [comm addPrint:count :1];
            [Manager write:[comm getCommand]];
        }
    }else if ([type isEqualToString:@"stk"]){
        TscCommand *comm = [[TscCommand alloc] init];
        NSDictionary *dic = args[@"data"];
        int count = [dic[@"count"] intValue];
        comm    =  [self printAllInfoLabel:comm info:dic];
        [comm addPrint:count :1];
        [Manager write:[comm getCommand]];
    }
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"connect" isEqualToString:call.method]) {
      if (self.state == CONNECT_STATE_CONNECTING) {
          return [self resultWithType:result data:@{} message:@"正在连接中" code:1];
      }
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
  }else if([@"print" isEqualToString:call.method]){
//      [Manager write:[self printAllInfoLabel]];
//      [Manager write:[self printCountedLabel:1]];
       NSDictionary *args =  call.arguments;
      [self print:args];
      [self resultWithType:result data:@{} message:@"" code:0];
  }else{
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
