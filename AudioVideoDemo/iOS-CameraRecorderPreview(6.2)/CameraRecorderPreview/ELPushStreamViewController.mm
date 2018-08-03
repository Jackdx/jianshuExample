#import "ELPushStreamViewController.h"
#import "ELImageVideoScheduler.h"
#import "ELPushStreamConfigeration.h"

#define buttonWidth 200.0f

@interface ELPushStreamViewController ()
{
    ELImageVideoScheduler*          _videoScheduler;
    UIButton*                       _switchCameraBtn;
}
@end

@implementation ELPushStreamViewController

#pragma -mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect bounds = self.view.bounds;
    _videoScheduler = [[ELImageVideoScheduler alloc] initWithFrame:bounds videoFrameRate:kFrameRate];
    [self.view insertSubview:[_videoScheduler previewView] atIndex:0];
    [self addSwitchCameraBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_videoScheduler startPreview];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_videoScheduler stopPreview];
}

- (void) addSwitchCameraBtn
{
    _switchCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat screenWidth = self.view.bounds.size.width;
    CGFloat screenHeight = self.view.bounds.size.height;
    CGRect huge = CGRectMake((screenWidth - buttonWidth) / 2, screenHeight - buttonWidth - 30, buttonWidth, buttonWidth);
    [_switchCameraBtn setFrame:huge];
    [_switchCameraBtn setTitle:@"SwitchCamera" forState:UIControlStateNormal];
    [_switchCameraBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_switchCameraBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _switchCameraBtn.layer.cornerRadius = buttonWidth/2.0f;
    _switchCameraBtn.layer.borderWidth = 1.0f;
    _switchCameraBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [_switchCameraBtn addTarget:self action:@selector(OnStartStop:) forControlEvents:UIControlEventTouchUpInside];
    //按钮初始状态
    [_switchCameraBtn setSelected:NO];
    [self.view addSubview:_switchCameraBtn];
    [self.view bringSubviewToFront:_switchCameraBtn];
}

- (void)OnStartStop:(id)sender {
    if(_videoScheduler) {
        [_videoScheduler switchFrontBackCamera];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
