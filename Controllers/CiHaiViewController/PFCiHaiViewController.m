//
//  DictionaryViewController.m
//  ModelProduct
//
//  Created by apple on 16/2/23.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFCiHaiViewController.H"
#import "PFCiHaiCustomCell.h"
#import "PFCiHaiModel.h"

@interface PFCiHaiViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic)NSInteger rowCount;


@end

@implementation PFCiHaiViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"辞海";
    
    //随机出来一条数据
    [self getDataFromRequest];
}

- (void)initDataSource {
    _dataSource=[[NSMutableArray alloc]init];
    _rowCount=1;
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
    _searchBar.placeholder=@"搜索字词";
    
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNAVIGATIONBAR_HEIGHT-kSTATUSBAR_HEIGHT-44)];
    [self.view addSubview:_tableview];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
 
    
    self.tableview.mj_footer=[self addTableViewFooterRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
//    self.tableview.mj_header=[self addTableViewHeaderRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
}

#pragma UITableViewHeaderRef、footerRef

- (void)headerRefresh {
    
    self.rowCount = 1;
    [_dataSource removeAllObjects];
    
    [self getDataFromRequestWithSearchItem:_searchBar.text];
    
}
- (void)footerRefresh {
    
    self.rowCount+=1;
    
    [self getDataFromRequestWithSearchItem:_searchBar.text];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [_dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PFCiHaiModel *model=[_dataSource objectAtIndex:indexPath.section];
    
    return [PFCiHaiCustomCell CellHeightWithData:model.content];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr=@"cellStr";
    PFCiHaiCustomCell *cell=(PFCiHaiCustomCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell=[[PFCiHaiCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([_dataSource count] <= indexPath.section) {
    }else{
        
        PFCiHaiModel *model=[_dataSource objectAtIndex:indexPath.section];
        
        [cell cellForData:model.content];
    }
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([_dataSource count] <= section) {
        return nil;
    }else{
        PFCiHaiModel *model=[_dataSource objectAtIndex:section];
        
        
        UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
        headview.backgroundColor=kviewlightbgColor;
        
        UILabel *lab_title=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, kSCREEN_WIDTH-20, 30)];
        [headview addSubview:lab_title];
        lab_title.text=model.words;
        lab_title.font=kSYS_BOLDFONT(14);
        lab_title.textColor=[UIColor redColor];
        return headview;
    }
}

//HTTP  辞海模糊查询

- (void)getDataFromRequestWithSearchItem:(NSString *)searchString {
    
    NSDictionary * diction=@{@"key":ci_hai_key,
                             @"keyword":searchString,
                             @"page":[NSString stringWithFormat:@"%ld",(long)self.rowCount],
                             @"rows":@"20"};
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:ci_hai_DTAPI params:diction isHeader:NO LoadingBolck:^{
        
       [[PFProgressHUB shareInstance] show];
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getData:) withObject:respose waitUntilDone:YES];
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        [self endRefresh];
    }];
    
}
//HTTP  辞海模糊查询结果

- (void)getData:(NSDictionary *)rootDic {
    
    NSInteger total=kFormatterSring([rootDic objectForKey:@"total"]).integerValue;

    if ([kFormatterSring([rootDic objectForKey:@"error_code"]) isEqualToString:@"0"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
        
        NSArray *list=[rootDic objectForKey:@"result"];
        
        for (int i=0; i<[list count]; i++) {
            NSDictionary *diction=[list objectAtIndex:i];
            PFCiHaiModel *model=[[PFCiHaiModel alloc]init];
            [model setValuesForKeysWithDictionary:diction];
            [_dataSource addObject:model];
        }
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"查询失败，请重试"];
        if (self.rowCount == 1) {
        }else
            self.rowCount--;
    }

    if ([_dataSource count] >= total) {
        [self footerRefreshHiddent:YES];
    }else
        [self footerRefreshHiddent:NO];


    [self.tableview reloadData];
    
    [self endRefresh];
}


//HTTP  辞海随机一条

- (void)getDataFromRequest {
    
    NSDictionary * diction=@{@"key":ci_hai_key};
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:ci_hai_SuiJi_DTAPI params:diction isHeader:NO LoadingBolck:^{
        [[PFProgressHUB shareInstance] show];
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getDataSuiJi:) withObject:respose waitUntilDone:YES];
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        [self endRefresh];
    }];
    
}

//HTTP  辞海随机一条结果

- (void)getDataSuiJi:(NSDictionary *)rootDic {
    
    
    if ([kFormatterSring([rootDic objectForKey:@"error_code"]) isEqualToString:@"0"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
        
        NSDictionary *diction=[rootDic objectForKey:@"result"];
        
        PFCiHaiModel *model=[[PFCiHaiModel alloc]init];
        [model setValuesForKeysWithDictionary:diction];
        [_dataSource addObject:model];
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"随机返回失败,请输入查询"];
    }
    
    [self footerRefreshHiddent:YES];
    
    [self.tableview reloadData];
    
}


#pragma UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text isEmpty]) {
        return;
    }
    
    [searchBar resignFirstResponder];
    
    [_dataSource removeAllObjects];
    self.rowCount = 1;
    
    [self getDataFromRequestWithSearchItem:searchBar.text];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
