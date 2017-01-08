//
//  PFProgressHUB.h
//  测试Demo
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFProgressHUB : UIView

+ (instancetype)shareInstance;

- (void)show;

- (void)showWithContent:(NSString *)content;

- (void)dismiss;

@end
