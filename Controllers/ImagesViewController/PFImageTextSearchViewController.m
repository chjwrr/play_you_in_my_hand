//
//  ImageTextSearchViewController.m
//  ModelProduct
//
//  Created by apple on 16/2/19.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFImageTextSearchViewController.h"

@interface PFImageTextSearchViewController ()<MWPhotoBrowserDelegate,UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    NSArray *titles;
}

@property (nonatomic,strong)NSMutableArray *photos;
@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)UICollectionView *collectView;
@end

@implementation PFImageTextSearchViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"文本搜图";
    
}

- (void)initDataSource {
    _photos =[[NSMutableArray alloc]init];
    
    titles=@[@"帅哥哥",@"美女",@"小清新",@"风景",@"唯美",@"性感",@"娱乐",@"非主流",@"萌宠",@"游戏",@"汽车",@"军事",@"动漫",@"体育",@"搞笑"];
    
}
- (void)initSubViews {
    
    self.view.backgroundColor=kColorHexString(@"ededed");
    
    [self initLeftNavigationBarButtonWithImage:@"PF_back"];

    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-60, 20, 60, 44)];
    [self.view addSubview:button];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:kColorHexString(@"03a9f4") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backUpVCtrl) forControlEvents:UIControlEventTouchUpInside];
    
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH-50, 44)];
    _searchBar.backgroundImage=[[UIImage alloc]init];
    
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 15;
        searchField.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor clearColor]);
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
        searchField.textColor=[UIColor blackColor];
    }
    
    _searchBar.showsScopeBar = NO;
    _searchBar.delegate=self;
    _searchBar.barStyle=UISearchBarIconClear;
    _searchBar.placeholder=@"搜索关键字";

    [self.view addSubview:_searchBar];

    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    _collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
    _collectView.delegate=self;
    _collectView.dataSource=self;
    [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectView];
    _collectView.backgroundColor=[UIColor clearColor];
    
}
- (void)backUpVCtrl {
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"cell";
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, cell.width, 20)];
    label.textColor = [UIColor redColor];
    label.text =[titles objectAtIndex:indexPath.row];
    label.textColor=[UIColor blackColor];
    label.textAlignment=NSTextAlignmentCenter;
    [label sizeToFit];
    
    CGRect rect=label.frame;
    
    label.frame=CGRectMake((cell.width-rect.size.width)/2, (cell.height-20)/2, rect.size.width, 20);
    
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(label.x-5, label.y-5, label.width+10, label.height+10)];

    imageview.layer.borderWidth=1;
    imageview.layer.cornerRadius=3;
    imageview.layer.masksToBounds=YES;
    imageview.layer.borderColor=kColorHexString(@"bbbbbb").CGColor;
    imageview.layer.shadowOffset=CGSizeMake(2, 2);
    imageview.layer.shadowColor=kColorHexString(@"aaaaaa").CGColor;

    [cell.contentView addSubview:label];
    [cell.contentView addSubview:imageview];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (iPhone4) {
        return CGSizeMake((kSCREEN_WIDTH-30)/3, 30);
    }else if (iPhone5){
        return CGSizeMake((kSCREEN_WIDTH-30)/3, 46);
    }else if (iPhone6){
        return CGSizeMake((kSCREEN_WIDTH-30)/3, 70);
    }else if (iPhone6Plus){
        return CGSizeMake((kSCREEN_WIDTH-30)/3, 80);
    }else
        return CGSizeMake((kSCREEN_WIDTH-30)/3, 70);

}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 5, 10, 5);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [_searchBar resignFirstResponder];
    
    [self getDataFromRequestWithSearchItem:[titles objectAtIndex:indexPath.row]];
    
}


//搜索
- (void)getDataFromRequestWithSearchItem:(NSString *)searchItem {
    NSDictionary * diction=@{@"word":searchItem,
                             @"ie":@"utf-8",
                             @"pn":@"0",
                             @"m":@"50"};
    
    [[AFHTTPClickManager shareInstanceAPIStore] getRequestWithPath:wen_ben_sou_tu_API params:diction isHeader:YES LoadingBolck:^{
        [[PFProgressHUB shareInstance] show];
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getData:) withObject:respose waitUntilDone:YES];

        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{

        [self endRefresh];
    }];
    
}
- (void)getData:(NSDictionary *)rootDic {
    
    
    [_photos removeAllObjects];
    
    NSDictionary *statusDic=[rootDic objectForKey:@"status"];
    if ([kFormatterSring([statusDic objectForKey:@"code"]) isEqualToString:@"0"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
        
        NSDictionary *dataDic=[rootDic objectForKey:@"data"];
        NSArray *ResultArray=[dataDic objectForKey:@"ResultArray"];
        
        for (int i=0; i<[ResultArray count]; i++) {
            
            NSDictionary *diction=[ResultArray objectAtIndex:i];
            
            MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[diction objectForKey:@"ObjUrl"]]];
            photo.caption=[[diction objectForKey:@"Desc"] removeHTML];
            
            
            [_photos addObject:photo];
            
        }
        
        //跳转图片浏览
        [self jumpNext];
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"暂未搜索到该关键字的图片，请重新输入查询"];
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




#pragma UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text isEmpty]) {
        return;
    }
    
    [searchBar resignFirstResponder];
    
    [self getDataFromRequestWithSearchItem:searchBar.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
