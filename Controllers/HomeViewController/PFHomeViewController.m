//
//  MWDViewController.m
//  ModelProduct
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFHomeViewController.h"

#import "CurveAnimalView.h"

#import "StraightAnimalView.h"

#import "FlashAnimalView.h"

#import "SparkAnimalView.h"

#import "BaseAnimalView.h"

#import "PF_ShowMoreItemView.h"

#import "UIImage+GIF.h"

#import "PFNewsViewController.h"

#import "PFImageViewController.h"

#import "PFDreamViewController.h"

#import "PFXingZuoViewController.h"

#import "PFShengXiaoViewController.h"

#import "PFXiaoHuaViewController.h"

#import "PFSettingViewController.h"

#import "PFChengYuViewController.h"

#import "PFCiHaiViewController.h"

#import "PFDictionaryViewController.h"

#import "PFXingShiQiYuanViewController.h"

#import "PFMingRenMingYanViewController.h"

#import "PFXieHouYuViewController.h"

#import "PFNaoJinJiZhuanWanViewController.h"

@interface PFHomeViewController ()<AnimalViewDelegate,PF_ShowMoreItemViewDelegate,UIActionSheetDelegate>{
    
    
    BaseAnimalView *currentAnimalView;
    
    PF_ShowMoreItemView *showMoreView;
}

@property (nonatomic,strong)CurveAnimalView *curveAnimalView;

@property (nonatomic,strong)StraightAnimalView *straightAnimalView;

@property (nonatomic,strong)FlashAnimalView *flashAnimalView;

@property (nonatomic,strong)SparkAnimalView *sparkAnimalView;

@property (nonatomic,strong)UIButton *btn_down;

@property (nonatomic,strong)UIButton *btn_show;

@property (nonatomic)BOOL isShowAniaml;

@property (nonatomic,strong)UIView *weatherView;


@end

@implementation PFHomeViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //[self.navigationController setNavigationBarHidden:NO animated:animated];

    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)initDataSource {
    
    _isShowAniaml=NO;

}
- (void)initSubViews {
    
    UILabel *labshow=[[UILabel alloc]init];
    
    if (iPhone4) {
        labshow.frame=CGRectMake(20, 80, kSCREEN_WIDTH-40, 150);
        labshow.font=kSYS_FONT(40);
        
    }else if (iPhone5){
        labshow.frame=CGRectMake(20, 70, kSCREEN_WIDTH-40, 150);
        labshow.font=kSYS_FONT(40);
    }else if(iPhone6){
        labshow.frame=CGRectMake(20, 100, kSCREEN_WIDTH-40, 150);
        labshow.font=kSYS_FONT(45);
    }else if (iPhone6Plus){
        labshow.frame=CGRectMake(20, 150, kSCREEN_WIDTH-40, 150);
        labshow.font=kSYS_FONT(45);
    }else{
        labshow.frame=CGRectMake(20, 100, kSCREEN_WIDTH-40, 150);
        labshow.font=kSYS_FONT(45);
    }
    
    
    [self.view addSubview:labshow];
    labshow.text=@"让生活\n玩弄于股掌之间";
    labshow.textAlignment=NSTextAlignmentCenter;
    labshow.textColor=kColorHexString(@"edebed");
    labshow.numberOfLines=0;
    
    _curveAnimalView=[[CurveAnimalView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_curveAnimalView];
    _curveAnimalView.delegate=self;
    
    _flashAnimalView=[[FlashAnimalView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_flashAnimalView];
    _flashAnimalView.delegate=self;
    
    _straightAnimalView=[[StraightAnimalView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_straightAnimalView];
    _straightAnimalView.delegate=self;
    
    
    _sparkAnimalView=[[SparkAnimalView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_sparkAnimalView];
    _sparkAnimalView.delegate=self;
    
    currentAnimalView=[[BaseAnimalView alloc]init];
    
    
    if ([kFormatterSring(kgetDefaultValueForKey(kUserHomeAnimalType)) isEqualToString:@"0"]) {
        _curveAnimalView.hidden=NO;
        _flashAnimalView.hidden=YES;
        _straightAnimalView.hidden=YES;
        _sparkAnimalView.hidden=YES;
        currentAnimalView=self.curveAnimalView;
        
    }else if ([kFormatterSring(kgetDefaultValueForKey(kUserHomeAnimalType)) isEqualToString:@"1"]) {
        _curveAnimalView.hidden=YES;
        _flashAnimalView.hidden=YES;
        _straightAnimalView.hidden=NO;
        _sparkAnimalView.hidden=YES;
        currentAnimalView=self.straightAnimalView;
        
    }else if ([kFormatterSring(kgetDefaultValueForKey(kUserHomeAnimalType)) isEqualToString:@"2"]) {
        
        _curveAnimalView.hidden=YES;
        _flashAnimalView.hidden=NO;
        _straightAnimalView.hidden=YES;
        _sparkAnimalView.hidden=YES;
        currentAnimalView=self.flashAnimalView;
        
    }else if ([kFormatterSring(kgetDefaultValueForKey(kUserHomeAnimalType)) isEqualToString:@"3"]) {
        _curveAnimalView.hidden=YES;
        _flashAnimalView.hidden=YES;
        _straightAnimalView.hidden=YES;
        _sparkAnimalView.hidden=NO;
        currentAnimalView=self.sparkAnimalView;
    }else{
        _curveAnimalView.hidden=NO;
        _flashAnimalView.hidden=YES;
        _straightAnimalView.hidden=YES;
        _sparkAnimalView.hidden=YES;
        currentAnimalView=self.curveAnimalView;
    }
    
    _btn_down=[[UIButton alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-44)/2, kSCREEN_HEIGHT-44, 44, 44)];
    [self.view addSubview:_btn_down];
    [_btn_down addTarget:self action:@selector(downButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_btn_down setImage:[UIImage imageNamed:@"PF_home_up_jian_tou"] forState:UIControlStateNormal];
    
    
    UILongPressGestureRecognizer *longRecognizer =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(showChooseType:)];
    [_btn_down addGestureRecognizer:longRecognizer];
    
    
    
    
    _btn_show=[[UIButton alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-44)/2, kSCREEN_HEIGHT-100-20-kimageWidth-44,44,44)];
    [self.view addSubview:_btn_show];
    [_btn_show addTarget:self action:@selector(showMoreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_btn_show setImage:[UIImage imageNamed:@"PF_home_showMore"] forState:UIControlStateNormal];
    
    
    
    
    UIImage *image=[UIImage sd_animatedGIFNamed:@"PF_home_news"];
    
    UIImageView *imgV_left=[[UIImageView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-80, 80, 80)];
    [self.view addSubview:imgV_left];
    imgV_left.image=image;
    
    UIButton *btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-80, 80, 80)];
    [self.view addSubview:btn_left];
    [btn_left addTarget:self action:@selector(btn_leftAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    //12月15时间戳
    NSTimeInterval oldinterval=1481731200;
    
    NSTimeInterval interval=[[NSDate date] timeIntervalSince1970];
    
    
    if (interval > oldinterval) {
        UIImage *image1=[UIImage sd_animatedGIFNamed:@"PF_home_tuku"];
        
        UIImageView *imgV_right=[[UIImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-75, kSCREEN_HEIGHT-80, 80, 80)];
        [self.view addSubview:imgV_right];
        imgV_right.image=image1;
        
        
        UIButton *btn_right=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-80, kSCREEN_HEIGHT-80, 80, 80)];
        [self.view addSubview:btn_right];
        [btn_right addTarget:self action:@selector(btn_rightAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //获取天气信息
    [self getWeatherData];
    
    
}

/**
 *  新闻页面
 */
- (void)btn_leftAction {
    PFNewsViewController *newVC=[[PFNewsViewController alloc]init];
    [self.navigationController pushViewController:newVC animated:YES];
}

/**
 *  图库页面
 */
- (void)btn_rightAction {
    PFImageViewController *imageVC=[[PFImageViewController alloc]init];
    [self.navigationController pushViewController:imageVC animated:YES];

}

/**
 *  点击中间加号
 */
- (void)showMoreButtonAction {
    
    [currentAnimalView endAnimal];
    _isShowAniaml=NO;
    
    showMoreView=[[PF_ShowMoreItemView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-100-[PF_ShowMoreItemView ViewHeight], kSCREEN_WIDTH, [PF_ShowMoreItemView ViewHeight])];
    [self.view addSubview:showMoreView];
    showMoreView.moreDelegate=self;
    
    [showMoreView startAnimal];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_btn_down.userInteractionEnabled) {
        [currentAnimalView endAnimal];
        
        _isShowAniaml=NO;
        
        [showMoreView endAnimal];
        
        [UIView beginAnimations:@"endAnimal" context:NULL];
        [UIView setAnimationDuration:0.5f];
        self.btn_down.transform = CGAffineTransformIdentity;
        [UIView commitAnimations];
    }
    
}

/**
 *  AnimalView Delegate
 *
 *  @param index 点击的item.tag
 */
- (void)didSelectAnimalViewWithIndex:(NSInteger)index {
    
    BaseViewController *vc;
    
    switch (index) {
        case 0:{
            //辞海
            vc=[[PFCiHaiViewController alloc]init];
        }
            break;
        case 1:{
            //名人名言
            vc=[[PFMingRenMingYanViewController alloc]init];
        }
            break;
        case 2:{
            //急转弯
            vc=[[PFNaoJinJiZhuanWanViewController alloc]init];
        }
            break;
        case 3:{
            //成语
            vc=[[PFChengYuViewController alloc]init];
        }
            break;
        case 4:{
            //歇后语
            vc=[[PFXieHouYuViewController alloc]init];
        }
            break;
        case 5:{
            //新华字典
            vc=[[PFDictionaryViewController alloc]init];
        }
            break;
        case 6:{
            //姓氏起源
            vc=[[PFXingShiQiYuanViewController alloc]init];
        }
            break;

        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 *  点击下面的箭头弹出各种动画效果
 */
- (void)downButtonAction {
    
    [showMoreView endAnimal];
    
    
    if (_isShowAniaml) {
        [currentAnimalView endAnimal];
        
        [UIView beginAnimations:@"endAnimal" context:NULL];
        [UIView setAnimationDuration:0.5f];
        self.btn_down.transform = CGAffineTransformIdentity;
        [UIView commitAnimations];
        
    }else{
        [currentAnimalView startAnimal];
        
        [UIView beginAnimations:@"startAnimal" context:NULL];
        [UIView setAnimationDuration:0.5f];
        self.btn_down.transform = CGAffineTransformMakeRotation((-180.0f * M_PI) / 180.0f);
        [UIView commitAnimations];
        
        _btn_down.userInteractionEnabled=NO;
        
        
        __weak PFHomeViewController *weakself=self;
        currentAnimalView.completeBlock=^{
            weakself.btn_down.userInteractionEnabled=YES;
            
        };
        
    }
    
    _isShowAniaml=!_isShowAniaml;
    
    
}


/**
 *  ShowMoreItemView Delegate   显示或隐藏动画
 */
- (void)didSelectShowMoreItem {
    
    [showMoreView endAnimal];
    
    if (_btn_down.userInteractionEnabled) {
        [currentAnimalView endAnimal];
        
        [UIView beginAnimations:@"endAnimal" context:NULL];
        [UIView setAnimationDuration:0.5f];
        self.btn_down.transform = CGAffineTransformIdentity;
        [UIView commitAnimations];
        
        
        _isShowAniaml=NO;
        
        
        showMoreView.hidden=NO;
        
        [showMoreView startAnimal];
    }
    
}

/**
 *  ShowMoreItemView Delegate
 *
 *  @param index item
 */
- (void)didSelectShowMoreItemWithIndex:(NSInteger)index {
    
    [showMoreView endAnimal];
    
    
    switch (index) {
        case 0:{
            //解梦
            PFDreamViewController *VC=[[PFDreamViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 1:{
            //笑图
            PFXiaoHuaViewController *VC=[[PFXiaoHuaViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 2:{
            //星座
            PFXingZuoViewController *VC=[[PFXingZuoViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 3:{
            //生肖
            PFShengXiaoViewController *VC=[[PFShengXiaoViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 4:{
            //设置
            PFSettingViewController *VC=[[PFSettingViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    
}

/**
 *  长按手势
 *
 *  @param recognizer 选择不同动画效果
 */
- (void)showChooseType:(UILongPressGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
                
        
        if (_btn_down.userInteractionEnabled) {
            [currentAnimalView endAnimal];
            
            [UIView beginAnimations:@"endAnimal" context:NULL];
            [UIView setAnimationDuration:0.5f];
            self.btn_down.transform = CGAffineTransformIdentity;
            [UIView commitAnimations];
            
        }
        
        [showMoreView endAnimal];
        _isShowAniaml=NO;
        
        
        if (kAPP_VERSION >=8.0) {
            UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:@"动画效果" message:nil  preferredStyle:(UIAlertControllerStyleAlert)];
            
            
            UIAlertAction *alertAction1=[UIAlertAction actionWithTitle:@"曲线" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                currentAnimalView=self.curveAnimalView;
                _curveAnimalView.hidden=NO;
                
                _flashAnimalView.hidden=YES;
                _straightAnimalView.hidden=YES;
                _sparkAnimalView.hidden=YES;
                
                
                ksetDefaultValueForKey(@"0", kUserHomeAnimalType);
            }];
            UIAlertAction *alertAction2=[UIAlertAction actionWithTitle:@"直线" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                currentAnimalView=self.straightAnimalView;
                
                _straightAnimalView.hidden=NO;
                
                _curveAnimalView.hidden=YES;
                _flashAnimalView.hidden=YES;
                _sparkAnimalView.hidden=YES;
                
                ksetDefaultValueForKey(@"1", kUserHomeAnimalType);
                
            }];
            UIAlertAction *alertAction3=[UIAlertAction actionWithTitle:@"闪现" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                currentAnimalView=self.flashAnimalView;
                
                _flashAnimalView.hidden=NO;
                
                _curveAnimalView.hidden=YES;
                _straightAnimalView.hidden=YES;
                _sparkAnimalView.hidden=YES;
                
                
                ksetDefaultValueForKey(@"2", kUserHomeAnimalType);
                
            }];
            UIAlertAction *alertAction4=[UIAlertAction actionWithTitle:@"引燃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                currentAnimalView=self.sparkAnimalView;
                
                _sparkAnimalView.hidden=NO;
                
                _curveAnimalView.hidden=YES;
                _straightAnimalView.hidden=YES;
                _flashAnimalView.hidden=YES;
                
                ksetDefaultValueForKey(@"3", kUserHomeAnimalType);
                
            }];
            
            UIAlertAction *alertAction5=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertVC addAction:alertAction1];
            [alertVC addAction:alertAction2];
            [alertVC addAction:alertAction3];
            [alertVC addAction:alertAction4];
            [alertVC addAction:alertAction5];
            
            [self presentViewController:alertVC animated:YES completion:nil];

        }else{
            UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"动画效果" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"曲线",@"直线",@"闪现",@"引燃", nil];
            [actionSheet showInView:self.view];
        }
        
        
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        currentAnimalView=self.curveAnimalView;
        _curveAnimalView.hidden=NO;
        
        _flashAnimalView.hidden=YES;
        _straightAnimalView.hidden=YES;
        _sparkAnimalView.hidden=YES;
        
        
        ksetDefaultValueForKey(@"0", kUserHomeAnimalType);

    }
    if (buttonIndex == 1) {
        currentAnimalView=self.straightAnimalView;
        
        _straightAnimalView.hidden=NO;
        
        _curveAnimalView.hidden=YES;
        _flashAnimalView.hidden=YES;
        _sparkAnimalView.hidden=YES;
        
        ksetDefaultValueForKey(@"1", kUserHomeAnimalType);

    }
    if (buttonIndex == 2) {
        currentAnimalView=self.flashAnimalView;
        
        _flashAnimalView.hidden=NO;
        
        _curveAnimalView.hidden=YES;
        _straightAnimalView.hidden=YES;
        _sparkAnimalView.hidden=YES;
        
        
        ksetDefaultValueForKey(@"2", kUserHomeAnimalType);

    }
    if (buttonIndex == 3) {
        currentAnimalView=self.sparkAnimalView;
        
        _sparkAnimalView.hidden=NO;
        
        _curveAnimalView.hidden=YES;
        _straightAnimalView.hidden=YES;
        _flashAnimalView.hidden=YES;
        
        ksetDefaultValueForKey(@"3", kUserHomeAnimalType);
        

    }
}

- (void)getWeatherData {
    //(NSString *)
    NSString *city=(NSString *)kgetDefaultValueForKey(kUserLocationCity);
    
    if ([city isEmpty]) {
        return;
    }
    
    city=[city stringByReplacingOccurrencesOfString:@"市" withString:@""];
    
    
    
    [[AFHTTPClickManager shareInstanceAPIStore] getRequestWithPath:zhong_guo_he_shi_jie_tian_qi_yu_bao_API params:@{@"city":@"北京"} isHeader:YES LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getData:) withObject:respose waitUntilDone:YES];
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        
        [self endRefresh];
    }];

}

- (void)getData:(NSDictionary *)rootDic {
    
    NSLog(@"allkey  %@",[rootDic allKeys]);
    
    
    NSArray *array=[rootDic objectForKey:[[rootDic allKeys] objectAtIndex:0]];
    
    NSDictionary *HeWeather=[ array objectAtIndex:0];
    
    NSArray *daily_forecast=[HeWeather objectForKey:@"daily_forecast"];
    
    NSLog(@"daily_forecast  %@",daily_forecast);
    
    NSDictionary *diction=[daily_forecast objectAtIndex:0];//第一天天气数据
    
    
    NSDictionary *cond=[diction objectForKey:@"cond"];//天气状况
    
    NSString *code_d=kFormatterSring([cond objectForKey:@"code_d"]);//白天天气图片
    NSString *txt_d=kFormatterSring([cond objectForKey:@"txt_d"]);//白天天气描述
    
    
    NSDictionary *tmp=[diction objectForKey:@"tmp"];//温度
    
    NSString *max=kFormatterSring([tmp objectForKey:@"max"]);//最高温度
    NSString *min=kFormatterSring([tmp objectForKey:@"min"]);//最低温度
    
    
    NSDictionary *now=[HeWeather objectForKey:@"now"];
    
    NSString *nowtmp=kFormatterSring([now objectForKey:@"tmp"]);//当前温度

    NSDictionary *wind=[diction objectForKey:@"wind"];//风向风力
    
    NSString *dir=kFormatterSring([wind objectForKey:@"dir"]);//风向
    NSString *sc=kFormatterSring([wind objectForKey:@"sc"]);//风力

    
    _weatherView=[[UIView alloc]init];

    _weatherView.frame=CGRectMake(0, 20, kSCREEN_WIDTH, 80);

    
    [self.view addSubview:_weatherView];
    
    UIImageView *weatherImgV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, _weatherView.height, _weatherView.height)];
    [_weatherView addSubview:weatherImgV];
    NSString *string_url=[NSString stringWithFormat:@"%@%@.png",zhong_guo_he_shi_jie_tian_qi_yu_bao_image_url,code_d];
    [weatherImgV sd_setImageWithURL:[NSURL URLWithString:string_url] placeholderImage:nil];
    weatherImgV.alpha=0.8;



    UILabel *lab_wendu=[[UILabel alloc]initWithFrame:CGRectMake(weatherImgV.x+weatherImgV.width, 20, 50, 40)];
    [_weatherView addSubview:lab_wendu];
    lab_wendu.text=[NSString stringWithFormat:@"%@",nowtmp];
    lab_wendu.textColor=kColorWithRGB(73, 97, 134, 1.0);
    lab_wendu.font=kSYS_BOLDFONT(40);
    lab_wendu.alpha=0.8;

    
    UILabel *lab_wendu1=[[UILabel alloc]initWithFrame:CGRectMake(lab_wendu.x+lab_wendu.width, lab_wendu.y+5, 40, 10)];
    [_weatherView addSubview:lab_wendu1];
    lab_wendu1.text=@"°C";
    lab_wendu1.textColor=kColorWithRGB(73, 97, 134, 1.0);
    lab_wendu1.font=kSYS_BOLDFONT(12);
    lab_wendu1.alpha=0.4;

    
    UILabel *lab_miaoshu=[[UILabel alloc]initWithFrame:CGRectMake(lab_wendu.x+lab_wendu.width+10, 40, 200, 20)];
    [_weatherView addSubview:lab_miaoshu];
    lab_miaoshu.text=[NSString stringWithFormat:@"%@ (%@°C ~ %@°C)",txt_d,min,max];
    lab_miaoshu.textColor=kColorWithRGB(73, 97, 134, 1.0);
    lab_miaoshu.font=kSYS_FONT(14);
    lab_miaoshu.alpha=0.4;

    
    UILabel *lab_feng=[[UILabel alloc]initWithFrame:CGRectMake(lab_wendu.x, 60, 100, 20)];
    [_weatherView addSubview:lab_feng];
    lab_feng.text=[NSString stringWithFormat:@"%@  %@",dir,sc];
    lab_feng.textColor=kColorWithRGB(73, 97, 134, 1.0);
    lab_feng.font=kSYS_FONT(12);
    lab_feng.alpha=0.4;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
