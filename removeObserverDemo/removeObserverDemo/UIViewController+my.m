//
//  UIViewController+my.m
//  removeObserverDemo
//
//  Created by dengxiang on 2017/4/24.
//  Copyright © 2017年 DX. All rights reserved.
//

#import "UIViewController+my.h"
#import <objc/message.h>

@implementation UIViewController (my)

+ (void)load {
    
    // 获取dealloc方法的地址
    Method method = class_getInstanceMethod(self, @selector(dealloc));
    
    // 获取my_dealloc方法的地址
    Method myMethod = class_getInstanceMethod(self, @selector(my_dealloc));
    
    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(method, myMethod);
    
}
- (void)my_dealloc
{
    NSLog(@"--my_dealloc-");
    [self my_dealloc];
    NSLog(@"--my_dealloc代码的下一行-");
    
}

@end
