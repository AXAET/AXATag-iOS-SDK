//
//  AXATagDefine.h
//  TagSDKDemo
//
//  Created by AXAET_APPLE on 15/7/17.
//  Copyright (c) 2015年 axaet. All rights reserved.
//

#ifndef TagSDKDemo_AXATagDefine_h
#define TagSDKDemo_AXATagDefine_h


#define LOG_METHOD NSLog(@"%s", __func__);

// we use notification to handel ble delegate

// phone bluetooth on or off
#define bKey_Device_Ble_On                      @"bKey_Device_Ble_On"
#define bKey_Device_Ble_Off                     @"bKey_Device_Ble_Off"

//when discover new ble device, the notification of this name will send
// notify object CBPeripheral
// notify username NSDictionary(@"rssi":rssi, @"advertisementData":advertisementData)
#define bKey_Device_Discover                    @"bKey_Device_Discover"

// when disconnected
// notify object CBPeripheral
#define bKey_Device_Disconnect                  @"bKey_Device_Disconnect"

// when connected
// notify object CBPeripheral
#define bKey_Device_Connect                     @"bKey_Device_Connect"

// have read battery level
// notify object CBPeripheral
#define bKey_Device_Update_Battery_Level        @"bKey_Device_Update_Battery_Level"

// have read temperature level
// notify object CBPeripheral
#define bKey_Device_Update_Temperature          @"bKey_Device_Update_Temperature"

// have read humidity level
// notify object CBPeripheral
#define bKey_Device_Update_Humidity             @"bKey_Device_Update_Humidity"

// press the ble device button once
// notify object CBPeripheral
#define bKey_Device_Single_Press               @"bKey_Device_Single_Press"

// double press(press twice quickly)
// notify object CBPeripheral
#define bKey_Device_Double_Press               @"bKey_Device_Double_Press"
//
// notify object CBPeripheral
#define bKey_Device_Long_Press                  @"bKey_Device_Long_Press"

// rssi has updated
// notify object CBPeripheral
#define bKey_Device_Update_RSSI                 @"bKey_Device_Update_RSSI"

////camera operation
//
#define cKey_Scale_Up                           @"cKey_Scale_Up"
#define cKey_Scale_Down                         @"cKey_Scale_Down"
#define cKey_Long_Scale_Up                      @"cKey_Long_Scale_Up"
#define cKey_Long_Scale_Down                    @"cKey_Long_Scale_Down"
#define cKey_Long_Press_Cancel                  @"cKey_Long_Press_Cancel"


#define kRSSI   @"RSSI"
#define kAdvertisementData      @"advertisementData"
#define TagSelf [AXATagManager sharedManager]


#endif
