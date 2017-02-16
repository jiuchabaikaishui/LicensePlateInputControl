//
//  ViewController.m
//  LicensePlateInputControl
//
//  Created by 綦 on 16/6/14.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "ViewController.h"
#import "LicensePlateInputView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LicensePlateInputView *view = [[LicensePlateInputView alloc] init];
    CGFloat screenWith = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = screenWith/7;
    view.frame = CGRectMake(0, 64 + H + 8, screenWith, H);
    [self.view addSubview:view];
}

@end
