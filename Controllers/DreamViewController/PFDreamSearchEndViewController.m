//
//  PFDreamSearchEndViewController.m
//  ModelProduct
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFDreamSearchEndViewController.h"
#import "PFDreamModel.h"
#import "PFDreamCell.h"
@interface PFDreamSearchEndViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic)NSInteger pageCount;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)UITableView *tableview;

@property (nonatomic,assign)BOOL isOpen;
@property (nonatomic,assign)NSInteger selectSection;

@end

@implementation PFDreamSearchEndViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)initDataSource {
    _pageCount=1;
    _dataSource=[[NSMutableArray alloc]init];
    _isOpen=NO;
    _selectSection=0;
}

- (void)initSubViews {
    
    UIImageView *bgimageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [self.view addSubview:bgimageV];
    bgimageV.image=kImageName(@"PF_dream_bgimage.jpg");
    
    
    UIButton *btn_left=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 44, 44)];
    [btn_left setImage:kImageName(@"PF_back_long") forState:UIControlStateNormal];
    [btn_left addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_left];
    
    UILabel *lab_title=[[UILabel alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-200)/2, 20, 200, 44)];
    [self.view addSubview:lab_title];
    lab_title.textAlignment=NSTextAlignmentCenter;

    if ([_str_keyWord hasPrefix:@"梦见"] || [_str_keyWord hasPrefix:@"梦到"]) {
        lab_title.text=_str_keyWord;
    }else
        lab_title.text=[NSString stringWithFormat:@"梦见%@",_str_keyWord];
    
    lab_title.textColor=kColorHexString(@"673ab7");
    lab_title.font=kSYS_FONT(23);
    
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(20, kNAVIGATIONBAR_HEIGHT+kSTATUSBAR_HEIGHT, kSCREEN_WIDTH-40, kSCREEN_HEIGHT-kNAVIGATIONBAR_HEIGHT-kSTATUSBAR_HEIGHT-20)];
    [self.view addSubview:_tableview];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableview.mj_footer=[self addTableViewFooterRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.tableview.mj_header=[self addTableViewHeaderRefreshingTarget:self refreshingAction:@selector(headerRefresh)];

    [self getKeyWordDataFromRequest];

}

#pragma UITableViewHeaderRef、footerRef

- (void)headerRefresh {
    
    [self footerRefreshHiddent:NO];
    
    self.pageCount = 1;
    
    [self getKeyWordDataFromRequest];
    
}
- (void)footerRefresh {
    
    self.pageCount+=1;
    
    [self getKeyWordDataFromRequest];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [_dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isOpen) {
        
        if (section == _selectSection) {
            return 1;
        }
        
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PFDreamModel *model=[_dataSource objectAtIndex:indexPath.section];
    
    return [PFDreamCell CellHeightWithData:model.content];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr=@"cellStr";
    PFDreamCell *cell=(PFDreamCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell=[[PFDreamCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([_dataSource count] <= indexPath.section) {
    }else{
        
        PFDreamModel *model=[_dataSource objectAtIndex:indexPath.section];
        [cell cellForData:model.content];
    }
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([_dataSource count] <= section) {
        return nil;
    }else{
        PFDreamModel *model=[_dataSource objectAtIndex:section];
        
        CGFloat width=[model.title getStringWidthSizeHeight:20 WithFontSize:14];
        
        
        UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 50)];
        
        UIImageView *_bgimageV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, width+20, 30)];
        [headview addSubview:_bgimageV];
        _bgimageV.image=kImageName(@"PF_dream_title_bgimage");
        _bgimageV.layer.cornerRadius=3;
        _bgimageV.layer.masksToBounds=YES;
        
        
        UILabel *lab_title=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, width, 20)];
        [headview addSubview:lab_title];
        lab_title.text=model.title;
        lab_title.font=kSYS_BOLDFONT(14);
        lab_title.textColor=[UIColor whiteColor];
        
        
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
        [headview addSubview:button];
        button.tag=100+section;
        [button addTarget:self action:@selector(buttonHeadAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return headview;
    }
}

- (void)buttonHeadAction:(UIButton *)button {
    
    if (_selectSection == button.tag-100) {
        _isOpen =! _isOpen;
    }else
        _isOpen = YES;
    
    
    _selectSection=button.tag-100;
    
    [self.tableview reloadData];
    
}



/**
 *  返回上一级
 */
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


//关键字查询
- (void)getKeyWordDataFromRequest {
    NSDictionary * diction=@{@"key":jiemengKey,
                             @"page":[NSString stringWithFormat:@"%ld",(long)self.pageCount],
                             @"rows":@"20",
                             @"keyword":_str_keyWord};
    
    [[AFHTTPClickManager shareInstanceDT] getRequestWithPath:ci_yu_jie_meng_DTAPI params:diction isHeader:NO LoadingBolck:^{
        [[PFProgressHUB shareInstance] show];
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        [self performSelectorOnMainThread:@selector(getData:) withObject:respose waitUntilDone:YES];
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{

        [self endRefresh];
    }];
    
}

- (void)getData:(NSDictionary *)rootDic {
    if (self.pageCount == 1) {
        [_dataSource removeAllObjects];
    }
    
    if ([kFormatterSring([rootDic objectForKey:@"error_code"]) isEqualToString:@"0"]) {
        //请求成功
        [[PFProgressHUB shareInstance] dismiss];
        
        NSArray *list=[rootDic objectForKey:@"result"];
        
        for (int i=0; i<[list count]; i++) {
            NSDictionary *diction=[list objectAtIndex:i];
            PFDreamModel *model=[[PFDreamModel alloc]init];
            [model setValuesForKeysWithDictionary:diction];
            [_dataSource addObject:model];
        }
        
        
        if ([list count] <20 ) {
            [self footerRefreshHiddent:YES];
        }
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"查询失败，请重试"];
        if (self.pageCount == 1) {
        }else
            self.pageCount--;
    }
    
    [self.tableview reloadData];
    
    [self endRefresh];
    
}




@end
