//
//  ShengXiaoTXTDetailViewController.m
//  ModelProduct
//
//  Created by apple on 16/2/29.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFShengXiaoTXTDetailViewController.h"
#import "PFXXPeiDuiViewController.h"

@interface PFShengXiaoTXTDetailViewController ()

@end

@implementation PFShengXiaoTXTDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([_str_type isEqualToString:@"0"]) {
        self.title=@"生肖传说";
    }else if ([_str_type isEqualToString:@"1"]) {
        self.title=@"生肖相对,六道轮回";
    }else if ([_str_type isEqualToString:@"2"]) {
        self.title=@"星座传说";
    }else
        self.title=@"星座NO.1";
}

- (void)initDataSource {
    
}

- (void)initSubViews {
    
    [self initLeftNavigationBarButtonWithImage:@"PF_back"];
    
//    if ([_str_type isEqualToString:@"1"] || [_str_type isEqualToString:@"3"] ) {
//        [self initRightNavigationBarButtonWithtTitle:@"配对"];
//        __weak PFShengXiaoTXTDetailViewController *weakself=self;
//        self.rightNavBarBlock=^{
//            PFXXPeiDuiViewController *peiduiVC=[[PFXXPeiDuiViewController alloc]init];
//        
//            if ([weakself.str_type isEqualToString:@"1"]) {
//                peiduiVC.str_type=@"0";
//            }
//            if ([weakself.str_type isEqualToString:@"3"]) {
//                peiduiVC.str_type=@"1";
//            }
//            
//            [weakself.navigationController pushViewController:peiduiVC animated:YES];
//        };
//    }
//    
    
    NSString *filePath;
    
    if ([_str_type isEqualToString:@"0"]) {
        filePath=[[NSBundle mainBundle]pathForResource:@"sheng_xiao_gu_shi" ofType:@"txt"];
    }else if ([_str_type isEqualToString:@"1"]) {
        filePath=[[NSBundle mainBundle]pathForResource:@"sheng_xiao_fen_zu" ofType:@"txt"];
    }else if ([_str_type isEqualToString:@"2"]) {
        filePath=[[NSBundle mainBundle]pathForResource:@"xing_zuo_gu_shi" ofType:@"txt"];
    }else
        filePath=[[NSBundle mainBundle]pathForResource:@"xing_zuo_di_yi" ofType:@"txt"];

    
    UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    textView.text=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    textView.font=kSYS_FONT(15);
    [self.view addSubview:textView];
    textView.editable=NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
