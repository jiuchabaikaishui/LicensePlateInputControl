//
//  LicensePlateInputView.m
//  LicensePlateInputControl
//
//  Created by 綦 on 16/6/14.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "LicensePlateInputView.h"
#import "LicensePlateKeyboard.h"

#define LicensePlateNumber_Count            7

@interface LicensePlateInputView ()

@property (strong, nonatomic) NSMutableArray *buttons;
@property (weak, nonatomic) UIButton *selectButton;
@property (strong, nonatomic) LicensePlateKeyboard *keyboard;

@end

@implementation LicensePlateInputView

#pragma mark - 属性方法
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _buttons;
}
- (LicensePlateKeyboard *)keyboard
{
    if (_keyboard == nil) {
        _keyboard = [[LicensePlateKeyboard alloc] init];
    }
    
    return _keyboard;
}

#pragma mark - 系统方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self settintSubViews];
    }
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self settintSubViews];
    }
    
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat W = self.frame.size.width/LicensePlateNumber_Count;
    CGFloat H = self.frame.size.height;
    CGFloat Y = 0;
    CGRect rect;
    for (int index = 0; index < self.buttons.count; index++) {
        CGFloat X = index*W;
        rect = CGRectMake(X, Y, W, H);
        UIButton *button = self.buttons[index];
        button.frame = rect;
    }
}

#pragma mark - 触摸点击方法
- (void)buttonAction:(UIButton *)sender
{
    NSLog(@"%i:%s",[self.buttons indexOfObject:sender], __FUNCTION__);
    if (self.selectButton && sender != self.selectButton) {
        self.selectButton.selected = NO;
    }
    sender.selected = YES;
    self.selectButton = sender;
    
    if (self.keyboard.show) {
        
    }
    else
    {
        self.keyboard.show = YES;
    }
}

#pragma mark - 自定义方法
- (void)settintSubViews
{
    for (int index = 0; index < LicensePlateNumber_Count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"LicensePlateButton_Normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"LicensePlateButton_Select"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"LicensePlateButton_Select"] forState:UIControlStateSelected];
        [self addSubview:button];
        [self.buttons addObject:button];
    }
}

@end
