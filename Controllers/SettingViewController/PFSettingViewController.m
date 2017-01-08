//
//  PFSettingViewController.m
//  ModelProduct
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFSettingViewController.h"

@implementation PFSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    
}
- (void)initDataSource {
    [self initLeftNavigationBarButtonWithImage:@"PF_home"];

}
- (void)initSubViews {
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10, kSCREEN_HEIGHT-54-64, kSCREEN_WIDTH-20, 44)];
    [self.view addSubview:button];
    [button setTitle:@"清理缓存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clearCache) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.layer.cornerRadius=5;
    button.layer.masksToBounds=YES;
}


- (void)clearCache {
    
    [[PFProgressHUB shareInstance] showWithContent:@"正在清理缓存数据..."];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[PFProgressHUB shareInstance] showWithContent:@"缓存清理完成"];
        });
        
    });
    
}


@end
