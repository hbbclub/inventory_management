//
//  ConnecterManager.mwalkThrough:/Applications/Visual%20Studio%20Code.app/Contents/Resources/app/out/vs/workbench/contrib/welcome/page/browser/vs_code_welcome_page?%7B%22moduleId%22%3A%22vs%2Fworkbench%2Fcontrib%2Fwelcome%2Fpage%2Fbrowser%2Fvs_code_welcome_page%22%7D
//  GSDK
//
//  Created by 猿史森林 on 2018/6/21.
//  Copyright © 2018年 Smarnet. All rights reserved.
//

#import "ConnecterManager.h"

@interface ConnecterManager(){
    ConnectMethod currentConnMethod;
}
@end

@implementation ConnecterManager

static ConnecterManager *manager;
static dispatch_once_t once;

+(instancetype)sharedInstance {
    dispatch_once(&once, ^{
        manager = [[ConnecterManager alloc]init];
    });
    return manager;
}

/**
 *  方法说明：连接指定ip和端口号的网络设备
 *  @param ip 设备的ip地址
 *  @param port 设备端口号
 *  @param connectState 连接状态
 *  @param callback 读取数据接口
 */
-(void)connectIP:(NSString *)ip port:(int)port connectState:(void (^)(ConnectState state))connectState callback:(void (^)(NSData *))callback {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (_ethernetConnecter == nil) {
            currentConnMethod = ETHERNET;
            [self initConnecter:currentConnMethod];
        }
        [_ethernetConnecter connectIP:ip port:port connectState:connectState callback:callback];
    });
}

/**
 *  方法说明：扫描外设
 *  @param serviceUUIDs 需要发现外设的UUID，设置为nil则发现周围所有外设
 *  @param options  其它可选操作
 *  @param discover 发现的设备
 */
-(void)scanForPeripheralsWithServices:(nullable NSArray<CBUUID *> *)serviceUUIDs options:(nullable NSDictionary<NSString *, id> *)options discover:(void(^_Nullable)(CBPeripheral *_Nullable peripheral,NSDictionary<NSString *, id> *_Nullable advertisementData,NSNumber *_Nullable RSSI))discover{
    [_bleConnecter scanForPeripheralsWithServices:serviceUUIDs options:options discover:discover];
}

/**
 *  方法说明：更新蓝牙状态
 *  @param state 蓝牙状态
 */
-(void)didUpdateState:(void(^)(NSInteger state))state {
    if (_bleConnecter == nil) {
        currentConnMethod = BLUETOOTH;
        [self initConnecter:currentConnMethod];
    }
    [_bleConnecter didUpdateState:state];
}

-(void)initConnecter:(ConnectMethod)connectMethod {
    switch (connectMethod) {
        case BLUETOOTH:
            _bleConnecter = [BLEConnecter new];
            _connecter = _bleConnecter;
            break;
        case ETHERNET:
            _ethernetConnecter = [EthernetConnecter new];
            _connecter = _ethernetConnecter;
            break;
        default:
            break;
    }
}

/**
 *  方法说明：停止扫描
 */
-(void)stopScan {
    [_bleConnecter stopScan];
}

/**
 *  连接
 */
-(void)connectPeripheral:(CBPeripheral *)peripheral options:(nullable NSDictionary<NSString *,id> *)options timeout:(NSUInteger)timeout connectBlack:(void(^_Nullable)(ConnectState state)) connectState{
    [_bleConnecter connectPeripheral:peripheral options:options timeout:timeout connectBlack:connectState];
}

-(void)connectPeripheral:(CBPeripheral * _Nullable)peripheral options:(nullable NSDictionary<NSString *,id> *)options {
    [_bleConnecter connectPeripheral:peripheral options:options];
}

-(void)write:(NSData *_Nullable)data progress:(void(^_Nullable)(NSUInteger total,NSUInteger progress))progress receCallBack:(void (^_Nullable)(NSData *_Nullable))callBack {
    [_bleConnecter write:data progress:progress receCallBack:callBack];
}

-(void)write:(NSData *)data receCallBack:(void (^)(NSData *))callBack {
#ifdef DEBUG
    NSLog(@"[ConnecterManager] write:receCallBack:");
#endif
    _bleConnecter.writeProgress = nil;
    [_connecter write:data receCallBack:callBack];
}

-(void)write:(NSData *)data {
#ifdef DEBUG
    NSLog(@"[ConnecterManager] write:");
#endif
    _bleConnecter.writeProgress = nil;
    [_connecter write:data];
}

-(void)close {
    if (_connecter) {
        [_connecter close];
    }
    switch (currentConnMethod) {
        case BLUETOOTH:
            _bleConnecter = nil;
            break;
        case ETHERNET:
            _ethernetConnecter = nil;
            break;
    }
}

@end
