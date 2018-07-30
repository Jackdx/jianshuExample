//
//  BeCentraliewController.m
//  BleDemo
//
//  Created by ZTELiuyw on 15/9/7.
//  Copyright (c) 2015年 liuyanwei. All rights reserved.
//

#import "BeCentralVewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BeCentralVewController () <CBCentralManagerDelegate,CBPeripheralDelegate>{
    //系统蓝牙设备管理对象，可以把他理解为主设备，通过他，可以去扫描和链接外设
    CBCentralManager *_manager;
    //用于保存被发现设备
    NSMutableArray *_discoverPeripherals;
}

@end

@implementation BeCentralVewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /*
     设置主设备的委托,CBCentralManagerDelegate
     必须实现的：
     - (void)centralManagerDidUpdateState:(CBCentralManager *)central;//主设备状态改变的委托，在初始化CBCentralManager的适合会打开设备，只有当设备正确打开后才能使用
     其他选择实现的委托中比较重要的：
     - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI; //找到外设的委托
     - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接外设成功的委托
     - (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//外设连接失败的委托
     - (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//断开外设的委托
     */
    
    //初始化并设置委托和线程队列，最好一个线程的参数可以为nil，默认会就main线程
    // 1. 建立中心角色
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];

  //持有发现的设备,如果不持有设备会导致CBPeripheralDelegate方法不能正确回调
    _discoverPeripherals = [[NSMutableArray alloc]init];
}

// 2. 检测中央设备状态(CBCentralManagerDelegate的required方法) 【代理方法】
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            //开始扫描周围的外设
            /*
             第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
             - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
             */
            // 3. 发起扫描外设（scanForPeripheral）
            [central scanForPeripheralsWithServices:nil options:nil];
            
            break;
        default:
            break;
    }
    
}
// 4. 发现外设（didDiscoverPeripheral）【代理方法】
//扫描到设备会进入方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSLog(@"当扫描到设备:%@",peripheral.name);
    //接下连接我们的测试设备，如果你没有设备，可以下载一个app叫lightbule的app去模拟一个设备
    //这里自己去设置下连接规则，我设置的是P开头的设备
//    if ([peripheral.name hasPrefix:@"P"]){
        /*
         一个主设备最多能连7个外设，每个外设最多只能给一个主设备连接,连接成功，失败，断开会进入各自的委托
         - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接外设成功的委托
         - (void)centra`lManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//外设连接失败的委托
         - (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//断开外设的委托
         */
  
        //找到的设备必须持有它，否则CBCentralManager中也不会保存peripheral，那么CBPeripheralDelegate中的方法也不会被调用！！
        [_discoverPeripherals addObject:peripheral];
    // 5. 发起连接外设(connectPeripheral)
        [central connectPeripheral:peripheral options:nil];
//    }
}


//连接到Peripherals-失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
}

//Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    
}
//连接到Peripherals-成功
// 6. 连接外设成功(didConnectPeripheral)【代理方法】
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
    //设置的peripheral委托CBPeripheralDelegate
    //@interface ViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate>
    [peripheral setDelegate:self];
    //扫描外设Services，成功后会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    // 7. 设置外设代理，发起扫描服务(setDelegate, discoverServices)
    [peripheral discoverServices:nil];
    
}


//扫描到Services
// 8. 发现外设的服务(didDiscoverServices) 【代理方法】
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    //  NSLog(@">>>扫描到服务：%@",peripheral.services);
    if (error)
    {
        NSLog(@">>>Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    
    for (CBService *service in peripheral.services) {
        NSLog(@"%@",service.UUID);
        //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        // 9. 发起发现外设的服务的特征(discoverCharacteristics: forService)
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

//扫描到Characteristics
// 10. 发现外设的服务的特征（discoverCharacteristicsForService）【代理方法】
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error)
    {
        NSLog(@"error Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"service:%@ 的 Characteristic: %@",service.UUID,characteristic.UUID);
    }
    
    for (CBCharacteristic *characteristic in service.characteristics){
        {
            if (characteristic.properties & CBCharacteristicPropertyRead) {
                //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
                // 11. 发起读取特征值(readValueForCharacteristic)
                [peripheral readValueForCharacteristic:characteristic];
            }
            
        }
    }
    
    //搜索Characteristic的Descriptors，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    //  17. 发起发现特征的描述
    for (CBCharacteristic *characteristic in service.characteristics){
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
    }
}

//获取的charateristic的值
// 12. 发现特征值(didUpdateValueForCharacteristic) 【代理方法】
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //打印出characteristic的UUID和值
    //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
    NSLog(@"characteristic uuid:%@  value:%@",characteristic.UUID,characteristic.value);
}

//搜索到Characteristic的Descriptors
//  18. 发现特征的描述 【代理方法】
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    //打印出Characteristic和他的Descriptors
    NSLog(@"characteristic uuid:%@",characteristic.UUID);
    for (CBDescriptor *d in characteristic.descriptors) {
        // 19. 发起读取特征的描述值
        [peripheral readValueForDescriptor:d];
        NSLog(@"Descriptor uuid:%@",d.UUID);
    }
}
//获取到Descriptors的值
// 20. 更新特征的描述值【代理方法】
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    //打印出DescriptorsUUID 和value
    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    NSLog(@"characteristic uuid:%@  value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID],descriptor.value);
}
-(void)writeCharacteristic:(CBPeripheral *)peripheral value:(NSData *)data forDescriptor:(CBDescriptor *)descriptor
{
     // 21. 发起写入特征的描述值
    [peripheral writeValue:data forDescriptor:descriptor];
}

// 22. 写入特征的描述值【代理方法】
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error
{
    
}
//写数据
-(void)writeCharacteristic:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value{
    
    //打印出 characteristic 的权限，可以看到有很多种，这是一个NS_OPTIONS，就是可以同时用于好几个值，常见的有read，write，notify，indicate，知道这几个基本就够用了，前两个是读写权限，后两个都是通知，两种不同的通知方式。
    /*
     typedef NS_OPTIONS(NSUInteger, CBCharacteristicProperties) {
     CBCharacteristicPropertyBroadcast												= 0x01,
     CBCharacteristicPropertyRead													= 0x02,
     CBCharacteristicPropertyWriteWithoutResponse									= 0x04,
     CBCharacteristicPropertyWrite													= 0x08,
     CBCharacteristicPropertyNotify													= 0x10,
     CBCharacteristicPropertyIndicate												= 0x20,
     CBCharacteristicPropertyAuthenticatedSignedWrites								= 0x40,
     CBCharacteristicPropertyExtendedProperties										= 0x80,
     CBCharacteristicPropertyNotifyEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)		= 0x100,
     CBCharacteristicPropertyIndicateEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)	= 0x200
     };
     
     */
    NSLog(@"%lu", (unsigned long)characteristic.properties);
    //只有 characteristic.properties 有write的权限才可以写
    if(characteristic.properties & CBCharacteristicPropertyWrite){
        /*
         最好一个type参数可以为CBCharacteristicWriteWithResponse或type:CBCharacteristicWriteWithoutResponse,区别是是否会有反馈
         */
       // 13. 发起写入特征值(writeValue: forCharacteristic:)
        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    }else{
        NSLog(@"该字段不可写！");
    }
}

// 14. 写入特征值成功(didWriteValueForCharacteristic) 【代理方法】
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didWriteValueForCharacteristic");
}
//设置通知
-(void)notifyCharacteristic:(CBPeripheral *)peripheral
             characteristic:(CBCharacteristic *)characteristic{
    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    // 15. 发起设置或取消某个特征的监听通知(setNotifyValue: forCharacteristic:)
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    
}

//取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
                   characteristic:(CBCharacteristic *)characteristic{
    
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}

// 16. 监听某个特征的通知的状态变更 (didUpdateNotificationStateForCharacteristic) 【代理方法】
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    
}
//停止扫描并断开连接
// 23. 断开蓝牙连接
-(void)disconnectPeripheral:(CBCentralManager *)centralManager
                 peripheral:(CBPeripheral *)peripheral{
    //停止扫描
    [centralManager stopScan];
    //断开连接
    [centralManager cancelPeripheralConnection:peripheral];
}
@end
