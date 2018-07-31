//
//  ViewController.m
//  FFmpegDecoder
//
//  Created by apple on 2017/2/8.
//  Copyright © 2017年 xiaokai.zhan. All rights reserved.
//

#import "ViewController.h"
#import "accompany_decoder_controller.h"
#import "CommonUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)decode:(id)sender {
    NSLog(@"decode Test...");
    //由于我们在iOS平台编译的ffmpeg 没有打开mp3的decoder开关，但是打开了aac的 所以这里使用aac来做测试
    // 本demo并没有提供视频文件，所以只针对处理了音频，未处理视频(这是跟书里面不同的地方)
    const char* mp3FilePath = [[CommonUtil bundlePath:@"131.aac"] cStringUsingEncoding:NSUTF8StringEncoding];
    const char *pcmFilePath = [[CommonUtil documentsPath:@"131.pcm"] cStringUsingEncoding:NSUTF8StringEncoding];
    AccompanyDecoderController* decoderController = new AccompanyDecoderController();
    decoderController->Init(mp3FilePath, pcmFilePath);
    decoderController->Decode();
    decoderController->Destroy();
    delete decoderController;
    NSLog(@"After decode Test...");
}

@end
