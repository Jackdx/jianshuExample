//
//  ELImageVideoScheduler.h
//  liveDemo
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 changba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELImageVideoScheduler : NSObject

/**
 *  默认开启自动对比度
 */
- (instancetype) initWithFrame:(CGRect) bounds videoFrameRate:(int)frameRate;
- (instancetype) initWithFrame:(CGRect) bounds videoFrameRate:(int)frameRate disableAutoContrast:(BOOL)disableAutoContrast;
- (UIView*) previewView;

- (void) startPreview;

- (void) stopPreview;

- (int) switchFrontBackCamera;

@end
