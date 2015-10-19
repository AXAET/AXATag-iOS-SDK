# AXATag-iOS-SDK
1.Create a singleton object [AXATagManager sharedManager]
2.Detecting Bluetooth is turned on, you need to register notice  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(discoverNotify:) name:bKey_Device_Ble_On object:nil];
3.Search for Bluetooth devices   [[AXATagManager sharedManager] startFindBleDevices];
4.Connecting a Bluetooth device   [[AXATagManager sharedManager] connectBleDevice:peripheral];
5.Connection callback notification registration required  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(discoverNotify:) name:bKey_Device_Connect object:nil];
Other times have to be registered notice


    The SDK adds ios9 of bitcode, support system and more systems ios 7