//
//  XiaoHuaViewController.m
//  ModelProduct
//
//  Created by apple on 16/2/24.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFQuTuViewController.h"
#import "PFQuTuCell.h"
#import "PFQuTuModel.h"

@interface PFQuTuViewController ()<UITableViewDataSource,UITableViewDelegate,MWPhotoBrowserDelegate>{
    MWPhoto *selectPhoto;
}

@property (nonatomic,strong)UITableView *tableview;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic)NSInteger rowCount;

@end

@implementation PFQuTuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //进入刷新
    [self BeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initDataSource {
    _dataSource=[[NSMutableArray alloc]init];
    selectPhoto=[[MWPhoto alloc]init];
    _rowCount = 1;
}
- (void)initSubViews {
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNAVIGATIONBAR_HEIGHT-kSTATUSBAR_HEIGHT)];
    [self.view addSubview:_tableview];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableview.mj_footer=[self addTableViewFooterRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.tableview.mj_header=[self addTableViewHeaderRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
}

#pragma UITableViewHeaderRefooterRef

- (void)headerRefresh {
    
    self.rowCount = 1;
    
    [self getDataFromRequest];
    
}
- (void)footerRefresh {
    
    self.rowCount+=1;
    
    [self getDataFromRequest];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFQuTuModel *model=[_dataSource objectAtIndex:indexPath.row];
    
    return [PFQuTuCell CellHeightWithData:model];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr=@"PFQuTuCell";
    PFQuTuCell *cell=(PFQuTuCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell=[[PFQuTuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    if ([_dataSource count] <= indexPath.row) {
    }else{
        PFQuTuModel *model=[_dataSource objectAtIndex:indexPath.row];
        
        [cell cellForData:model];
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击放大图片
    
    if ([self.dataSource count] == 0) {
    
    }else{
        PFQuTuModel *model=[_dataSource objectAtIndex:indexPath.row];
        
        selectPhoto = [MWPhoto photoWithURL:[NSURL URLWithString:model.url]];
        
        
        [self jumpNext];
    
    }
}



//HTTP
- (void)getDataFromRequest {
    NSDictionary * diction=@{@"key":xiao_hua_zui_xin_key,
                             @"page":[NSString stringWithFormat:@"%ld",(long)self.rowCount],
                             @"rows":@"20"};
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:qu_tu_zui_xin_DTAPI params:diction isHeader:NO LoadingBolck:^{
        [[PFProgressHUB shareInstance] show];
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getData:) withObject:respose waitUntilDone:YES];
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{

        [self endRefresh];
    }];
}

- (void)getData:(NSDictionary *)rootDic {
    
    if (self.rowCount == 1) {
        [_dataSource removeAllObjects];
    }
    
    if ([kFormatterSring([rootDic objectForKey:@"error_code"]) isEqualToString:@"0"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
        
        NSArray *result=[rootDic objectForKey:@"result"];
        
        for (int i=0; i<[result count]; i++) {
            NSDictionary *diction=[result objectAtIndex:i];
            PFQuTuModel *model=[[PFQuTuModel alloc]init];
            [model setValuesForKeysWithDictionary:diction];
            [_dataSource addObject:model];
        }
        
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"趣图获取失败，请重试"];
        if (self.rowCount == 1) {
        }else
            self.rowCount--;
    }
    
    [self endRefresh];
    
    [self.tableview reloadData];

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
    return 1;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return selectPhoto;
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
