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
    view.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44);
    [self.view addSubview:view];
}

@end
