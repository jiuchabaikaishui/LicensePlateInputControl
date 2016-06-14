//
//  LicensePlateKeyboard.m
//  LicensePlateInputControl
//
//  Created by 綦 on 16/6/14.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "LicensePlateKeyboard.h"

#define Screen_Width                [UIScreen mainScreen].bounds.size.width
#define Screen_Height               [UIScreen mainScreen].bounds.size.height
#define Animation_Time              0.25

@interface LicensePlateKeyboard ()
@property (strong, nonatomic) NSArray *localArr;
@property (strong, nonatomic) NSArray *numberArr;
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
- (NSArray *)numberArr
{
    if (_numberArr == nil) {
        _numberArr = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P", @"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L", @"Z", @"X", @"C", @"V", @"B", @"N", @"M"];
    }
    
    return _numberArr;
}
- (void)setRect:(CGRect)rect
{
    _rect = rect;
    self.frame = rect;
}
- (void)setShow:(BOOL)show
{
    _show = show;
    if (show) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [UIView animateWithDuration:Animation_Time animations:^{
            self.transform = CGAffineTransformTranslate(self.transform, 0, -self.frame.size.height);
        }];
    }
    else
    {
        [UIView animateWithDuration:Animation_Time animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
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
        [self settingSubviews:LicensePlateKeyboardTypeDefault];
    }
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self settingSubviews:LicensePlateKeyboardTypeDefault];
    }
    
    return self;
}

#pragma mark - 触摸点击方法
- (void)okButtonAction:(UIButton *)sender
{
    self.show = NO;
}
- (void)buttonAction:(UIButton *)sender
{
    NSLog(@"%@", sender.currentTitle);
}
- (void)deleteButtonAction:(UIButton *)sender
{
    NSLog(@"%@", sender.currentTitle);
}

#pragma mark - 自定义方法
- (void)settingSubviews:(LicensePlateKeyboardType)type
{
    self.backgroundColor = [UIColor redColor];
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = Screen_Width;
    CGFloat H = 30;
    CGRect rect = CGRectMake(X, Y, W, H);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor cyanColor];
    [self addSubview:view];
    
    W = H*1.5;
    X = Screen_Width - W;
    rect = CGRectMake(X, Y, W, H);
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    okButton.frame = rect;
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
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
            [button setBackgroundImage:[self imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.layer.cornerRadius = 3;
            button.layer.masksToBounds = YES;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    else
    {
        
    }
    
    X = Screen_Width - W;
    rect = CGRectMake(X, Y, W, H);
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = rect;
    [deleteButton setTitle:@"✕" forState:UIControlStateNormal];
    [deleteButton setBackgroundImage:[self imageFromColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    deleteButton.layer.cornerRadius = 3;
    deleteButton.layer.masksToBounds = YES;
    [deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    
    X = 0;
    Y = Screen_Height;
    W = Screen_Width;
    H = button.frame.origin.y + button.frame.size.height + spacingV;
    rect = CGRectMake(X, Y, W, H);
    self.rect = rect;
}
- (int)column:(NSString *)str andType:(LicensePlateKeyboardType)type
{
    if (type == LicensePlateKeyboardTypeDefault) {
        int subscript = [self.localArr indexOfObject:str];
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
    
    return 0;
}
- (int)row:(NSString *)str andType:(LicensePlateKeyboardType)type
{
    if (type == LicensePlateKeyboardTypeDefault) {
        int subscript = [self.localArr indexOfObject:str];
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
    
    return 0;
}

- (UIImage *)imageFromColor:(UIColor *)color
{
    return [self imageFromColor:color andFram:CGSizeMake(1, 1)];
}
- (UIImage *)imageFromColor:(UIColor *)color andFram:(CGSize)size
{
    //CGRect rect = CGRectMake(0, 0, CGFLOAT_MIN + 1, CGFLOAT_MIN + 1);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, (CGRect){{0,0},size});
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
