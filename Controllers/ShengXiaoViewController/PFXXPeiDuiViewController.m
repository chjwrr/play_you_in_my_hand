//
//  XXPeiDuiViewController.m
//  ModelProduct
//
//  Created by apple on 16/2/29.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFXXPeiDuiViewController.h"

#import "PFChooseItemView.h"

@interface PFXXPeiDuiViewController ()<PFChooseItemViewDelegate>{
    NSArray *sxtitles;
    NSArray *sximages;
    
    NSArray *xztitles;
    NSArray *xzimages;
    
    BOOL isLeft;
}

@property (nonatomic,strong)UIImageView *imgV_frome;
@property (nonatomic,strong)UIImageView *imgV_to;

@property (nonatomic,strong)UILabel *lab_frome;
@property (nonatomic,strong)UILabel *lab_to;

@property (nonatomic,strong)UITextView *textView;

@property (nonatomic,assign)NSInteger fromeIndex;
@property (nonatomic,assign)NSInteger toIndex;


@end

@implementation PFXXPeiDuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.str_type isEqualToString:@"0"]) {
        self.title=@"生肖配对";
    }else
        self.title=@"星座配对";
}

- (void)initDataSource {
    sxtitles=@[@"鼠",
             @"牛",
             @"虎",
             @"兔",
             @"龙",
             @"蛇",
             @"马",
             @"羊",
             @"猴",
             @"鸡",
             @"狗",
             @"猪"];
    
    sximages=@[@"sx_shu",
             @"sx_niu",
             @"sx_hu",
             @"sx_tu",
             @"sx_long",
             @"sx_she",
             @"sx_ma",
             @"sx_yang",
             @"sx_hou",
             @"sx_ji",
             @"sx_gou",
             @"sx_zhu"];

    
    xztitles=@[@"白羊座",
             @"金牛座",
             @"双子座",
             @"巨蟹座",
             @"狮子座",
             @"处女座",
             @"天秤座",
             @"天蝎座",
             @"射手座",
             @"摩羯座",
             @"水瓶座",
             @"双鱼座"];
    
    xzimages=@[@"xz_bai_yang",
             @"xz_jin_niu",
             @"xz_shuang_zi",
             @"xz_ju_xie",
             @"xz_shi_zi",
             @"xz_chu_nv",
             @"xz_tian_chen",
             @"xz_tian_xie",
             @"xz_she_shou",
             @"xz_mo_jie",
             @"xz_shui_ping",
             @"xz_shuang_yu"];
    
    
    
    _fromeIndex=7;
    _toIndex=8;

}

- (void)initSubViews {
    
    [self initLeftNavigationBarButtonWithImage:@"PF_back"];
    [self initRightNavigationBarButtonWithtTitle:@"配对"];
    
    __weak PFXXPeiDuiViewController *weakself=self;
    
    self.rightNavBarBlock=^{
        if ([weakself.str_type isEqualToString:@"0"]) {
            [weakself getSXDataFromRequest];
        }else
            [weakself getXZDataFromRequest];
    };
    
    
    _imgV_frome=[[UIImageView alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-300)/2, 20, 100, 100)];
    [self.view addSubview:_imgV_frome];
    
    _lab_frome=[[UILabel alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-300)/2, 120, 100, 30)];
    _lab_frome.textAlignment=NSTextAlignmentCenter;
    _lab_frome.textColor=[UIColor redColor];
    [self.view addSubview:_lab_frome];

    
    UIButton *button=[[UIButton alloc]initWithFrame:_imgV_frome.frame];
    [button addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(_imgV_frome.x+_imgV_frome.width, 20+100-20, 100, 20)];
    [self.view addSubview:lab];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.text=@"配";
    lab.textColor=[UIColor redColor];
    
    _imgV_to=[[UIImageView alloc]initWithFrame:CGRectMake(lab.x+lab.width, 20, 100, 100)];
    [self.view addSubview:_imgV_to];
  
    _lab_to=[[UILabel alloc]initWithFrame:CGRectMake(_imgV_to.x, 120, 100, 30)];
    _lab_to.textAlignment=NSTextAlignmentCenter;
    _lab_to.textColor=[UIColor redColor];
    [self.view addSubview:_lab_to];
    
    UIButton *button1=[[UIButton alloc]initWithFrame:_imgV_to.frame];
    [button1 addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(10, _lab_to.y+_lab_to.height+20, kSCREEN_WIDTH-20, kSCREEN_HEIGHT-( _lab_to.y+_lab_to.height+20)-20-64)];
    [self.view addSubview:_textView];
    _textView.font=kSYS_FONT(17);
    _textView.editable=NO;
    _textView.textColor=[UIColor redColor];
    _textView.showsVerticalScrollIndicator=NO;
    
    if ([self.str_type isEqualToString:@"0"]) {
        _imgV_frome.image=kImageName([sximages objectAtIndex:_fromeIndex]);
        _imgV_to.image=kImageName([sximages objectAtIndex:_toIndex]);

        
        _lab_frome.text=[sxtitles objectAtIndex:_fromeIndex];
        _lab_to.text=[sxtitles objectAtIndex:_toIndex];
        
        [[PFChooseItemView shareInstance] setTitleDataSource:sxtitles ImageDataSource:sximages];
    }else{
        _imgV_frome.image=kImageName([xzimages objectAtIndex:_fromeIndex]);
        _imgV_to.image=kImageName([xzimages objectAtIndex:_toIndex]);

        
        _lab_frome.text=[xztitles objectAtIndex:_fromeIndex];
        _lab_to.text=[xztitles objectAtIndex:_toIndex];

        [[PFChooseItemView shareInstance] setTitleDataSource:xztitles ImageDataSource:xzimages];
    }
    
    [PFChooseItemView shareInstance].delegate=self;
}

/**
 *  左侧选择
 */
- (void)leftButtonAction {
    isLeft=YES;
    [[PFChooseItemView shareInstance] showFromeDirection:leftDirection];
}

/**
 *  右侧选择
 */
- (void)rightButtonAction {
    isLeft=NO;
    [[PFChooseItemView shareInstance] showFromeDirection:rightDirection];

}

/**
 *  PFChooseItemView Delegate
 *
 *  @param index item tag
 */
- (void)didSelectPFChooseItemViewWithIndex:(NSInteger)index {
    
    if (isLeft) {
        //forme
        _fromeIndex=index;
        if ([self.str_type isEqualToString:@"0"]) {//生肖
            _imgV_frome.image=kImageName([sximages objectAtIndex:index]);
            _lab_frome.text=[sxtitles objectAtIndex:index];

        }else{
            _imgV_frome.image=kImageName([xzimages objectAtIndex:index]);
            _lab_frome.text=[xztitles objectAtIndex:index];

        }
        

    }else{
        //to
        _toIndex=index;

        if ([self.str_type isEqualToString:@"0"]) {//星座
            _imgV_to.image=kImageName([sximages objectAtIndex:index]);
            _lab_to.text=[sxtitles objectAtIndex:index];
            
        }else{
            _imgV_to.image=kImageName([xzimages objectAtIndex:index]);
            _lab_to.text=[xztitles objectAtIndex:index];
            
        }
        

    }
}
//生肖配对
- (void)getSXDataFromRequest{
    NSDictionary * diction=@{@"key":sheng_xiao_pei_dui_key,
                             @"shengxiao1":[sxtitles objectAtIndex:_fromeIndex],
                             @"shengxiao2":[sxtitles objectAtIndex:_toIndex]};
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:sheng_xiao_pei_dui_DTAPI params:diction isHeader:NO
                                                LoadingBolck:^{
        [[PFProgressHUB shareInstance] show];
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getSXData:) withObject:respose waitUntilDone:YES];
        
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{

        [self endRefresh];
    }];
    
}
- (void)getSXData:(NSDictionary *)rootDic {
    
    
    if ([kFormatterSring([rootDic objectForKey:@"error_code"]) isEqualToString:@"0"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
      
        NSDictionary *result=[rootDic objectForKey:@"result"];
        
        NSString *content=[NSString stringWithFormat:@"%@\n\n%@",[result objectForKey:@"content1"],[result objectForKey:@"content2"]];
        
        _textView.text=content;
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"生肖配对失败，请重新配对"];
    }
    
}


//星座配对
- (void)getXZDataFromRequest{
    NSDictionary * diction=@{@"key":xing_zuo_pei_dui_key,
                             @"xingzuo1":[xztitles objectAtIndex:_fromeIndex],
                             @"xingzuo2":[xztitles objectAtIndex:_toIndex]};
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:xing_zuo_pei_dui_DTAPI params:diction isHeader:NO
                                                LoadingBolck:^{
                                                    [[PFProgressHUB shareInstance] show];
                                                    
                                                } SuccessBlock:^(NSDictionary *respose) {
                                                    
                                                    [self performSelectorOnMainThread:@selector(getXZData:) withObject:respose waitUntilDone:YES];
                                                    
                                                    
                                                } FailureBlock:^(NSError *error) {
                                                    
                                                } FinishBlock:^{

                                                    [self endRefresh];
                                                }];
    
}
- (void)getXZData:(NSDictionary *)rootDic {
    
    
    if ([kFormatterSring([rootDic objectForKey:@"error_code"]) isEqualToString:@"0"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
        
        NSDictionary *result=[rootDic objectForKey:@"result"];
        
        NSString *content=[NSString stringWithFormat:@"%@\n\n%@",[result objectForKey:@"content1"],[result objectForKey:@"content2"]];
        
        _textView.text=content;

    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"星座配对失败，请重新配对"];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[PFChooseItemView shareInstance] hiddent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
