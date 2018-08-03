//
//  ViewController.m
//  CameraRecorderPreview
//
//  Created by apple on 2017/2/16.
//  Copyright © 2017年 xiaokai.zhan. All rights reserved.
//

#import "ViewController.h"
#import "ELPushStreamViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)forwardPage:(id)sender {
    NSLog(@"forward To Page...");
    ELPushStreamViewController* viewController = [[ELPushStreamViewController alloc] init];
    [[self navigationController] pushViewController:viewController animated:YES];
}

@end
