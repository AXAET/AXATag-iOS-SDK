//
//  AXATagManager.h
//  TagSDKDemo
//
//  Created by AXAET_APPLE on 15/7/17.
//  Copyright (c) 2015年 axaet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef enum {
    SentMessageTypeNone,
    SentMessageTypeSoundOrMute,
    SentMessageTypeOff
} SentMessageType;

@interface AXATagManager : NSObject
@property (nonatomic, strong) CBPeripheral *activePeripheral;
@property (nonatomic) int batteryLevel;
@property (nonatomic) float temperatureLevel;
@property (nonatomic) float humidityLevel;
@property (nonatomic, strong) NSNumber *rssi;

+(AXATagManager *) sharedManager;

 
/*!
 *   scan ble with service
 */
- (void)startFindBleDevices;

// stop scan devices
- (void)stopFindBleDevices;
- (void)connectBleDevice:(CBPeripheral *)peripheral;
- (void)disconnectBleDevice:(CBPeripheral *)peripheral;

/*!
 *  @method retrievePeripheralsWithIdentifiers:
 *
 *  @param uuidString	NSString object.
 *
 *  @discussion     Attempts to retrieve the CBPeripheral object with the corresponding uuidString.
 *
 *	@return		CBPeripheral object.
 *
 */
- (CBPeripheral *)retrievePeripheralWithUUIDString:(NSString *)uuidString NS_AVAILABLE(NA, 7_0);

/*!
 *  @method retrieveConnectedPeripherals

 *	@return		A list of CBPeripheral objects.
 *
 */
- (NSArray *)retrieveConnectedPeripherals NS_AVAILABLE(NA, 7_0);

//send control conmmand
- (void)sendControlCommand:(SentMessageType)type toPeripheral:(CBPeripheral *)peripheral;


@end
