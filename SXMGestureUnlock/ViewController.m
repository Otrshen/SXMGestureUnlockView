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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    SXMGestureUnlockView *view = [[SXMGestureUnlockView alloc] initWithFrame:CGRectMake(0, 180, 320, 320)];
//    view.delegate = self;
////    view.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:view];
    
    
    self.lockView.delegate = self;
//    self.lockView.lineWidth = 2;
    self.lockView.linColor = [UIColor orangeColor];
    
    _indicator = [[SXMGestureUnlockIndicator alloc] initWithFrame:CGRectMake(100, 40, 80, 80)];
    [self.view addSubview:_indicator];
}

- (void)gestureUnlockView:(SXMGestureUnlockView *)gestureUnlockView gesturePassword:(NSString *)gesturePassword
{
    NSLog(@"gesturePassword:%@", gesturePassword);
    [_indicator setGesturesPassword:gesturePassword];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
