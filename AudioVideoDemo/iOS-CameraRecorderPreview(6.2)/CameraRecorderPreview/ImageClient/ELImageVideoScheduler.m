//
//  ELImageVideoScheduler.m
//  liveDemo
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 changba. All rights reserved.
//

#import "ELImageVideoScheduler.h"
#import "ELImageVideoCamera.h"
#import "ELImageView.h"

#define ASYNC_CONTRAST_ENHANCE 1

@implementation ELImageVideoScheduler
{
    ELImageVideoCamera*                 _videoCamera;
    ELImageView*                        _previewView;
}

- (instancetype) initWithFrame:(CGRect) bounds videoFrameRate:(int)frameRate {
    self = [self initWithFrame:bounds videoFrameRate:frameRate disableAutoContrast:NO];
    if (self) {
        //
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect) bounds videoFrameRate:(int)frameRate disableAutoContrast:(BOOL)disableAutoContrast
{
    self = [super init];
    if (self) {
        _videoCamera = [[ELImageVideoCamera alloc] initWithFPS:frameRate];
        _previewView = [[ELImageView alloc] initWithFrame:bounds];
        [_videoCamera startCapture];
    }
    return self;
}

- (UIView*) previewView;
{
    return _previewView;
}
- (void) startPreview;
{
    [_videoCamera addTarget:_previewView];
}

- (void) stopPreview;
{
    [_videoCamera removeTarget:_previewView];
}

- (int) switchFrontBackCamera;
{
    return [_videoCamera switchFrontBackCamera];
}

@end
