//
//  DXViewController.m
//  removeObserverDemo
//
//  Created by dengxiang on 2017/4/24.
//  Copyright © 2017年 DX. All rights reserved.
//

#import "DXViewController.h"

@interface DXViewController ()

@end

@implementation DXViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"---%@--dealloc",NSStringFromClass([self class]));
}

@end
