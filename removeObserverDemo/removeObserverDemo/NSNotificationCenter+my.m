//
//  NSNotificationCenter+my.m
//  removeObserverDemo
//
//  Created by dengxiang on 2017/4/24.
//  Copyright © 2017年 DX. All rights reserved.
//

#import "NSNotificationCenter+my.h"
#import <objc/message.h>

@implementation NSNotificationCenter (my)

+ (void)load {
   
    // 获取removeObserver:方法的地址
    Method method = class_getInstanceMethod(self, @selector(removeObserver:));
    
    // 获取my_removeObserver:方法的地址
    Method myMethod = class_getInstanceMethod(self, @selector(my_removeObserver:));
    
    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(method, myMethod);
    
}
- (void)my_removeObserver:(id)observer
{
    [self my_removeObserver:observer];
    NSLog(@"--my_removeObserver-");
}

@end
