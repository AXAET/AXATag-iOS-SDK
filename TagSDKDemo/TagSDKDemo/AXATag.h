//
//  AXATag.h
//  TagSDKDemo
//
//  Created by AXAET_APPLE on 15/7/18.
//  Copyright (c) 2015年 axaet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AXATag : NSObject
@property (nonatomic, strong) NSString *uuidString;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) int batteryLevel;
@property (nonatomic) float temperatureLevel;
@property (nonatomic) float humidityLevel;
@property (nonatomic, strong) NSNumber *rssi;
@property (nonatomic, strong) NSString *pressType;

@end
