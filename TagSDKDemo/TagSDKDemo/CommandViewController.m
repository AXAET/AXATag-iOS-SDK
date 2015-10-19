//
//  CommandViewController.m
//  TagSDKDemo
//
//  Created by AXAET_APPLE on 15/7/20.
//  Copyright (c) 2015年 axaet. All rights reserved.
//

#import "CommandViewController.h"

@interface CommandViewController ()

@end

@implementation CommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressSoundBtn:(id)sender {
//    CBPeripheral* peripheral = [TagSelf retrievePeripheralWithUUIDString:self.tag.uuidString];
    NSArray<CBPeripheral *> * array = [TagSelf retrievePeripheralsWithIdentifiers:@[[CBUUID UUIDWithString:self.tag.uuidString]]];
    CBPeripheral *peripheral = array.lastObject;
    [TagSelf sendControlCommand:SentMessageTypeSoundOrMute toPeripheral:peripheral];
}
- (IBAction)pressMuteBtn:(id)sender {

}
- (IBAction)pressOffBtn:(id)sender {
//    CBPeripheral* peripheral = [TagSelf retrievePeripheralWithUUIDString:self.tag.uuidString];
    NSArray<CBPeripheral *> * array = [TagSelf retrievePeripheralsWithIdentifiers:@[[CBUUID UUIDWithString:self.tag.uuidString]]];
    CBPeripheral *peripheral = array.lastObject;
    [TagSelf sendControlCommand:SentMessageTypeTurnOff toPeripheral:peripheral];
}
- (IBAction)pressBatteryLevel:(id)sender {

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
