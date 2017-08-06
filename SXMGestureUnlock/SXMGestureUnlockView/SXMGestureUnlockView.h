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

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *linColor;

@end
