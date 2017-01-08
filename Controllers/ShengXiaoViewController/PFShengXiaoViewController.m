//
//  PFShengXiaoViewController.m
//  ModelProduct
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFShengXiaoViewController.h"
#import "PFXingXiaoDetailViewController.h"
#import "PFShengXiaoTXTDetailViewController.h"
#import "PFXXPeiDuiViewController.h"

@interface PFShengXiaoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout> {
    NSArray *images;
    NSArray *titles;
}
@property (nonatomic,strong)UICollectionView *collectionView;


@end

@implementation PFShengXiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"生肖";
}

- (void)initDataSource {
    [self initLeftNavigationBarButtonWithImage:@"PF_back"];
    [self initRithNavigationBarButtonWithImage:@"PF_xingxiao_peidui"];
    
    
    __weak PFShengXiaoViewController *weakself=self;
    self.rightNavBarBlock=^{
        PFXXPeiDuiViewController *VC=[[PFXXPeiDuiViewController alloc]init];
        VC.str_type=@"0";
        [weakself.navigationController pushViewController:VC animated:YES];
    };
    
    
    titles=@[@"生肖传说",
             @"生肖相对\n六道轮回",
             @"子（鼠）",
             @"丑（牛）",
             @"寅（虎）",
             @"卯（兔）",
             @"辰（龙）",
             @"巳（蛇）",
             @"午（马）",
             @"未（羊）",
             @"申（猴）",
             @"酉（鸡）",
             @"戌（狗）",
             @"亥（猪）"];
    
    images=@[@"sx_shu",
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

}

- (void)initSubViews {
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:self.collectionView];

}


#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    if (indexPath.row >= [titles count]) {
        return cell;
    }
    
    
    if (indexPath.row >=2) {
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
        [cell.contentView addSubview:imageview];
        imageview.image=kImageName([images objectAtIndex:indexPath.row-2]);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 150, 60, 20)];
        label.textColor = [UIColor redColor];
        [cell.contentView addSubview:label];
        label.textAlignment=NSTextAlignmentRight;
        label.font=kSYS_BOLDFONT(14);
        label.text=[titles objectAtIndex:indexPath.row];
        
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
        label.textColor = [UIColor redColor];
        [cell.contentView addSubview:label];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=kSYS_BOLDFONT(14);
        label.numberOfLines=2;
        label.text=[titles objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row >= [titles count]) {
        return CGSizeMake(150, 10);
    }
    
    if (indexPath.row >=2) {
        return CGSizeMake(150, 170);
    }else
        return CGSizeMake(150, 50);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row >= 2) {
        PFXingXiaoDetailViewController *detailVC=[[PFXingXiaoDetailViewController alloc]init];
        detailVC.type=@"0";
        
        switch (indexPath.row-2) {
            case 0:{
                detailVC.str_pathName=@"shengxiao_shu";
                detailVC.str_title=@"子（鼠）";
                detailVC.str_imageName=@"sx_shu_small";
                
            }
                break;
            case 1:{
                detailVC.str_pathName=@"shengxiao_niu";
                detailVC.str_title=@"丑（牛）";
                detailVC.str_imageName=@"sx_niu_small";
                
            }
                break;
            case 2:{
                detailVC.str_pathName=@"shengxiao_hu";
                detailVC.str_title=@"寅（虎）";
                detailVC.str_imageName=@"sx_hu_small";
                
            }
                break;
            case 3:{
                detailVC.str_pathName=@"shengxiao_tu";
                detailVC.str_title=@"卯（兔）";
                detailVC.str_imageName=@"sx_tu_small";
                
            }
                break;
            case 4:{
                detailVC.str_pathName=@"shengxiao_long";
                detailVC.str_title=@"辰（龙）";
                detailVC.str_imageName=@"sx_long_small";
                
            }
                break;
            case 5:{
                detailVC.str_pathName=@"shengxiao_she";
                detailVC.str_title=@"巳（蛇）";
                detailVC.str_imageName=@"sx_she_small";
                
            }
                break;
            case 6:{
                detailVC.str_pathName=@"shengxiao_ma";
                detailVC.str_title=@"午（马）";
                detailVC.str_imageName=@"sx_ma_small";
                
            }
                break;
            case 7:{
                detailVC.str_pathName=@"shengxiao_yang";
                detailVC.str_title=@"未（羊）";
                detailVC.str_imageName=@"sx_yang_small";
                
            }
                break;
            case 8:{
                detailVC.str_pathName=@"shengxiao_hou";
                detailVC.str_title=@"申（猴）";
                detailVC.str_imageName=@"sx_hou_small";
                
            }
                break;
            case 9:{
                detailVC.str_pathName=@"shengxiao_ji";
                detailVC.str_title=@"酉（鸡）";
                detailVC.str_imageName=@"sx_ji_small";
                
            }
                break;
            case 10:{
                detailVC.str_pathName=@"shengxiao_gou";
                detailVC.str_title=@"戌（狗）";
                detailVC.str_imageName=@"sx_gou_small";
                
            }
                break;
            case 11:{
                detailVC.str_pathName=@"shengxiao_zhu";
                detailVC.str_title=@"亥（猪）";
                detailVC.str_imageName=@"sx_zhu_small";
                
            }
                break;
                
            default:
                break;
        }
        
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        PFShengXiaoTXTDetailViewController *txtVC=[[PFShengXiaoTXTDetailViewController alloc]init];
        
        if (indexPath.row == 0) {
            txtVC.str_type=@"0";
        }else
            txtVC.str_type=@"1";
        
        [self.navigationController pushViewController:txtVC animated:YES];
    }
    
    
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
