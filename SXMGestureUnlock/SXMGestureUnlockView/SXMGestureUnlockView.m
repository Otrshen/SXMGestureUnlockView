//
//  SXMGestureUnlockView.m
//  SXMGestureUnlock
//
//  Created by 申铭 on 2017/8/6.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import "SXMGestureUnlockView.h"

@interface SXMGestureUnlockView ()
@property (nonatomic, strong) NSMutableArray *selectedBtns;
@property (nonatomic, assign) CGPoint currentPoint;
@end

@implementation SXMGestureUnlockView

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
    self.lineWidth = 8; // 线条默认宽度
    self.linColor = [UIColor blueColor]; // 线条默认颜色
    self.opaque = NO; // 默认不透明
    
    // 添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.userInteractionEnabled = NO;
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_selected"] forState:UIControlStateSelected];
        [self addSubview:btn];
    }
}

// 设置按钮的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = 58;
    CGFloat btnH = 58;
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

#pragma mark - 手势

- (void)pan:(UIPanGestureRecognizer *)pan {
    _currentPoint = [pan locationInView:self];

    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, _currentPoint) && btn.selected == NO) {
            btn.selected = YES;
            [self.selectedBtns addObject:btn];
        }
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        NSMutableString *pwd = [NSMutableString string];
        for (UIButton *btn in self.selectedBtns) {
            [pwd appendFormat:@"%ld", btn.tag];
            btn.selected = NO;
        }
        
        [self.selectedBtns removeAllObjects];
        self.currentPoint = CGPointZero;
        
        // 返回结果
        if ([_delegate respondsToSelector:@selector(gestureUnlockView:gesturePassword:)]) {
            [_delegate gestureUnlockView:self gesturePassword:pwd];
        }
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect); // 清空上下文,清理缓存
    
    [self.backgroundColor setFill]; // 设置背景颜色
    UIRectFill(rect);
    
    if (self.selectedBtns.count == 0) return;
    
    for (int i = 0; i < self.selectedBtns.count; i++) {
        UIButton *btn = self.selectedBtns[i];
        if (i == 0) {
            CGContextMoveToPoint(ctx, btn.center.x, btn.center.y);
        } else {
            CGContextAddLineToPoint(ctx, btn.center.x, btn.center.y);
        }
    }
    
    CGContextAddLineToPoint(ctx, self.currentPoint.x, self.currentPoint.y);
    
    [self.linColor set];
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextStrokePath(ctx);
}

- (NSMutableArray *)selectedBtns
{
    if (!_selectedBtns) {
        _selectedBtns = [NSMutableArray array];
    }
    return _selectedBtns;
}

@end
