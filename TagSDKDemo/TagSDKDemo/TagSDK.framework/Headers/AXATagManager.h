//
//  AXATagManager.h
//  TagSDKDemo
//
//  Created by AXAET_APPLE on 15/7/17.
//  Copyright (c) 2015年 axaet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef enum : NSUInteger {
    // find device or mute device
    SentMessageTypeSoundOrMute,
    // turn off device
    SentMessageTypeTurnOff
} SentMessageType;

//typedef enum : NSUInteger {
//    ReceiveMassageTypeSinglePress,
//    ReceiveMassageTypeDoublePress,
//    ReceiveMassageTypeLongPress,
//} ReceiveMassageType;

@interface AXATagManager : NSObject
@property (nonatomic, strong) CBPeripheral *activePeripheral;
@property (nonatomic) int batteryLevel;
@property (nonatomic) float temperatureLevel;
@property (nonatomic) float humidityLevel;
@property (nonatomic, strong) NSNumber *rssi;

+(AXATagManager *) sharedManager;

// scan devices
- (void)startFindBleDevices;
// stop devices
- (void)stopFindBleDevices;

// connect device
- (void)connectBleDevice:(CBPeripheral *)peripheral;
// disconnect device
- (void)disconnectBleDevice:(CBPeripheral *)peripheral;

// get peripherals by identifiers
- (NSArray<CBPeripheral *> *)retrievePeripheralsWithIdentifiers:(NSArray<NSUUID *> *)identifiers;

// get connected peripherals by identifiers
- (NSArray<CBPeripheral *> *)retrieveConnectedPeripherals;

// find me or mute or turn off device
- (void)sendControlCommand:(SentMessageType)type toPeripheral:(CBPeripheral *)peripheral;

//Each method is called once, it sends a notification about Rssi, the interval of not less than 1.5s
- (void)readRssiForPeripheral:(CBPeripheral *)peripheral;

@end
