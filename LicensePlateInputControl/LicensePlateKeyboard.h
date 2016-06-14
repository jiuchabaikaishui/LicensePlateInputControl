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
    LicensePlateKeyboardTypeNumber = 1//数字或者字母
};
@interface LicensePlateKeyboard : UIView

@property (assign, nonatomic) LicensePlateKeyboardType type;
@property (assign, nonatomic) BOOL show;

@end
