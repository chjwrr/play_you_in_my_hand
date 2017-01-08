//
//  PFChengYuViewController.m
//  ModelProduct
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFChengYuDetailViewController.h"
#import "PFChengYuModel.h"

#define kPanRecognizerWidth     100

@interface PFChengYuDetailViewController ()

@property(nonatomic,strong) UITextView *content;
@property (nonatomic,strong)PFChengYuModel *contentModel;
@property(nonatomic,strong) UILabel *lab_title;

@property(nonatomic,strong) UILabel *lab_on_title;
@property(nonatomic,strong) UILabel *lab_last_title;


@end

@implementation PFChengYuDetailViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled=NO;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled=YES;
    
}

- (void)initDataSource {
    _contentModel=[[PFChengYuModel alloc]init];
}

- (void)initSubViews {
    
    UIImageView *bgimageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [self.view addSubview:bgimageView];
    bgimageView.image=kImageName(@"PF_cheng_yu_bgimage.jpg");
    
    
    UIImageView *bgimageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, kSCREEN_HEIGHT-44-10, 44, 44)];
    bgimageview.backgroundColor=[UIColor blackColor];
    bgimageview.alpha=0.5;
    [self.view addSubview:bgimageview];
    bgimageview.layer.masksToBounds=YES;
    bgimageview.layer.cornerRadius=3;
    
    UIButton *btn_back=[[UIButton alloc]initWithFrame:CGRectMake(10, kSCREEN_HEIGHT-44-10, 44, 44)];
    [self.view addSubview:btn_back];
    [btn_back setImage:kImageName(@"PF_back") forState:UIControlStateNormal];
    [btn_back addTarget:self action:@selector(backUpVCtrlAction) forControlEvents:UIControlEventTouchUpInside];

    
    
    CGFloat spaceHeight=0.0;
    if (iPhone4) {
        spaceHeight=90;
    }else if (iPhone5){
        spaceHeight=100;
    }else if (iPhone6){
        spaceHeight=120;
    }else if (iPhone6Plus){
        spaceHeight=140;
    }else
        spaceHeight=120;
    
    
    _lab_on_title=[[UILabel alloc]initWithFrame:CGRectMake(40, spaceHeight-40, 80, 20)];
    [self.view addSubview:_lab_on_title];
    _lab_on_title.font=kSYS_BOLDFONT(14);
    _lab_on_title.textColor=[UIColor redColor];
    
    
    _lab_last_title=[[UILabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-40-80, spaceHeight-40, 80, 20)];
    [self.view addSubview:_lab_last_title];
    _lab_last_title.font=kSYS_BOLDFONT(14);
    _lab_last_title.textAlignment=NSTextAlignmentRight;
    _lab_last_title.textColor=[UIColor redColor];

    
    
    _lab_title=[[UILabel alloc]initWithFrame:CGRectMake(0, spaceHeight, kSCREEN_WIDTH, 20)];
    [self.view addSubview:_lab_title];
    _lab_title.textAlignment=NSTextAlignmentCenter;
    _lab_title.font=kSYS_BOLDFONT(20);
    
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(40, _lab_title.y+_lab_title.height+10, kSCREEN_WIDTH-80, 1)];
    [self.view addSubview:line];
    line.backgroundColor=klineColor;
    
    _content=[[UITextView alloc]initWithFrame:CGRectMake(40, line.y+20, kSCREEN_WIDTH-80, kSCREEN_HEIGHT-(line.y+20)-spaceHeight)];
    [self.view addSubview:_content];
    _content.font=kSYS_FONT(17);
    _content.editable=NO;
    _content.textColor=[UIColor blackColor];
    _content.backgroundColor=[UIColor clearColor];
    
    UISwipeGestureRecognizer *swipeGestureleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureLeft:)];
    [self.view addGestureRecognizer:swipeGestureleft];
    swipeGestureleft.direction=UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *swipeGestureright=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureRight:)];
    [self.view addGestureRecognizer:swipeGestureright];
    swipeGestureright.direction=UISwipeGestureRecognizerDirectionRight;

    
    [self getDetailDataFromRequest];
}

/**
 *  UITapGestureRecognizer
 *
 *  @param recognizer 点击屏幕触发事件
 */

- (void)tapRecognizer:(UITapGestureRecognizer *)recognizer {
}

//手势触发 向左轻扫 下一页
- (void)swipeGestureLeft:(UISwipeGestureRecognizer *)recognizer {
    if (self.selectItem == [self.dataSource count] - 1) {
        
    }else{
        self.selectItem++;
        [self getDetailDataFromRequest];
    }
    
}
//手势触发 向右轻扫 上一页
- (void)swipeGestureRight:(UISwipeGestureRecognizer *)recognizer {
    if (self.selectItem == 0) {
        
    }else{
        self.selectItem--;
        [self getDetailDataFromRequest];
    }
    
}

//HTTP  单个成语详细解释

- (void)getDetailDataFromRequest {
    
    PFChengYuModel *model=[_dataSource objectAtIndex:self.selectItem];
    
    NSDictionary * diction=@{@"key":cheng_yu_key,
                             @"id":model.str_ID};
    
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:jie_shi_cheng_yu_DTAPI params:diction isHeader:NO LoadingBolck:^{
          [[PFProgressHUB shareInstance] show];
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getDetailData:) withObject:respose waitUntilDone:YES];
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        [self endRefresh];
    }];
    
}
//单个成语详细解释

- (void)getDetailData:(NSDictionary *)rootDic {
    
    _contentModel=[_dataSource objectAtIndex:self.selectItem];
    
    if ([kFormatterSring([rootDic objectForKey:@"error_code"]) isEqualToString:@"0"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
        
        NSDictionary *result=[rootDic objectForKey:@"result"];
        
        NSString *string=[NSString stringWithFormat:@"读音:%@\n\n释义:%@",[result objectForKey:@"spell"],[result objectForKey:@"content"]];
        
        
        NSString *detailString=@"";
        
        NSString *derivation=@"";
        derivation=kFormatterSring([result objectForKey:@"derivation"]);
        if ([derivation isEmpty]) {
            derivation=@"";
        }
        
        
        NSString *samples=@"";
        samples=kFormatterSring([result objectForKey:@"samples"]);
        if ([samples isEmpty]) {
            samples=@"";
        }
        
        detailString=[NSString stringWithFormat:@"%@\n\n%@",derivation,samples];
        
        
        if ([detailString isEmpty]) {
        }else
            string=[NSString stringWithFormat:@"%@\n\n引:    %@",string,detailString];
        
        _contentModel.content=string;
        _contentModel.name=[result objectForKey:@"name"];
        
        [self loadData];
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"请求失败，请重试"];
    }
    
}

- (void)loadData {
    
    if (self.selectItem == 0) {
        _lab_on_title.text=@"";
        
    }else{
        PFChengYuModel *onModel=[_dataSource objectAtIndex:self.selectItem-1];
        _lab_on_title.text=onModel.name;
    }
    
    if (self.selectItem == self.dataSource.count-1) {
        _lab_last_title.text=@"";
    }else{
        PFChengYuModel *onModel=[_dataSource objectAtIndex:self.selectItem+1];
        _lab_last_title.text=onModel.name;
    }
    
    
    _lab_title.text=_contentModel.name;
    _content.text=_contentModel.content;
    
}

- (void)backUpVCtrlAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
