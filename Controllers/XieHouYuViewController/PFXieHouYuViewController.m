//
//  CaiYiCaiViewController.m
//  ModelProduct
//
//  Created by apple on 16/2/23.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFXieHouYuViewController.h"

@interface PFXieHouYuViewController ()

@property (nonatomic,strong)UILabel *lab_answer;
@property (nonatomic,strong)UITextView *lab_question;

@end

@implementation PFXieHouYuViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"歇后语";
    
    [self getDataFromRequest];
}
- (void)initDataSource {
    
}
- (void)initSubViews {
    [self initLeftNavigationBarButtonWithImage:@"PF_home"];
    
    _lab_question=[[UITextView alloc]initWithFrame:CGRectMake(20, 40, kSCREEN_WIDTH-40, 150)];
    [self.view addSubview:_lab_question];
    _lab_question.textAlignment=NSTextAlignmentCenter;
    _lab_question.font=kSYS_FONT(20);
    _lab_question.editable=NO;
    
    _lab_answer=[[UILabel alloc]initWithFrame:CGRectMake(20, 40+150, kSCREEN_WIDTH-40, kSCREEN_HEIGHT-190-50-64)];
    [self.view addSubview:_lab_answer];
    _lab_answer.textAlignment=NSTextAlignmentCenter;
    _lab_answer.numberOfLines=0;
    _lab_answer.hidden=YES;
    _lab_answer.font=kSYS_BOLDFONT(30);
    _lab_answer.textColor=[UIColor redColor];
    
    UIButton *btn_next=[[UIButton alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-44-64, 80, 44)];
    [self.view addSubview:btn_next];
    [btn_next setTitle:@"下一题" forState:UIControlStateNormal];
    [btn_next addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [btn_next setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    UIButton *btn_answer=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-80, kSCREEN_HEIGHT-44-64, 80, 44)];
    [self.view addSubview:btn_answer];
    [btn_answer setTitle:@"答案" forState:UIControlStateNormal];
    [btn_answer addTarget:self action:@selector(answerAction) forControlEvents:UIControlEventTouchUpInside];
    [btn_answer setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

}



//下一题
- (void)nextAction {
    [self getDataFromRequest];
}

//显示答案
- (void)answerAction {
    self.lab_answer.hidden=NO;
}


- (void)getDataFromRequest {
    
    _lab_answer.hidden=YES;
    
    NSDictionary * diction=@{@"key":xie_hou_yu_key};
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:xie_hou_yu_DTAPI params:diction isHeader:NO LoadingBolck:^{
        [[PFProgressHUB shareInstance] show];
        
    } SuccessBlock:^(NSDictionary *respose) {
        [self performSelectorOnMainThread:@selector(getData:) withObject:respose waitUntilDone:YES];
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        [[PFProgressHUB shareInstance] dismiss];
    }];
}

- (void)getData:(NSDictionary *)rootDic {
    
    /*
     {
     "result": {
     "question": "图书馆的耗子",
     "answer": "蚀（食）本",
     "zimu": "T"
     },
     "error_code": 0,
     "reason": "Succes"
     }     */
    
    [[PFProgressHUB shareInstance] dismiss];

    
    if ([kFormatterSring([rootDic objectForKey:@"error_code"]) isEqualToString:@"0"]) {
        NSDictionary *result=[rootDic objectForKey:@"result"];
        
        _lab_question.text=[result objectForKey:@"question"];
        _lab_answer.text=[result objectForKey:@"answer"];

    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
