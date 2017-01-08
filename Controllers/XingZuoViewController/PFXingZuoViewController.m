//
//  PFXingZuoViewController.m
//  ModelProduct
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFXingZuoViewController.h"
#import "PFXingXiaoDetailViewController.h"
#import "PFShengXiaoTXTDetailViewController.h"
#import "PFXXPeiDuiViewController.h"

@interface PFXingZuoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout> {
    NSArray *images;
    NSArray *titles;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@end
@implementation PFXingZuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"星座";
}

- (void)initDataSource {
    [self initLeftNavigationBarButtonWithImage:@"PF_back"];
    [self initRithNavigationBarButtonWithImage:@"PF_xingxiao_peidui"];
    
    
    __weak PFXingZuoViewController *weakself=self;
    self.rightNavBarBlock=^{
        PFXXPeiDuiViewController *VC=[[PFXXPeiDuiViewController alloc]init];
        VC.str_type=@"1";
        [weakself.navigationController pushViewController:VC animated:YES];

    };
    
    titles=@[@"星座传说",
             @"星座NO.1",
             @"白羊座 3.21-4.19",
             @"金牛座 4.20-5.20",
             @"双子座 5.21-6.21",
             @"巨蟹座 6.22-7.22",
             @"狮子座 7.23-8.22",
             @"处女座 8.23-9.22",
             @"天秤座 9.23-10.23",
             @"天蝎座 10.24-11.22",
             @"射手座 11.23-12.21",
             @"摩羯座 12.22-1.19",
             @"水瓶座 1.20-2.18",
             @"双鱼座 2.19-3.20"];
    
    images=@[@"xz_bai_yang",
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


}

- (void)initSubViews {
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,kSCREEN_WIDTH, kSCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
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
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 150, 20)];
        label.textColor = [UIColor redColor];
        [cell.contentView addSubview:label];
        label.textAlignment=NSTextAlignmentCenter;
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 2) {
        PFXingXiaoDetailViewController *detailVC=[[PFXingXiaoDetailViewController alloc]init];
        detailVC.type=@"1";
        
        switch (indexPath.row-2) {
            case 0:{
                detailVC.str_pathName=@"xingzuo_bai_yang";
                detailVC.str_title=@"白羊座";
                detailVC.str_imageName=@"xz_bai_yang_small";
                
            }
                break;
            case 1:{
                detailVC.str_pathName=@"xingzuo_jin_niu";
                detailVC.str_title=@"金牛座";
                detailVC.str_imageName=@"xz_jin_niu_small";
                
            }
                break;
            case 2:{
                detailVC.str_pathName=@"xingzuo_shuang_zi";
                detailVC.str_title=@"双子座";
                detailVC.str_imageName=@"xz_shuang_zi_small";
                
            }
                break;
            case 3:{
                detailVC.str_pathName=@"xingzuo_juxie";
                detailVC.str_title=@"巨蟹座";
                detailVC.str_imageName=@"xz_ju_xie_small";
                
            }
                break;
            case 4:{
                detailVC.str_pathName=@"xingzuo_shi_zi";
                detailVC.str_title=@"狮子座";
                detailVC.str_imageName=@"xz_shi_zi_small";
                
            }
                break;
            case 5:{
                detailVC.str_pathName=@"xingzuo_chu_nv";
                detailVC.str_title=@"处女座";
                detailVC.str_imageName=@"xz_chu_nv_small";
                
            }
                break;
            case 6:{
                detailVC.str_pathName=@"xingzuo_tian_chen";
                detailVC.str_title=@"天秤座";
                detailVC.str_imageName=@"xz_tian_cheng_small";
                
            }
                break;
            case 7:{
                detailVC.str_pathName=@"xingzuo_tian_xie";
                detailVC.str_title=@"天蝎座";
                detailVC.str_imageName=@"xz_tian_xie_small";
                
            }
                break;
            case 8:{
                detailVC.str_pathName=@"xingzuo_she_shou";
                detailVC.str_title=@"射手座";
                detailVC.str_imageName=@"xz_she_shou_small";
                
            }
                break;
            case 9:{
                detailVC.str_pathName=@"xingzuo_mo_jie";
                detailVC.str_title=@"摩羯座";
                detailVC.str_imageName=@"xz_mo_jie_small";
                
            }
                break;
            case 10:{
                detailVC.str_pathName=@"xingzuo_shui_ping";
                detailVC.str_title=@"水瓶座";
                detailVC.str_imageName=@"xz_shui_ping_small";
                
            }
                break;
            case 11:{
                detailVC.str_pathName=@"xingzuo_shuang_yu";
                detailVC.str_title=@"双鱼座";
                detailVC.str_imageName=@"xz_shuang_yu_small";
                
            }
                break;
                
            default:
                break;
        }
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        PFShengXiaoTXTDetailViewController *txtVC=[[PFShengXiaoTXTDetailViewController alloc]init];
        
        if (indexPath.row == 0) {
            txtVC.str_type=@"2";
        }else
            txtVC.str_type=@"3";
        
        [self.navigationController pushViewController:txtVC animated:YES];
    }
    
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
