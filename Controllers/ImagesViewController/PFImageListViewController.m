//
//  ImageListViewController.m
//  ModelProduct
//
//  Created by apple on 16/2/18.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFImageListViewController.h"
#import "PFTuKuListModel.h"
#import "PFImageListCustomCell.h"

#import "XRWaterfallLayout.h"



typedef enum : NSUInteger {
    AnimalDirectionLeft,
    AnimalDirectionRight,
    AnimalDirectionUp,
    AnimalDirectionDown,
    
} AnimalDirection;


@interface PFImageListViewController ()<MWPhotoBrowserDelegate,UIAlertViewDelegate>{
    NSArray *images;
}

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSMutableArray *photos;
@property (nonatomic)NSInteger rowCount;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,strong)UIImageView *bgcontentImageView;
@property (nonatomic,strong)UILabel *lab_title;
@property (nonatomic,strong)UILabel *lab_count;

@end

@implementation PFImageListViewController

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
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initDataSource {
    _dataSource =[[NSMutableArray alloc]init];
    _photos=[[NSMutableArray alloc]init];

    _rowCount = 1;

    _currentPage=0;
}
- (void)initSubViews {

    [self getDataFromRequest];
    
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [self.view addSubview:_imageView];
    _imageView.userInteractionEnabled=YES;
    _imageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.imageView setShowActivityIndicatorView:YES];
    [self.imageView setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    _imageView.layer.masksToBounds=YES;
    
    UISwipeGestureRecognizer *swipeGestureleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureLeft:)];
    [_imageView addGestureRecognizer:swipeGestureleft];
    swipeGestureleft.direction=UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *swipeGestureright=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureRight:)];
    [_imageView addGestureRecognizer:swipeGestureright];
    swipeGestureright.direction=UISwipeGestureRecognizerDirectionRight;

    UITapGestureRecognizer *tapGesturetap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
    [_imageView addGestureRecognizer:tapGesturetap];
   
    
    UIImageView *bgimageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 44, 44)];
    bgimageview.backgroundColor=[UIColor blackColor];
    bgimageview.alpha=0.5;
    [self.view addSubview:bgimageview];
    bgimageview.layer.masksToBounds=YES;
    bgimageview.layer.cornerRadius=3;
    
    UIButton *btn_back=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 44, 44)];
    [self.view addSubview:btn_back];
    [btn_back setImage:kImageName(@"PF_back") forState:UIControlStateNormal];
    [btn_back addTarget:self action:@selector(backUpVCtrlAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIImageView *bgimageview1=[[UIImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-44-10, 20, 44, 44)];
    bgimageview1.backgroundColor=[UIColor blackColor];
    bgimageview1.alpha=0.5;
    [self.view addSubview:bgimageview1];
    bgimageview1.layer.masksToBounds=YES;
    bgimageview1.layer.cornerRadius=3;
    
    UIButton *btn_jubao=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-44-10, 20, 44, 44)];
    [self.view addSubview:btn_jubao];
    [btn_jubao setImage:kImageName(@"PF_iamge_jubao") forState:UIControlStateNormal];
    [btn_jubao addTarget:self action:@selector(jubaoAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    _bgcontentImageView=[[UIImageView alloc]initWithFrame:CGRectMake(40, kSCREEN_HEIGHT-110, 0, 20+20)];
    _bgcontentImageView.backgroundColor=[UIColor blackColor];
    _bgcontentImageView.alpha=0.5;
    [self.view addSubview:_bgcontentImageView];
    _bgcontentImageView.layer.masksToBounds=YES;
    _bgcontentImageView.layer.cornerRadius=5;
    
    _lab_title=[[UILabel alloc]initWithFrame:CGRectMake(50, kSCREEN_HEIGHT-100, kSCREEN_WIDTH-100, 40)];
    [self.view addSubview:_lab_title];
    _lab_title.numberOfLines=0;
    _lab_title.textColor=[UIColor whiteColor];
    _lab_title.font=kSYS_FONT(14);
//    [_lab_title sizeToFit];
//    
//
//    CGRect rect=_lab_title.frame;
//    
//    _bgcontentImageView.frame=CGRectMake((kSCREEN_WIDTH-rect.size.width)/2-10, kSCREEN_HEIGHT-50-rect.size.height-10, rect.size.width+20, rect.size.height+20);
//    _lab_title.frame=CGRectMake((kSCREEN_WIDTH-rect.size.width)/2, kSCREEN_HEIGHT-50-rect.size.height, rect.size.width, rect.size.height);
//    
    
    
    UIImageView *imageShow=[[UIImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-5-16-20, kSCREEN_HEIGHT-16-5, 16, 16)];
    imageShow.image=kImageName(@"PF_image_showcount");
    [self.view addSubview:imageShow];
    
    _lab_count=[[UILabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-5-20+2, kSCREEN_HEIGHT-16-5, 20, 16)];
    [self.view addSubview:_lab_count];
    _lab_count.textColor=[UIColor redColor];
    _lab_count.font=kSYS_FONT(12);
    _lab_count.textAlignment=NSTextAlignmentCenter;
    
    
}
- (void)loadSubViewData {
    
    _lab_title.frame=CGRectMake(50, kSCREEN_HEIGHT-100, kSCREEN_WIDTH-100, 0);

    
    PFTuKuListModel *model=[self.dataSource objectAtIndex:0];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",tukuHeaderURL,model.img]]];
    
    _lab_title.text=model.title;
    
    [_lab_title sizeToFit];
    
    
    
    CGRect rect=_lab_title.frame;
    
    _bgcontentImageView.frame=CGRectMake((kSCREEN_WIDTH-rect.size.width)/2-10, kSCREEN_HEIGHT-50-rect.size.height-10, rect.size.width+20, rect.size.height+20);
    
    _lab_title.frame=CGRectMake((kSCREEN_WIDTH-rect.size.width)/2, kSCREEN_HEIGHT-50-rect.size.height, rect.size.width, rect.size.height);
    
    _lab_count.text=kFormatterSring(model.size);

    
}
- (void)backUpVCtrlAction {
    [[PFProgressHUB shareInstance] dismiss];
    [AFHTTPClickManager cancelRequest];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)jubaoAction {
    if (kAPP_VERSION >=8.0) {
        UIAlertController *alertCtrl=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要举报此图集？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *alertAction2=[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self showJuBaoView];
            
        }];
        
        
        [alertCtrl addAction:alertAction1];
        [alertCtrl addAction:alertAction2];
        
        
        [self presentViewController:alertCtrl animated:YES completion:nil];

    }else{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要举报此图集？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"举报", nil];
        [alertView show];
    }
    
    
}


/**
 *  UIAlertView Delegate
*/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self showJuBaoView];
    }
}

/**
 *  显示举报视图
 */
- (void)showJuBaoView {
    UIView *jubaoView=[[UIView alloc]initWithFrame:CGRectMake(64, 20, kSCREEN_WIDTH-64*2, 0)];
    [self.view addSubview:jubaoView];
    
    UIImageView *bgimageview1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH-64*2, 0)];
    bgimageview1.backgroundColor=[UIColor blackColor];
    bgimageview1.alpha=0.5;
    [jubaoView addSubview:bgimageview1];
    bgimageview1.layer.masksToBounds=YES;
    bgimageview1.layer.cornerRadius=5;
    
    
    UILabel *lab_jibao=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, kSCREEN_WIDTH-64*2-10, 0)];
    [jubaoView addSubview:lab_jibao];
    
    if (iPhone4 || iPhone5) {
        lab_jibao.text=@"举报成功!\n我们会核实您的检举并作出相应的处理,感谢您的支持!";
    }else
        lab_jibao.text=@"举报成功!\n我们会核实您的检举并作出相应的处理\n感谢您的支持!";
    
    lab_jibao.textAlignment=NSTextAlignmentCenter;
    lab_jibao.numberOfLines=0;
    lab_jibao.font=kSYS_FONT(12);
    lab_jibao.textColor=[UIColor whiteColor];
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        jubaoView.frame=CGRectMake(64, 20, kSCREEN_WIDTH-64*2, 54);
        bgimageview1.frame=CGRectMake(0, 0, kSCREEN_WIDTH-64*2, 54);
        lab_jibao.frame=CGRectMake(5, 5, kSCREEN_WIDTH-64*2-10, 44);

    } completion:^(BOOL finished) {
        if (finished) {
            sleep(2);
            [jubaoView removeFromSuperview];
        }
    }];

}
//手势触发 向左轻扫 下一页
- (void)swipeGestureLeft:(UISwipeGestureRecognizer *)recognizer {

    if ([self.dataSource count] == 0) {
        return;
    }
   
    if (_currentPage == [images count]-1) {
        return;
    }
    
    _currentPage++;

    
    if (!_isNew) {
        if (_currentPage == [self.dataSource count] -5) {
            //倒数第五张得时候加载新一页的数据
            self.rowCount++;
            [self getDataFromRequest];
        }
    }
    [self reloadTXTSource:AnimalDirectionRight];
    
}
//手势触发 向右轻扫 上一页
- (void)swipeGestureRight:(UISwipeGestureRecognizer *)recognizer {

    if ([self.dataSource count] == 0) {
        return;
    }
    
    if (_currentPage ==0) {
        return;
    }
    _currentPage--;

    [self reloadTXTSource:AnimalDirectionLeft];
    
}

//点击进入图库详情
- (void)tapGesture {
    
    if ([self.dataSource count] == 0) {
        return;
    }
    
    PFTuKuListModel *model=[_dataSource objectAtIndex:_currentPage];
    
    [self getImageDetailFromRequest:model.str_ID];
    

}

//刷新textview数据   左右平滑返回或加载
- (void)reloadTXTSource:(AnimalDirection)direction {
    
    
    CATransition *animal=[CATransition animation];
    animal.duration=0.5f;
    animal.type=kCATransitionReveal;
    
    
    switch (direction) {
        case AnimalDirectionLeft:
            animal.subtype=kCATransitionFromLeft;
            
            break;
        case AnimalDirectionRight:
            animal.subtype=kCATransitionFromRight;
            
            break;
        case AnimalDirectionUp:
            animal.subtype=kCATransitionFromTop;
            
            break;
        case AnimalDirectionDown:
            animal.subtype=kCATransitionFromBottom;
            
            break;
            
        default:
            break;
    }
    _lab_title.frame=CGRectMake(50, kSCREEN_HEIGHT-100, kSCREEN_WIDTH-100, 0);

    PFTuKuListModel *model=[self.dataSource objectAtIndex:_currentPage];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",tukuHeaderURL,model.img]]];
   
    _lab_title.text=model.title;
    
    [_lab_title sizeToFit];
    

    CGRect rect=_lab_title.frame;
    
    _bgcontentImageView.frame=CGRectMake((kSCREEN_WIDTH-rect.size.width)/2-10, kSCREEN_HEIGHT-50-rect.size.height-10, rect.size.width+20, rect.size.height+20);
    
    _lab_title.frame=CGRectMake((kSCREEN_WIDTH-rect.size.width)/2, kSCREEN_HEIGHT-50-rect.size.height, rect.size.width, rect.size.height);
    
    _lab_count.text=kFormatterSring(model.size);
    
    [_imageView.layer addAnimation:animal forKey:nil];
    
}


- (void)getDataFromRequest {
    NSDictionary *diction;
    
    NSString *urlPath;
    
    if (_isNew) {
        
        urlPath=tian_gou_zui_xin_API;
        
        diction=@{@"id":_str_ID,
                  @"page":@"1",
                  @"rows":@"714"};
    }else{
       
        urlPath=tian_gou_lie_biao_API;
        
        diction=@{@"id":_str_ID,
                  @"page":[NSString stringWithFormat:@"%ld",(long)self.rowCount],
                  @"rows":@"20"};
    }
    
    [[AFHTTPClickManager shareInstanceAPIStore] getRequestWithPath:urlPath params:diction isHeader:YES LoadingBolck:^{
        [[PFProgressHUB shareInstance] show];
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getData:) withObject:respose waitUntilDone:YES];

    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{

        [self endRefresh];
    }];
    
}
- (void)getData:(NSDictionary *)rootDic {

    if ([kFormatterSring([rootDic objectForKey:@"status"]) isEqualToString:@"1"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
        
        NSArray *list=[rootDic objectForKey:@"tngou"];
        
        for (int i=0; i<[list count]; i++) {
            NSDictionary *diction=[list objectAtIndex:i];
            PFTuKuListModel *model=[[PFTuKuListModel alloc]init];
            [model setValuesForKeysWithDictionary:diction];
            
            [_dataSource addObject:model];
        }
        
        if (self.rowCount == 1) {
            [self loadSubViewData];
        }
        
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"获取图集失败，请重试"];
        if (self.rowCount == 1) {
        }else
            self.rowCount-=1;
    }

}


//获取图库详情
- (void)getImageDetailFromRequest:(NSString *)str_id {
    
    
    NSDictionary *diction=@{@"id":str_id};
    
    
    [[AFHTTPClickManager shareInstanceAPIStore] getRequestWithPath:tian_gou_xiang_qing_API params:diction isHeader:YES LoadingBolck:^{
        [[PFProgressHUB shareInstance] show];
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getImageDetailData:) withObject:respose waitUntilDone:YES];
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{

        [self endRefresh];
    }];
    
}
- (void)getImageDetailData:(NSDictionary *)rootDic {
    
    
    [_photos removeAllObjects];
    
    
    if ([kFormatterSring([rootDic objectForKey:@"status"]) isEqualToString:@"1"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
        
        NSArray *list=[rootDic objectForKey:@"list"];
        
        for (int i=0; i<[list count]; i++) {
            
            NSDictionary *diction=[list objectAtIndex:i];
            
            MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",tukuHeaderURL,[diction objectForKey:@"src"]]]];
            photo.caption=[rootDic objectForKey:@"title"];
            
            
            [_photos addObject:photo];

        }
        
        //跳转图片浏览
        [self jumpNext];
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"获取图集详情失败，请重试"];
    }
    
}




- (void)jumpNext {
    
    //--------------------------------初始化浏览器
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;//弹出分享保存等选项右上方
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = NO;
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = YES;
    browser.autoPlayOnAppear = NO;
    [browser setCurrentPhotoIndex:0];
    
    [self.navigationController pushViewController:browser animated:YES];

}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    return nil;
}


- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    //NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return YES;
}


- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
   // NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    //NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
