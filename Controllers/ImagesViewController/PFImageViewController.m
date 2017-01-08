//
//  PFImageViewController.m
//  ModelProduct
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFImageViewController.h"

#import "PFImageCustomCell.h"
#import "PFTuKuModel.h"
#import "PFImageListViewController.h"
#import "PFImageTextSearchViewController.h"

@interface PFImageViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *images;
}

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataSource;


@end

@implementation PFImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"股掌间";
}


- (void)initDataSource {
    [self initLeftNavigationBarButtonWithImage:@"PF_home"];
    
    [self initRithNavigationBarButtonWithImage:@"PF_Image_search"];
    __weak PFImageViewController *weakself=self;
    self.rightNavBarBlock=^{
        PFImageTextSearchViewController *searchVC=[[PFImageTextSearchViewController alloc]init];
        [weakself.navigationController pushViewController:searchVC animated:YES];
    };
    images=@[@"zui_xin_tu_ku",@"xing_gan_mei_nv",@"han_ri_mei_nv",@"si_wa_mei_tui",@"mei_nv_zhao_piam",@"mei_nv_xie_zhen",@"qing_chun_emi_nv",@"xing_gan_che_mo"];

    _dataSource=[[NSMutableArray alloc]init];
    
}
- (void)initSubViews {
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,kSCREEN_WIDTH,kSCREEN_HEIGHT-64)];
    [self.view addSubview:_tableview];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self getDataFromRequest];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PFImageCustomCell cellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr=@"PFImageCustomCell";
    PFImageCustomCell *cell=(PFImageCustomCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell=[[PFImageCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    if ([_dataSource count] <= indexPath.row) {
    }else{
        [cell cellForData:[_dataSource objectAtIndex:indexPath.row]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    PFTuKuModel *model=[_dataSource objectAtIndex:indexPath.row];
    
    PFImageListViewController *listVC=[[PFImageListViewController alloc]init];
    listVC.str_ID=model.str_ID;
    listVC.str_title=model.title;
    
    if (indexPath.row == 0) {
        listVC.isNew=YES;
    }else
        listVC.isNew=NO;
    
    [self.navigationController pushViewController:listVC animated:YES];
    
}



- (void)getDataFromRequest {
    
    [[AFHTTPClickManager shareInstanceAPIStore] getRequestWithPath:tian_gou_fen_lei_API params:nil isHeader:YES LoadingBolck:^{
        
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
        
        PFTuKuModel *model1=[[PFTuKuModel alloc]init];

        model1.descriptions = @"";
        model1.str_ID = @"0";
        model1.keywords = @"";
        model1.name =@"";
        model1.seq = @"0";
        model1.title = @"最新图库";
        model1.imageName=[images objectAtIndex:0];
        [_dataSource addObject:model1];

        
        for (int i=0; i<[list count]; i++) {
            NSDictionary *diction=[list objectAtIndex:i];
            PFTuKuModel *model=[[PFTuKuModel alloc]init];
            [model setValuesForKeysWithDictionary:diction];
            
            model.imageName=[images objectAtIndex:i+1];
            
            [_dataSource addObject:model];
        }
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"获取分类失败失败，请重试"];
    }
    
    [self.tableview reloadData];
    
}



@end
