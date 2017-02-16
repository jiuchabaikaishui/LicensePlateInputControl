//
//  LicensePlateKeyboard.m
//  LicensePlateInputControl
//
//  Created by 綦 on 16/6/14.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "LicensePlateKeyboard.h"

//屏幕宽
#define Screen_Width                [UIScreen mainScreen].bounds.size.width
//屏幕高
#define Screen_Height               [UIScreen mainScreen].bounds.size.height
//键盘动画时间
#define Animation_Time              0.25
//按钮字体
#define Button_Font                 [UIFont systemFontOfSize:14]
//按钮圆角
#define Button_CornerRadius         3
//亮按钮颜色
#define Button_LightColor           [UIColor whiteColor]
//暗按钮颜色
#define Button_DarkColor            [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]
//按钮标题颜色
#define Button_TitleColor           [UIColor blackColor]
//背景颜色
#define Background_Color            [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]
//工具栏颜色
#define ToolBackground_Color        [UIColor whiteColor]

@interface LicensePlateKeyboard ()
@property (strong, nonatomic) NSArray *localArr;
@property (strong, nonatomic) NSArray *lettersArr;
@property (strong, nonatomic) NSArray *numberArr;
@property (strong, nonatomic) NSMutableArray *localButtons;
@property (strong, nonatomic) NSMutableArray *letterButtons;
@property (strong, nonatomic) NSMutableArray *numberButtons;
@property (assign, nonatomic) CGRect rect;

@end

@implementation LicensePlateKeyboard

#pragma mark - 属性方法
- (NSArray *)localArr
{
    if (_localArr == nil) {
        _localArr = @[@"京", @"津", @"沪", @"渝", @"蒙", @"新", @"藏", @"宁", @"桂", @"贵", @"云", @"黑", @"吉", @"辽", @"晋", @"冀", @"青", @"鲁", @"豫", @"苏", @"皖", @"浙", @"闽", @"赣", @"湘", @"鄂", @"粤", @"琼", @"甘", @"陕", @"川", @"港", @"澳"];
    }
    
    return _localArr;
}
- (NSArray *)lettersArr
{
    if (_lettersArr == nil) {
        _lettersArr = @[@"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P", @"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L", @"Z", @"X", @"C", @"V", @"B", @"N", @"M"];
    }
    
    return _lettersArr;
}
- (NSArray *)numberArr
{
    if (_numberArr == nil) {
        _numberArr = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P", @"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L", @"Z", @"X", @"C", @"V", @"B", @"N", @"M"];
    }
    
    return _numberArr;
}
- (NSMutableArray *)localButtons
{
    if (_localButtons == nil) {
        _localButtons = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _localButtons;
}
- (NSMutableArray *)letterButtons
{
    if (_letterButtons == nil) {
        _letterButtons = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _letterButtons;
}
- (NSMutableArray *)numberButtons
{
    if (_numberButtons == nil) {
        _numberButtons = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _numberButtons;
}
- (void)setType:(LicensePlateKeyboardType)type
{
    if (_type != type) {
        _type = type;
        [self settingSubviews:type];
    }
}
- (void)setShow:(BOOL)show
{
    [self settingSubviews:self.type];
    if (show) {
        if (_show != show) {
            if ([self.delegate respondsToSelector:@selector(licensePlateKeyboardWillShow:)]) {
                [self.delegate licensePlateKeyboardWillShow:self];
            }
            self.frame = CGRectZero;
            [[UIApplication sharedApplication].keyWindow addSubview:self];
            [UIView animateWithDuration:Animation_Time animations:^{
                self.transform = CGAffineTransformTranslate(self.transform, 0, -self.frame.size.height);
            } completion:^(BOOL finished) {
                if ([self.delegate respondsToSelector:@selector(licensePlateKeyboardEndShow:)]) {
                    [self.delegate licensePlateKeyboardEndShow:self];
                }
            }];
        }
    }
    else
    {
        if (_show != show) {
            if ([self.delegate respondsToSelector:@selector(licensePlateKeyboardWillDismiss:)]) {
                [self.delegate licensePlateKeyboardWillDismiss:self];
            }
            [UIView animateWithDuration:Animation_Time animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                if ([self.delegate respondsToSelector:@selector(licensePlateKeyboardEndDismiss:)]) {
                    [self.delegate licensePlateKeyboardEndDismiss:self];
                }
            }];
        }
    }
    _show = show;
}

#pragma mark - 系统方法
- (void)setFrame:(CGRect)frame
{
    [super setFrame:self.rect];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    
    return self;
}

#pragma mark - 触摸点击方法
/**
 *  确定按钮点击方法
 */
- (void)okButtonAction:(UIButton *)sender
{
    if (self.show) {
        self.show = NO;
    }
    if ([self.delegate respondsToSelector:@selector(licensePlateKeyboardAfterOkButtonClicked:)]) {
        [self.delegate licensePlateKeyboardAfterOkButtonClicked:self];
    }
}
/**
 *  编辑按钮点击方法
 */
- (void)buttonAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(licensePlateKeyboardAfterEditButtonClicked:andStr:)]) {
        [self.delegate licensePlateKeyboardAfterEditButtonClicked:self andStr:[sender currentTitle]];
    }
}
/**
 *  删除按钮点击方法
 */
- (void)deleteButtonAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(licensePlateKeyboardAfterDeleteButtonClicked:)]) {
        [self.delegate licensePlateKeyboardAfterDeleteButtonClicked:self];
    }
}

#pragma mark - 自定义方法
/**
 *  设置子控件
 *
 *  @param type 类型
 */
- (void)settingSubviews:(LicensePlateKeyboardType)type
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.backgroundColor = Background_Color;
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = Screen_Width;
    CGFloat H = 30;
    CGRect rect = CGRectMake(X, Y, W, H);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = ToolBackground_Color;
    [self addSubview:view];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    W = H*1.5;
    X = Screen_Width - W;
    rect = CGRectMake(X, Y, W, H);
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    okButton.frame = rect;
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    okButton.titleLabel.font = Button_Font;
    [self addSubview:okButton];
    
    W = Screen_Width/11;
    H = W;
    CGFloat spacingH = W/9;
    CGFloat spacingV = 8;
    UIButton *button;
    NSString *str;
    int column;
    int row;
    if (type == LicensePlateKeyboardTypeDefault) {
        if (self.localButtons.count > 0) {
            for (UIButton *theButton in self.localButtons) {
                [self addSubview:theButton];
                button = theButton;
            }
        }
        else
        {
            for (int index = 0; index < self.localArr.count; index++) {
                str = self.localArr[index];
                column = [self column:self.localArr[index] andType:type];
                row = [self row:self.localArr[index] andType:type];
                switch (row) {
                    case 2:
                        X = (column + 1)*(W + spacingH);
                        break;
                    case 3:
                        X = (column + 2)*(W + spacingH);
                        break;
                        
                    default:
                        X = column*(W + spacingH);
                        break;
                }
                Y = okButton.frame.origin.y + okButton.frame.size.height + spacingV + row*(H + spacingV);
                rect = CGRectMake(X, Y, W, H);
                button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = rect;
                [button setTitle:str forState:UIControlStateNormal];
                [button setBackgroundImage:[self imageFromColor:Button_LightColor] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = Button_Font;
                button.layer.cornerRadius = Button_CornerRadius;
                button.layer.masksToBounds = YES;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                [self.localButtons addObject:button];
            }
        }
    }
    else if (type == LicensePlateKeyboardTypeLetters)
    {
        if (self.letterButtons.count > 0) {
            for (UIButton *theButton in self.letterButtons) {
                [self addSubview:theButton];
                button = theButton;
            }
        }
        else
        {
            for (int index = 0; index < self.lettersArr.count; index++) {
                str = self.lettersArr[index];
                column = [self column:self.lettersArr[index] andType:type];
                row = [self row:self.lettersArr[index] andType:type];
                switch (row) {
                    case 1:
                        X = W/2 + column*(W + spacingH);
                        break;
                    case 2:
                        X = (column + 1)*(W + spacingH);
                        break;
                        
                    default:
                        X = column*(W + spacingH);
                        break;
                }
                Y = okButton.frame.origin.y + okButton.frame.size.height + spacingV + (H + spacingV)/2 + row*(H + spacingV);
                rect = CGRectMake(X, Y, W, H);
                button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = rect;
                [button setTitle:str forState:UIControlStateNormal];
                [button setBackgroundImage:[self imageFromColor:Button_LightColor] forState:UIControlStateNormal];
                [button setTitleColor:Button_TitleColor forState:UIControlStateNormal];
                button.titleLabel.font = Button_Font;
                button.layer.cornerRadius = Button_CornerRadius;
                button.layer.masksToBounds = YES;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                [self.letterButtons addObject:button];
            }
        }
    }
    else
    {
        if (self.numberButtons.count > 0) {
            for (UIButton *theButton in self.numberButtons) {
                [self addSubview:theButton];
                button = theButton;
            }
        }
        else
        {
            for (int index = 0; index < self.numberArr.count; index++) {
                str = self.numberArr[index];
                column = [self column:self.numberArr[index] andType:type];
                row = [self row:self.numberArr[index] andType:type];
                switch (row) {
                    case 2:
                        X = W/2 + column*(W + spacingH);
                        break;
                    case 3:
                        X = (column + 1)*(W + spacingH);
                        break;
                        
                    default:
                        X = column*(W + spacingH);
                        break;
                }
                Y = okButton.frame.origin.y + okButton.frame.size.height + spacingV + row*(H + spacingV);
                rect = CGRectMake(X, Y, W, H);
                button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = rect;
                [button setTitle:str forState:UIControlStateNormal];
                if (row == 0) {
                    [button setBackgroundImage:[self imageFromColor:Button_DarkColor] forState:UIControlStateNormal];
                }
                else
                {
                    [button setBackgroundImage:[self imageFromColor:Button_LightColor] forState:UIControlStateNormal];
                }
                [button setTitleColor:Button_TitleColor forState:UIControlStateNormal];
                button.titleLabel.font = Button_Font;
                button.layer.cornerRadius = Button_CornerRadius;
                button.layer.masksToBounds = YES;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                [self.numberButtons addObject:button];
            }
        }
    }
    
    X = Screen_Width - W;
    Y = button.frame.origin.y;
    rect = CGRectMake(X, Y, W, H);
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = rect;
    [deleteButton setTitle:@"✕" forState:UIControlStateNormal];
    [deleteButton setBackgroundImage:[self imageFromColor:Button_DarkColor] forState:UIControlStateNormal];
    [deleteButton setTitleColor:Button_TitleColor forState:UIControlStateNormal];
    deleteButton.titleLabel.font = Button_Font;
    deleteButton.layer.cornerRadius = Button_CornerRadius;
    deleteButton.layer.masksToBounds = YES;
    [deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    
    X = 0;
    Y = Screen_Height;
    W = Screen_Width;
    if (type == LicensePlateKeyboardTypeLetters) {
        H = button.frame.origin.y + button.frame.size.height*1.5 + spacingV/2 + spacingV;
    }
    else
    {
        H = button.frame.origin.y + button.frame.size.height + spacingV;
    }
    rect = CGRectMake(X, Y, W, H);
    self.rect = rect;
}
/**
 *  计算列号
 *
 *  @param str  需计算的字符串
 *  @param type 类型
 *
 *  @return 列号
 */
- (int)column:(NSString *)str andType:(LicensePlateKeyboardType)type
{
    int subscript;
    if (type == LicensePlateKeyboardTypeDefault) {
        subscript = (int)[self.localArr indexOfObject:str];
        if (subscript < 10) {
            return subscript;
        }
        else if (subscript < 20)
        {
            return subscript - 10;
        }
        else if (subscript < 28)
        {
            return subscript - 20;
        }
        else
        {
            return subscript - 28;
        }
    }
    else if (type == LicensePlateKeyboardTypeLetters)
    {
        subscript = (int)[self.lettersArr indexOfObject:str];
        if (subscript < 10) {
            return subscript;
        }
        else if (subscript < 19)
        {
            return subscript - 10;
        }
        else
        {
            return subscript - 19;
        }
    }
    else
    {
        subscript = (int)[self.numberArr indexOfObject:str];
        if (subscript < 10) {
            return subscript;
        }
        else if (subscript < 20)
        {
            return subscript - 10;
        }
        else if (subscript < 29)
        {
            return subscript - 20;
        }
        else
        {
            return subscript - 29;
        }
    }
    
    return 0;
}
/**
 *  计算行号
 *
 *  @param str  需计算的字符串
 *  @param type 类型
 *
 *  @return 行号
 */
- (int)row:(NSString *)str andType:(LicensePlateKeyboardType)type
{
    int subscript;
    if (type == LicensePlateKeyboardTypeDefault) {
        subscript = (int)[self.localArr indexOfObject:str];
        if (subscript < 10) {
            return 0;
        }
        else if (subscript < 20)
        {
            return 1;
        }
        else if (subscript < 28)
        {
            return 2;
        }
        else
        {
            return 3;
        }
    }
    else if (type == LicensePlateKeyboardTypeLetters)
    {
        subscript = (int)[self.lettersArr indexOfObject:str];
        if (subscript < 10) {
            return 0;
        }
        else if (subscript < 19)
        {
            return 1;
        }
        else
        {
            return 2;
        }
    }
    else
    {
        subscript = (int)[self.numberArr indexOfObject:str];
        if (subscript < 10) {
            return 0;
        }
        else if (subscript < 20)
        {
            return 1;
        }
        else if (subscript < 29)
        {
            return 2;
        }
        else
        {
            return 3;
        }
    }
    
    return 0;
}
/**
 *  获取某颜色的图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
- (UIImage *)imageFromColor:(UIColor *)color
{
    return [self imageFromColor:color andFrame:CGSizeMake(1, 1)];
}
/**
 *  根据颜色和大小获取图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 图片
 */
- (UIImage *)imageFromColor:(UIColor *)color andFrame:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, (CGRect){{0,0},size});
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
