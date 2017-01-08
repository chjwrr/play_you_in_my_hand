//
//  XiaoHuaViewController.m
//  ModelProduct
//
//  Created by apple on 16/2/24.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFXiaoHuaViewController.h"
#import "PFXiaoHuaCell.h"
#import "PFXiaoHuaModel.h"
@interface PFXiaoHuaViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong)UITableView *tableview;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic)NSInteger rowCount;

@end

@implementation PFXiaoHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"笑话";
    
    [self initLeftNavigationBarButtonWithImage:@"PF_back"];
    
//进入刷新
    [self BeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initDataSource {
    _dataSource=[[NSMutableArray alloc]init];
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
    
     PFXiaoHuaModel *model=[_dataSource objectAtIndex:indexPath.row];
    
    return [PFXiaoHuaCell CellHeightWithData:model.content];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr=@"cellStr";
    PFXiaoHuaCell *cell=(PFXiaoHuaCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell=[[PFXiaoHuaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([_dataSource count] <= indexPath.row) {
    }else{
        PFXiaoHuaModel *model=[_dataSource objectAtIndex:indexPath.row];
        
        [cell cellForData:model.content];
    }
    
    return cell;
}

//HTTP
- (void)getDataFromRequest {
    NSDictionary * diction=@{@"key":xiao_hua_zui_xin_key,
                             @"page":[NSString stringWithFormat:@"%ld",(long)self.rowCount],
                             @"rows":@"20"};
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:xiao_hua_zui_xin_DTAPI params:diction isHeader:NO LoadingBolck:^{
        
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
            PFXiaoHuaModel *model=[[PFXiaoHuaModel alloc]init];
            [model setValuesForKeysWithDictionary:diction];
            [_dataSource addObject:model];
        }
    
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"笑话获取失败，请重试"];
        if (self.rowCount == 1) {
        }else
            self.rowCount--;
    }
    
    [self.tableview reloadData];
    
    [self endRefresh];
    
}



@end
