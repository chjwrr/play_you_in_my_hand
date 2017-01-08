//
//  DictionaryViewController.m
//  ModelProduct
//
//  Created by apple on 16/2/23.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFChengYuViewController.h"
#import "PFDictionCell.h"
#import "PFChengYuModel.h"

#import "PFChengYuDetailViewController.h"

@interface PFChengYuViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic)NSInteger rowCount;
@property (nonatomic)NSInteger selectItem;



@end

@implementation PFChengYuViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"成语";
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
    _searchBar.placeholder=@"搜索成语关键字";

    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNAVIGATIONBAR_HEIGHT-kSTATUSBAR_HEIGHT-44)];
    [self.view addSubview:_tableview];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableview.mj_footer=[self addTableViewFooterRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    [self footerRefreshHiddent:YES];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PFDictionCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr=@"cellStr";
    PFDictionCell *cell=(PFDictionCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell=[[PFDictionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([_dataSource count] <= indexPath.row) {
    }else{
        
        PFChengYuModel *model=[_dataSource objectAtIndex:indexPath.row];
    
        [cell cellForData:model.name];
        
        
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFChengYuDetailViewController *detailVC=[[PFChengYuDetailViewController alloc]init];
    
    detailVC.dataSource=self.dataSource;
    detailVC.selectItem=indexPath.row;
    
    [self.navigationController pushViewController:detailVC animated:YES];

}
//HTTP
- (void)getDataFromRequestWithSearchItem:(NSString *)searchString {
    
    [self footerRefreshHiddent:NO];

    
    NSDictionary * diction=@{@"key":cheng_yu_key,
                             @"keyWord":searchString,
                             @"page":[NSString stringWithFormat:@"%ld",(long)self.rowCount],
                             @"rows":@"20"};
    
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:guan_jian_zi_sou_suo_cheng_yu_DTAPI params:diction isHeader:NO LoadingBolck:^{
        [[PFProgressHUB shareInstance] show];
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getData:) withObject:respose waitUntilDone:YES];
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        [self endRefresh];
    }];
    
}

- (void)getData:(NSDictionary *)rootDic {
    
    
    if ([kFormatterSring([rootDic objectForKey:@"error_code"]) isEqualToString:@"0"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
        
        NSArray *list=[rootDic objectForKey:@"result"];
        
        for (int i=0; i<[list count]; i++) {
            NSDictionary *diction=[list objectAtIndex:i];
            PFChengYuModel *model=[[PFChengYuModel alloc]init];
            [model setValuesForKeysWithDictionary:diction];
            [_dataSource addObject:model];
            
        }
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"搜索失败，请重试"];
        if (self.rowCount == 1) {
        }else
            self.rowCount--;
    }
    
    
    [self.tableview reloadData];
    
    [self endRefresh];
}

#pragma UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text isEmpty]) {
        return;
    }
    
    [searchBar resignFirstResponder];
    
    [_dataSource removeAllObjects];
    
    [self getDataFromRequestWithSearchItem:searchBar.text];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
