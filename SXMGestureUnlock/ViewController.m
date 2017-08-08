//
//  ViewController.m
//  SXMGestureUnlock
//
//  Created by 申铭 on 2017/8/6.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import "ViewController.h"
#import "SXMGestureUnlockView.h"
#import "SXMGestureUnlockIndicator.h"

@interface ViewController () <SXMGestureUnlockViewDelegate>
@property (nonatomic, strong) SXMGestureUnlockIndicator *indicator;
@property (weak, nonatomic) IBOutlet SXMGestureUnlockView *lockView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    SXMGestureUnlockView *view = [[SXMGestureUnlockView alloc] initWithFrame:CGRectMake(0, 180, 320, 320)];
//    view.delegate = self;
////    view.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:view];
    
    
    self.lockView.delegate = self;
    self.lockView.lineWidth = 3;
    self.lockView.lineColor = [UIColor blueColor];
    
    _indicator = [[SXMGestureUnlockIndicator alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 80) / 2, 80, 80, 80)];
    [self.view addSubview:_indicator];
}

- (void)gestureUnlockView:(SXMGestureUnlockView *)gestureUnlockView gesturePassword:(NSString *)gesturePassword
{
    NSLog(@"gesturePassword:%@", gesturePassword);
    
    if ([gesturePassword isEqualToString:@"01258"]) {
        [self.lockView gesturePasswordCorrect];
        self.tipLabel.text = @"手势密码正确";
        self.tipLabel.textColor = [UIColor blackColor];
    } else {
        [self.lockView gesturePasswordIncorrect];
        self.tipLabel.text = @"手势密码错误";
        self.tipLabel.textColor = [UIColor redColor];
    }
    [_indicator setGesturesPassword:@""];
    [_indicator setGesturesPassword:gesturePassword];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
