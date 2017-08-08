//
//  SXMGestureUnlockIndicator.m
//  SXMGestureUnlock
//
//  Created by 申铭 on 2017/8/6.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import "SXMGestureUnlockIndicator.h"

@interface SXMGestureUnlockIndicator ()
@property (nonatomic, strong) NSMutableArray *btns;
@end

@implementation SXMGestureUnlockIndicator

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

// 创建9个button
- (void)setupUI
{
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_indicator_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_indicator_selected"] forState:UIControlStateSelected];
        [self addSubview:btn];
        
        [self.btns addObject:btn];
    }
}

// 设置按钮的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = 9;
    CGFloat btnH = 9;
    int clos = 3; // 总列数
    int col = 0;
    int row = 0;
    CGFloat margin = (self.frame.size.width - (clos * btnW)) / (clos + 1); // 间距
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        
        col = i % clos; // 列号
        row = i / clos; // 行号
        
        // 间距 + 列号 * (按钮宽度+ 间距)
        CGFloat btnX = margin + col * (btnW + margin);
        CGFloat btnY = margin + row * (btnW + margin);
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

- (void)setGesturesPassword:(NSString *)gesturesPassword {
    if (gesturesPassword.length == 0) {
        for (UIButton *btn in self.btns) {
            btn.selected = NO;
        }
        return;
    }
    
    for (int i = 0; i < gesturesPassword.length; i++) {
        NSString *p = [gesturesPassword substringWithRange:NSMakeRange(i, 1)];
        [self.btns[p.integerValue] setSelected:YES];
    }
}

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

@end
