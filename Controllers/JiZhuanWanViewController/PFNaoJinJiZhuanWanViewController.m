//
//  PFNaoJinJiZhuanWanViewController.m
//  ModelProduct
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFNaoJinJiZhuanWanViewController.h"
@interface PFNaoJinJiZhuanWanViewController ()

@property (nonatomic,strong)UILabel *lab_answer;
@property (nonatomic,strong)UITextView *lab_question;

@end


@implementation PFNaoJinJiZhuanWanViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"脑筋急转弯";
    
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
    
    [[AFHTTPClickManager shareInstanceAPIStore] getRequestWithPath:nao_jin_ji_zhuan_wan_API params:nil isHeader:YES LoadingBolck:^{
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
     "code": 200,  //状态码
     "msg": "success", //状态消息
     "newslist": [
     {
     "id": "6",  //ID
     "quest": "两只狗赛跑，甲狗跑得快，乙狗跑得慢，跑到终点时，哪只狗出汗多?",  //问题
     "result": "狗不会出汗"  //答复
     }
     ]
     }     */
    
    [[PFProgressHUB shareInstance] dismiss];
    
    if ([kFormatterSring([rootDic objectForKey:@"code"]) isEqualToString:@"200"]) {
        NSArray *array=[rootDic objectForKey:@"newslist"];
        
        
        NSDictionary *result=[array objectAtIndex:0];

        _lab_question.text=[result objectForKey:@"quest"];
        _lab_answer.text=[result objectForKey:@"result"];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
