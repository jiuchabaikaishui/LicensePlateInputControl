//
//  LicensePlateInputView.m
//  LicensePlateInputControl
//
//  Created by 綦 on 16/6/14.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "LicensePlateInputView.h"
#import "LicensePlateKeyboard.h"

//需输入多少个字符
#define LicensePlateNumber_Count            7
//文字颜色
#define Text_Color                          [UIColor blackColor]
//文字字体
#define Text_Font                           [UIFont systemFontOfSize:14]

@interface LicensePlateInputView ()<LicensePlateKeyboardDelegate>

/**
 *  按钮数组
 */
@property (strong, nonatomic) NSMutableArray *buttons;
/**
 *  选中的按钮
 */
@property (weak, nonatomic) UIButton *selectButton;
/**
 *  键盘
 */
@property (strong, nonatomic) LicensePlateKeyboard *keyboard;
/**
 *  输入的文字数组
 */
@property (strong, nonatomic) NSMutableArray *textArr;

@end

@implementation LicensePlateInputView

#pragma mark - 属性方法
- (BOOL)isShow
{
    return self.keyboard.show;
}
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
        _keyboard.delegate = self;
    }
    
    return _keyboard;
}
- (NSMutableArray *)textArr
{
    if (_textArr == nil) {
        _textArr = [NSMutableArray arrayWithCapacity:1];
        for (int index = 0; index < self.buttons.count; index++) {
            [_textArr addObject:@""];
        }
    }
    
    return _textArr;
}
- (NSString *)textStr
{
    NSMutableString *mStr = [NSMutableString stringWithFormat:@""];
    for (id obj in self.textArr) {
        [mStr appendString:obj];
    }
    
    return mStr;
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
    
    CGFloat W = (self.frame.size.width + (LicensePlateNumber_Count - 1)/2)/LicensePlateNumber_Count;
    CGFloat H = self.frame.size.height;
    CGFloat Y = 0;
    CGRect rect;
    for (int index = 0; index < self.buttons.count; index++) {
        CGFloat X = index*(W - 0.5);
        rect = CGRectMake(X, Y, W, H);
        UIButton *button = self.buttons[index];
        button.frame = rect;
    }
}

#pragma mark - 触摸点击方法
- (void)buttonTouchDownAction:(UIButton *)sender
{
    [self insertSubview:sender atIndex:self.subviews.count];
}
/**
 *  按钮点击方法
 */
- (void)buttonAction:(UIButton *)sender
{
    NSLog(@"%i:%s",(int)[self.buttons indexOfObject:sender], __FUNCTION__);
    if ([self isBlankString:self.textStr]) {
        self.selectButton = [self.buttons firstObject];
        self.selectButton.selected = YES;
        [self insertSubview:self.selectButton atIndex:self.subviews.count];
    }
    else
    {
        UIButton *button;
        for (NSInteger index = [self.buttons indexOfObject:sender]; index >= 0; index--) {
            button = self.buttons[index];
            if (![self isBlankString:[button currentTitle]]) {
                break;
            }
        }
        if (button == [self.buttons lastObject] || [self isBlankString:[button currentTitle]] || button == sender) {
        }
        else
        {
            NSInteger index = [self.buttons indexOfObject:button];
            button = self.buttons[index + 1];
        }
        if (self.selectButton && button.selected == NO) {
            self.selectButton.selected = NO;
            button.selected = YES;
            self.selectButton = button;
            [self insertSubview:self.selectButton atIndex:self.subviews.count];
        }
    }
    
    if ([self.buttons indexOfObject:self.selectButton] == 0) {
        self.keyboard.type = LicensePlateKeyboardTypeDefault;
    }
    else if ([self.buttons indexOfObject:self.selectButton] == 1)
    {
        self.keyboard.type = LicensePlateKeyboardTypeLetters;
    }
    else
    {
        self.keyboard.type = LicensePlateKeyboardTypeNumber;
    }
    if (!self.keyboard.show)
    {
        self.keyboard.show = YES;
    }
}

#pragma mark - 自定义方法
/**
 *  设置子控件
 */
- (void)settintSubViews
{
    for (int index = 0; index < LicensePlateNumber_Count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(buttonTouchDownAction:) forControlEvents:UIControlEventTouchDown];
        [button setBackgroundImage:[self imageWithName:@"LicensePlateButton_Normal" fromLeft:0.5 fromTop:0.5] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithName:@"LicensePlateButton_Select" fromLeft:0.5 fromTop:0.5] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[self imageWithName:@"LicensePlateButton_Select" fromLeft:0.5 fromTop:0.5] forState:UIControlStateSelected];
        [button setTitleColor:Text_Color forState:UIControlStateNormal];
        button.titleLabel.font = Text_Font;
        [self addSubview:button];
        [self.buttons addObject:button];
    }
}
/**
 *  不变形的拉伸图片
 *
 *  @param name 图片名称
 *
 *  @return 拉伸后的图片
 */
- (UIImage *)imageWithName:(NSString *)name
{
    return [self imageWithName:name fromLeft:0.5 fromTop:0.5];
}
- (UIImage *)imageWithName:(NSString *)name fromLeft:(float)left fromTop:(float)top
{
    UIImage *image = [UIImage imageNamed:name];
    CGFloat imageW = image.size.width*left;
    CGFloat imageH = image.size.height*top;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW)];
}
//判空
- (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
        return YES;
    
    if ([string isKindOfClass:[NSNull class]])
        return YES;
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
        return YES;
    return NO;
}
/**
 *  显示键盘
 */
- (void)showKeyboard
{
    if (!self.keyboard.show) {
        [self buttonAction:[self.buttons lastObject]];
    }
}
/**
 *  隐藏键盘
 */
- (void)hideKeyboard
{
    if (self.keyboard.show) {
        [self licensePlateKeyboardAfterOkButtonClicked:self.keyboard];
    }
}

#pragma mark - <LicensePlateKeyboardDelegate>代理方法
- (void)licensePlateKeyboardAfterEditButtonClicked:(LicensePlateKeyboard *)keyboard andStr:(NSString *)str
{
    [self.selectButton setTitle:str forState:UIControlStateNormal];
    [self.selectButton setTitle:str forState:UIControlStateSelected];
    NSInteger index = [self.buttons indexOfObject:self.selectButton];
    
    [self.textArr removeObjectAtIndex:index];
    [self.textArr insertObject:str atIndex:index];
    
    if (index < self.buttons.count - 1) {
        UIButton *button = self.buttons[index + 1];
        if ([self isBlankString:[button currentTitle]]) {
            self.selectButton.selected = NO;
            self.selectButton = button;
            self.selectButton.selected = YES;
            [self insertSubview:self.selectButton atIndex:self.subviews.count];
            if ([self.buttons indexOfObject:self.selectButton] == 0) {
                self.keyboard.type = LicensePlateKeyboardTypeDefault;
            }
            else if ([self.buttons indexOfObject:self.selectButton] == 1)
            {
                self.keyboard.type = LicensePlateKeyboardTypeLetters;
            }
            else
            {
                self.keyboard.type = LicensePlateKeyboardTypeNumber;
            }
        }
    }
    else
    {
        self.selectButton.selected = NO;
        self.keyboard.show = NO;
        NSLog(@"%@", self.textStr);
    }
    
    if ([self.delegate respondsToSelector:@selector(licensePlateInputViewAfterEditButtonClicked:andStr:)]) {
        [self.delegate licensePlateInputViewAfterEditButtonClicked:self andStr:str];
    }
}
- (void)licensePlateKeyboardAfterDeleteButtonClicked:(LicensePlateKeyboard *)keyboard
{
    NSString *str = @"";
    NSInteger index = [self.buttons indexOfObject:self.selectButton];
    if ([self isBlankString:[self.selectButton currentTitle]]) {
        if (index > 0) {
            UIButton *button = self.buttons[index - 1];
            self.selectButton.selected = NO;
            self.selectButton = button;
            self.selectButton.selected = YES;
            [self insertSubview:self.selectButton atIndex:self.subviews.count];
            if ([self.buttons indexOfObject:self.selectButton] == 0) {
                self.keyboard.type = LicensePlateKeyboardTypeDefault;
            }
            else if ([self.buttons indexOfObject:self.selectButton] == 1)
            {
                self.keyboard.type = LicensePlateKeyboardTypeLetters;
            }
            else
            {
                self.keyboard.type = LicensePlateKeyboardTypeNumber;
            }
        }
    }
    [self.selectButton setTitle:str forState:UIControlStateNormal];
    [self.selectButton setTitle:str forState:UIControlStateSelected];
    index = [self.buttons indexOfObject:self.selectButton];
    [self.textArr removeObjectAtIndex:index];
    [self.textArr insertObject:str atIndex:index];
    
    if ([self.delegate respondsToSelector:@selector(licensePlateInputViewAfterDeleteButtonClicked:)]) {
        [self.delegate licensePlateInputViewAfterDeleteButtonClicked:self];
    }
}
- (void)licensePlateKeyboardAfterOkButtonClicked:(LicensePlateKeyboard *)keyboard
{
    self.selectButton.selected = NO;
    NSLog(@"%@", self.textStr);
    
    if (keyboard.show) {
        keyboard.show = NO;
    }
    if ([self.delegate respondsToSelector:@selector(licensePlateInputViewAfterOkButtonClicked:)]) {
        [self.delegate licensePlateInputViewAfterOkButtonClicked:self];
    }
}
- (void)licensePlateKeyboardWillShow:(LicensePlateKeyboard *)keyboard
{
    if ([self.delegate respondsToSelector:@selector(licensePlateInputViewWillShow:)]) {
        [self.delegate licensePlateInputViewWillShow:self];
    }
}
- (void)licensePlateKeyboardEndShow:(LicensePlateKeyboard *)keyboard
{
    if ([self.delegate respondsToSelector:@selector(licensePlateInputViewEndShow:)]) {
        [self.delegate licensePlateInputViewEndShow:self];
    }
}
- (void)licensePlateKeyboardWillDismiss:(LicensePlateKeyboard *)keyboard
{
    if ([self.delegate respondsToSelector:@selector(licensePlateInputViewWillDismiss:)]) {
        [self.delegate licensePlateInputViewWillDismiss:self];
    }
}
- (void)licensePlateKeyboardEndDismiss:(LicensePlateKeyboard *)keyboard
{
    if ([self.delegate respondsToSelector:@selector(licensePlateInputViewEndDismiss:)]) {
        [self.delegate licensePlateInputViewEndDismiss:self];
    }
}

@end
