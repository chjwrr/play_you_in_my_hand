//
//  DictionaryViewController.m
//  ModelProduct
//
//  Created by apple on 16/2/23.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFDictionaryViewController.H"
#import "PFCiHaiCustomCell.h"
#import "PFDictionModel.h"

@interface PFDictionaryViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataSource;


@end

@implementation PFDictionaryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"新华字典";
}

- (void)initDataSource {
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
    _searchBar.placeholder=@"搜索字词";
    
    
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNAVIGATIONBAR_HEIGHT-kSTATUSBAR_HEIGHT-44)];
    [self.view addSubview:_tableview];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableview.sectionIndexBackgroundColor = [UIColor clearColor];
    _tableview.sectionIndexColor = [UIColor redColor];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [_dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     PFDictionModel*model=[_dataSource objectAtIndex:indexPath.section];
    
    NSString *content=[NSString stringWithFormat:@"拼音:%@\n读音:%@\n笔画:%@\n简介:%@\n详解:%@",model.pinyin,model.duyin,model.bihua,model.jianjie,model.xiangjie];
    
    
    return [PFCiHaiCustomCell CellHeightWithData:content]+20;
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
        
        PFDictionModel *model=[_dataSource objectAtIndex:indexPath.section];
        
        NSString *content=[NSString stringWithFormat:@"拼音:%@\n读音:%@\n笔画:%@\n简介:%@\n详解:%@",model.pinyin,model.duyin,model.bihua,model.jianjie,model.xiangjie];

        [cell cellForData:content];
    }
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([_dataSource count] <= section) {
        return nil;
    }else{
        PFDictionModel *model=[_dataSource objectAtIndex:section];
        
        
        UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
        headview.backgroundColor=kviewlightbgColor;
        
        UILabel *lab_title=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, kSCREEN_WIDTH-20, 30)];
        [headview addSubview:lab_title];
        lab_title.text=model.hanzi;
        lab_title.font=kSYS_BOLDFONT(14);
        lab_title.textColor=[UIColor redColor];
        return headview;
    }
}

//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    
//    
//    return [_searchBar.text componentsSeparatedByString:@""];
//}

//HTTP
- (void)getDataFromRequestWithSearchItem:(NSString *)searchString {
    
    NSDictionary * diction=@{@"key":xin_hua_zi_dian_key,
                             @"content":searchString};
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:xin_hua_zi_dian_DTAPI params:diction isHeader:NO LoadingBolck:^{
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
            PFDictionModel *model=[[PFDictionModel alloc]init];
            [model setValuesForKeysWithDictionary:diction];
            [_dataSource addObject:model];
        }
        [self.tableview reloadData];

    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"查询失败，请重试"];
    }
 
    
    
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
