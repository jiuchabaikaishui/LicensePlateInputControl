//
//  LicensePlateInputView.h
//  LicensePlateInputControl
//
//  Created by 綦 on 16/6/14.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LicensePlateInputView;
@protocol LicensePlateInputViewDelegate <NSObject>

@optional
/**
 *  点击确定按钮后执行
 *
 *  @param keyboard 键盘
 */
- (void)licensePlateInputViewAfterOkButtonClicked:(LicensePlateInputView *)view;
/**
 *  点击编辑文字按钮后执行
 *
 *  @param keyboard 键盘
 *  @param str      按钮上的文字
 */
- (void)licensePlateInputViewAfterEditButtonClicked:(LicensePlateInputView *)view andStr:(NSString *)str;
/**
 *  点击删除按钮后执行
 *
 *  @param keyboard 键盘
 */
- (void)licensePlateInputViewAfterDeleteButtonClicked:(LicensePlateInputView *)view;
/**
 *  键盘将要显示时执行
 *
 *  @param keyboard 键盘
 */
- (void)licensePlateInputViewWillShow:(LicensePlateInputView *)view;
/**
 *  键盘将要显示完成时执行
 *
 *  @param keyboard 键盘
 */
- (void)licensePlateInputViewEndShow:(LicensePlateInputView *)view;
/**
 *  键盘将要隐藏时执行
 *
 *  @param keyboard 键盘
 */
- (void)licensePlateInputViewWillDismiss:(LicensePlateInputView *)view;
/**
 *  键盘隐藏完成时执行
 *
 *  @param keyboard 键盘
 */
- (void)licensePlateInputViewEndDismiss:(LicensePlateInputView *)keyboard;

@end


@interface LicensePlateInputView : UIView

/**
 *  车牌文本字符串
 */
@property (copy, nonatomic, readonly) NSString *textStr;
/**
 *  键盘是否显示
 */
@property (assign, nonatomic, readonly, getter=isShow) BOOL show;
/**
 *  代理
 */
@property (weak, nonatomic)IBOutlet id<LicensePlateInputViewDelegate> delegate;

/**
 *  显示键盘
 */
- (void)showKeyboard;
/**
 *  隐藏键盘
 */
- (void)hideKeyboard;

@end
