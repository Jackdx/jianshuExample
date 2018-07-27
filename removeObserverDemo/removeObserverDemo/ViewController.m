//
//  ViewController.m
//  removeObserverDemo
//
//  Created by dengxiang on 2017/4/24.
//  Copyright © 2017年 DX. All rights reserved.
//

#import "ViewController.h"
#import "DXViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    DXViewController *dxVc = [[DXViewController alloc] init];
    [self presentViewController:dxVc animated:YES completion:nil];
    
}

@end
