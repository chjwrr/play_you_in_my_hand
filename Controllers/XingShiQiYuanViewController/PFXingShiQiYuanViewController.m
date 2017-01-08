//
//  XingShiQiYuanViewController.m
//  ModelProduct
//
//  Created by apple on 16/3/2.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFXingShiQiYuanViewController.h"
#import "PFXingQiYuanCell.h"

@interface PFXingShiQiYuanViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)UISearchBar *searchBar;

@property (nonatomic,strong)NSString *str_xingshi;
@property (nonatomic,strong)NSString *str_qiyuan;


@end

@implementation PFXingShiQiYuanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"姓氏起源";
   
}

- (void)initDataSource {
    _str_xingshi=[[NSString alloc]init];
    _str_qiyuan=[[NSString alloc]init];

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
    _searchBar.placeholder=@"搜索姓氏";
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNAVIGATIONBAR_HEIGHT-kSTATUSBAR_HEIGHT-44)];
    [self.view addSubview:_tableview];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self getSuiJiDataFromRequest];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [PFXingQiYuanCell CellHeightWithData:_str_qiyuan];
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
    [cell cellForData:_str_qiyuan];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
    headview.backgroundColor=kviewlightbgColor;
    
    UILabel *lab_title=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, kSCREEN_WIDTH-20, 30)];
    [headview addSubview:lab_title];
    lab_title.text=_str_xingshi;
    lab_title.font=kSYS_BOLDFONT(14);
    lab_title.textColor=[UIColor redColor];
    return headview;
    
}


#pragma UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self getDataFromRequest];
}


//查询
- (void)getDataFromRequest{
    [self.view endEditing:YES];
    
    NSDictionary * diction=@{@"xingshi":_searchBar.text,
                             @"key":xing_shi_qi_yuan_key};
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:xing_shi_qi_yuan_DTAPI params:diction isHeader:NO LoadingBolck:^{
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
        
        NSDictionary *result=[rootDic objectForKey:@"result"];
      
        if ([result isEqual:[NSNull null]]) {
            [[PFProgressHUB shareInstance] showWithContent:@"不存在此姓氏,请重新输入"];
            return;
        }
        _str_xingshi=[result objectForKey:@"xing"];
        
        _str_qiyuan=[result objectForKey:@"intro"];
        
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"姓氏查询失败,请重新输入"];
    }
    
    [_tableview reloadData];
}


//随机返回
- (void)getSuiJiDataFromRequest{
    NSDictionary * diction=@{@"key":xing_shi_qi_yuan_key};
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:xing_shi_qi_yuan_sui_ji_DTAPI params:diction isHeader:NO LoadingBolck:^{
        [[PFProgressHUB shareInstance] show];
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getSuiJiData:) withObject:respose waitUntilDone:YES];
        
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{

        [self endRefresh];
    }];
    
}
- (void)getSuiJiData:(NSDictionary *)rootDic {
    
    
    if ([kFormatterSring([rootDic objectForKey:@"error_code"]) isEqualToString:@"0"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
        
        NSDictionary *result=[rootDic objectForKey:@"result"];
        
        _str_xingshi=[result objectForKey:@"xing"];
        
        _str_qiyuan=[result objectForKey:@"intro"];
        
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"随机查询姓氏失败,请重新输入查询"];
    }
    
    [_tableview reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
