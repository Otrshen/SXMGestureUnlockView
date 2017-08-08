//
//  SXMGestureUnlockView.h
//  SXMGestureUnlock
//
//  Created by 申铭 on 2017/8/6.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SXMGestureUnlockView;

@protocol SXMGestureUnlockViewDelegate <NSObject>

- (void)gestureUnlockView:(SXMGestureUnlockView *)gestureUnlockView gesturePassword:(NSString *)gesturePassword;

@end

@interface SXMGestureUnlockView : UIView

@property (nonatomic, weak) id<SXMGestureUnlockViewDelegate> delegate;

/** 线条宽度 */
@property (nonatomic, assign) CGFloat lineWidth;
/** 线条颜色 */
@property (nonatomic, strong) UIColor *lineColor;


/**
 手势密码正确
 */
- (void)gesturePasswordCorrect;

/**
 手势密码不正确
 */
- (void)gesturePasswordIncorrect;

@end
