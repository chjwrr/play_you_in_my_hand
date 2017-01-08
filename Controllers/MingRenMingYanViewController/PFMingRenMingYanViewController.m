//
//  XingShiQiYuanViewController.m
//  ModelProduct
//
//  Created by apple on 16/3/2.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFMingRenMingYanViewController.h"
#import "PFXingQiYuanCell.h"
#import "PFMingRenMingYanModel.h"

@interface PFMingRenMingYanViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic)NSInteger pageCount;
@property (nonatomic,strong)UISearchBar *searchBar;

@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation PFMingRenMingYanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"名人名言";
    
}

- (void)initDataSource {
    _pageCount=1;
    _dataSource=[[NSMutableArray alloc]init];
}
- (void)initSubViews {
    [self initLeftNavigationBarButtonWithImage:@"PF_home"];
    
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 44)];
    [self.view addSubview:_searchBar];
    _searchBar.delegate=self;
    _searchBar.backgroundImage=[[UIImage alloc]init];
    _searchBar.backgroundColor=kColorHexString(@"fc8b8b");
    
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 3;
        searchField.layer.masksToBounds = YES;
        searchField.textColor=[UIColor blackColor];
    }
    
    _searchBar.showsScopeBar = NO;
    _searchBar.delegate=self;
    _searchBar.barStyle=UISearchBarIconClear;
    _searchBar.placeholder=@"搜索关键字";
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNAVIGATIONBAR_HEIGHT-kSTATUSBAR_HEIGHT-44)];
    [self.view addSubview:_tableview];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableview.mj_footer=[self addTableViewFooterRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    //self.tableview.mj_header=[self addTableViewHeaderRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
}

#pragma UITableViewHeaderRef、footerRef


- (void)footerRefresh {
    
    self.pageCount+=1;
    
    [self getDataFromRequest];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [_dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PFMingRenMingYanModel *model=[_dataSource objectAtIndex:indexPath.section];

    return [PFXingQiYuanCell CellHeightWithData:model.famous_saying];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr=@"cellStr";
    PFXingQiYuanCell *cell=(PFXingQiYuanCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell=[[PFXingQiYuanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([_dataSource count] == 0) {
    }else{
        PFMingRenMingYanModel *model=[_dataSource objectAtIndex:indexPath.section];
        
        
        [cell cellForData:model.famous_saying];
    }
    
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([_dataSource count] == 0) {
        return nil;
    }else{
        PFMingRenMingYanModel *model=[_dataSource objectAtIndex:section];

        
        UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
        headview.backgroundColor=kviewlightbgColor;
        
        UILabel *lab_title=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, kSCREEN_WIDTH-20, 30)];
        [headview addSubview:lab_title];
        lab_title.text=model.famous_name;
        lab_title.font=kSYS_BOLDFONT(14);
        lab_title.textColor=[UIColor redColor];
        return headview;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_dataSource removeAllObjects];
    _pageCount = 1;
    [self getDataFromRequest];
}


//查询
- (void)getDataFromRequest{
    [self.view endEditing:YES];
    
    NSDictionary * diction=@{@"keyword":_searchBar.text,
                             @"page":[NSString stringWithFormat:@"%ld",(long)_pageCount],
                             @"rows":@"20"};
    
    [[AFHTTPClickManager shareInstanceAPIStore] getRequestWithPath:ming_ren_ming_yan_API params:diction isHeader:YES LoadingBolck:^{
        [[PFProgressHUB shareInstance] show];
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getData:) withObject:respose waitUntilDone:YES];
        
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{

        [self endRefresh];
    }];
    
}
- (void)getData:(NSDictionary *)rootDic {
    
    NSInteger total=kFormatterSring([rootDic objectForKey:@"total"]).integerValue;

    if ([kFormatterSring([rootDic objectForKey:@"error_code"]) isEqualToString:@"0"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
        
        NSArray *list=[rootDic objectForKey:@"result"];
        
        for (int i=0; i<[list count]; i++) {
            NSDictionary *diction=[list objectAtIndex:i];
            PFMingRenMingYanModel *model=[[PFMingRenMingYanModel alloc]init];
            [model setValuesForKeysWithDictionary:diction];
            [_dataSource addObject:model];
        }

        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"不存在含有此关键字的名言,请重新输入"];
    }
    
    if ([_dataSource count] >= total) {
        [self footerRefreshHiddent:YES];
    }else
        [self footerRefreshHiddent:NO];
    
    
    [self.tableview reloadData];
    
    [self endRefresh];
}



@end
