//
//  DeviceViewController.m
//  TagSDKDemo
//
//  Created by AXAET_APPLE on 15/7/18.
//  Copyright (c) 2015年 axaet. All rights reserved.
//

#import "DeviceViewController.h"
#import "CommandViewController.h"

@interface DeviceViewController ()
@property (nonatomic, strong) NSMutableArray *connectedDevices;
@property (nonatomic, strong) UIBarButtonItem *leftBarItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;

@end

@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.connectedDevices = [[NSMutableArray alloc] init];
//    self.leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(pressLeftBarItem)];
//    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disconnectNotify:) name:bKey_Device_Disconnect object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singlePressNotify:) name:bKey_Device_Single_Press object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doublePressNotify:) name:bKey_Device_Double_Press object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(longPressNotify:) name:bKey_Device_Long_Press object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryLevelNotify:) name:bKey_Device_Update_Battery_Level object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(temperatureNotify:) name:bKey_Device_Update_Temperature object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(humidityNotify:) name:bKey_Device_Update_Humidity object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rssiNotify:) name:bKey_Device_Update_RSSI object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%s", __func__);
//    [self.connectedDevices removeAllObjects];
    NSArray *array = [TagSelf retrieveConnectedPeripherals];
    
    //连接了新的设备
    for (CBPeripheral *peripheral in array) {
        BOOL isExist = NO;
        for (AXATag *temp in self.connectedDevices) {
            if ([temp.uuidString isEqualToString:peripheral.identifier.UUIDString]) {
                isExist = YES;
                break;
            }
        }
        
        if (isExist == NO) {
            AXATag *tag = [[AXATag alloc] init];
            tag.uuidString = peripheral.identifier.UUIDString;
            [self.connectedDevices addObject:tag];
        }
    }
    
   
    //断开了设备
    NSMutableArray *lostArray = [[NSMutableArray alloc] init];
    int indexSection = 0;
    int indexRow = 0;
    for (AXATag *temp in self.connectedDevices) {
        BOOL isExist = NO;
        for (CBPeripheral *peripheral in array) {
            indexRow++;
            if ([peripheral.identifier.UUIDString isEqualToString:temp.uuidString]) {
                isExist = YES;
                break;
            }
        }
        indexSection++;
        
        if (isExist == NO) {
            [lostArray addObject:temp];
        }
    }
    [self.connectedDevices removeObjectsInArray:lostArray];

    
    [self.tableView reloadData];
    self.navigationItem.title = [NSString stringWithFormat:@"device (%d)", (int)self.connectedDevices.count];
}

//- (void)pressLeftBarItem {
//    
//    [self.tableView reloadData];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.connectedDevices.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"device" forIndexPath:indexPath];
    
    AXATag *tag = [self.connectedDevices objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"battery: %d%%\ntemperature: %.1f\nhumidity: %.1f%%\nrssi:%@\npress type: %@", tag.batteryLevel, tag.temperatureLevel, tag.humidityLevel, tag.rssi, tag.pressType];
    cell.textLabel.numberOfLines = 5;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        AXATag *tag = self.connectedDevices[indexPath.row];
        CommandViewController *controller = (CommandViewController *)[segue destinationViewController];
        controller.tag = tag;
    }
}

#pragma mark - notify

- (void)disconnectNotify:(NSNotification *)notification {
    CBPeripheral *peripheral = notification.object;
    for (AXATag *temp in self.connectedDevices) {
        if ([temp.uuidString isEqualToString:peripheral.identifier.UUIDString]) {
            [self.connectedDevices removeObject:temp];
            [self.tableView reloadData];
            break;
        }
    }
    self.navigationItem.title = [NSString stringWithFormat:@"device (%d)", (int)self.connectedDevices.count];
}

- (void)singlePressNotify:(NSNotification *)notification {
    CBPeripheral *peripheral = notification.object;
    AXATag *tag = [self findAXATag:peripheral.identifier.UUIDString];
    tag.pressType = @"single press";
}

- (void)doublePressNotify:(NSNotification *)notification {
    CBPeripheral *peripheral = notification.object;
    AXATag *tag = [self findAXATag:peripheral.identifier.UUIDString];
    tag.pressType = @"double press";
}

- (void)longPressNotify:(NSNotification *)notification {
    CBPeripheral *peripheral = notification.object;
    AXATag *tag = [self findAXATag:peripheral.identifier.UUIDString];
    tag.pressType = @"long press";
}

- (void)batteryLevelNotify:(NSNotification *)notification {
    CBPeripheral *peripheral = notification.object;
    AXATag *tag = [self findAXATag:peripheral.identifier.UUIDString];
    tag.batteryLevel = TagSelf.batteryLevel;
    
    [self.tableView reloadData];
}

- (void)temperatureNotify:(NSNotification *)notification {
    CBPeripheral *peripheral = notification.object;
    AXATag *tag = [self findAXATag:peripheral.identifier.UUIDString];
    tag.temperatureLevel = TagSelf.temperatureLevel;
    
    [self.tableView reloadData];
}

- (void)humidityNotify:(NSNotification *)notification {
    CBPeripheral *peripheral = notification.object;
    AXATag *tag = [self findAXATag:peripheral.identifier.UUIDString];
    tag.humidityLevel = TagSelf.humidityLevel;
    [self.tableView reloadData];
}

- (void)rssiNotify:(NSNotification *)notification {
    CBPeripheral *peripheral = notification.object;
    AXATag *tag = [self findAXATag:peripheral.identifier.UUIDString];
    tag.rssi = TagSelf.rssi;
    [self.tableView reloadData];
}

- (AXATag *)findAXATag:(NSString *)uuidString {
    for (AXATag *temp in self.connectedDevices) {
        if ([temp.uuidString isEqual:uuidString]) {
            return temp;
        }
    }
    return nil;
}

@end
