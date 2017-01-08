//
//  BaseNavigationController.m
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBarTintColor:[UIColor redColor]];
    self.navigationBar.translucent=NO;
    self.navigationBar.tintColor=[UIColor redColor];
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:kSYS_FONT(20),NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
