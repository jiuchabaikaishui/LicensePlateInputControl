//
//  LicensePlateKeyboard.h
//  LicensePlateInputControl
//
//  Created by 綦 on 16/6/14.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, LicensePlateKeyboardType){
    LicensePlateKeyboardTypeDefault = 0,//默认地区
    LicensePlateKeyboardTypeLetters = 1,//字母
    LicensePlateKeyboardTypeNumber = 2//数字或者字母
};

@class LicensePlateKeyboard;
/**
 *  车牌输入键盘代理
 */
@protocol LicensePlateKeyboardDelegate <NSObject>

@optional
/**
 *  点击确定按钮后执行
 *
 *  @param keyboard 键盘
 */
- (void)licensePlateKeyboardAfterOkButtonClicked:(LicensePlateKeyboard *)keyboard;
/**
 *  点击编辑文字按钮后执行
 *
 *  @param keyboard 键盘
 *  @param str      按钮上的文字
 */
- (void)licensePlateKeyboardAfterEditButtonClicked:(LicensePlateKeyboard *)keyboard andStr:(NSString *)str;
/**
 *  点击删除按钮后执行
 *
 *  @param keyboard 键盘
 */
- (void)licensePlateKeyboardAfterDeleteButtonClicked:(LicensePlateKeyboard *)keyboard;
/**
 *  键盘将要显示时执行
 *
 *  @param keyboard 键盘
 */
- (void)licensePlateKeyboardWillShow:(LicensePlateKeyboard *)keyboard;
/**
 *  键盘将要显示完成时执行
 *
 *  @param keyboard 键盘
 */
- (void)licensePlateKeyboardEndShow:(LicensePlateKeyboard *)keyboard;
/**
 *  键盘将要隐藏时执行
 *
 *  @param keyboard 键盘
 */
- (void)licensePlateKeyboardWillDismiss:(LicensePlateKeyboard *)keyboard;
/**
 *  键盘将要隐藏完成时执行
 *
 *  @param keyboard 键盘
 */
- (void)licensePlateKeyboardEndDismiss:(LicensePlateKeyboard *)keyboard;

@end


@interface LicensePlateKeyboard : UIView

/**
 *  类型
 */
@property (assign, nonatomic) LicensePlateKeyboardType type;
/**
 *  是否显示
 */
@property (assign, nonatomic) BOOL show;
/**
 *  代理
 */
@property (weak, nonatomic) id<LicensePlateKeyboardDelegate> delegate;

@end
