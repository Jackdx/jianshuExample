//
//  BeCentraliewController.h
//  BleDemo
//
//  Created by ZTELiuyw on 15/9/7.
//  Copyright (c) 2015年 liuyanwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BeCentralVewController : UIViewController

-(void)writeCharacteristic:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value;
-(void)notifyCharacteristic:(CBPeripheral *)peripheral
             characteristic:(CBCharacteristic *)characteristic;
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
                   characteristic:(CBCharacteristic *)characteristic;
-(void)writeCharacteristic:(CBPeripheral *)peripheral value:(NSData *)data forDescriptor:(CBDescriptor *)descriptor;
@end
