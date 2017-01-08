//
//  PF_NewsViewController.m
//  ModelProduct
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFNewsViewController.h"
#import "PFNewShowItemView.h"

#import "PFNewsCustomCell.h"
#import "PFWeiNewsModel.h"

#import "PFNewsDetailViewController.h"

typedef enum : NSUInteger {
    NEWSTYPE_weiXini,
    NEWSTYPE_sheHui,
    NEWSTYPE_guoNei,
    NEWSTYPE_guoJi,
    NEWSTYPE_meiNv,
    NEWSTYPE_keJi,
    NEWSTYPE_yuLe,
    NEWSTYPE_tiYu,
    NEWSTYPE_lvYou,
    NEWSTYPE_qiWen,
    NEWSTYPE_pingGuo,
    NEWSTYPE_jianKang
} NEWSTYPE;

@interface PFNewsViewController ()<PFNewShowItemViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) PFNewShowItemView *topView;

@property(nonatomic,assign) NEWSTYPE newType;

@property (nonatomic,strong)UITableView *tableview;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic)NSInteger rowCount;

@property (nonatomic,strong)NSString *str_server;


@end

@implementation PFNewsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"股掌间";
}

- (void)initDataSource {
    [self initLeftNavigationBarButtonWithImage:@"PF_home"];
    [self initRithBottomNavigationBarButtonWithTitle:@"微信热门"];
    
    
    __weak PFNewsViewController *weakself=self;
    self.rightNavBarBlock=^{
        
        [weakself.topView showItems];
    };
    
    _newType=0;

    
    _dataSource=[[NSMutableArray alloc]init];
    _rowCount = 1;
    
    _str_server=[[NSString alloc]init];
    _str_server=TX_weixin_news_server;

}

- (void)initSubViews {
    _topView=[[PFNewShowItemView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    _topView.delegate=self;
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,kSCREEN_WIDTH,kSCREEN_HEIGHT-64)];
    [self.view addSubview:_tableview];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableview.mj_footer=[self addTableViewFooterRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.tableview.mj_header=[self addTableViewHeaderRefreshingTarget:self refreshingAction:@selector(headerRefresh)];

    [self BeginRefreshing];

}

#pragma UITableViewHeaderRef、footerRef

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
    return [PFNewsCustomCell cellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr=@"PFNewsCell";
    PFNewsCustomCell *cell=(PFNewsCustomCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell=[[PFNewsCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    if ([_dataSource count] <= indexPath.row) {
    }else{
        [cell cellForData:[_dataSource objectAtIndex:indexPath.row]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFWeiNewsModel *model=[_dataSource objectAtIndex:indexPath.row];
    PFNewsDetailViewController *detail=[[PFNewsDetailViewController alloc]init];
    detail.detailURL=model.url;
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)getDataFromRequest {
    
    NSDictionary *diction=@{@"key":TX_APIKEY,
                            @"num":@"20",
                            @"page":[NSString stringWithFormat:@"%ld",(long)self.rowCount]};
    
    
    [[AFHTTPClickManager shareInstanceTX] getRequestWithPath:_str_server params:diction isHeader:NO LoadingBolck:^{
        
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
    if ([kFormatterSring([rootDic objectForKey:@"code"]) isEqualToString:@"200"]) {
        //请求成功
        
        NSArray *list=[rootDic objectForKey:@"newslist"];
        
        for (int i=0; i<[list count]; i++) {
            NSDictionary *diction=[list objectAtIndex:i];
            PFWeiNewsModel *model=[[PFWeiNewsModel alloc]init];
            [model setValuesForKeysWithDictionary:diction];
            
            [_dataSource addObject:model];
        }
        
        [self.tableview reloadData];
        
    }else{
        [[PFProgressHUB shareInstance] showWithContent:@"新闻获取失败，请重试"];
        if (self.rowCount == 1) {
        }else
            self.rowCount-=1;
    }
    
    [self endRefresh];
    
}




/**
 *  PFNewShowItemView Delegate
 *
 *  @param index 选择新闻列表
 */
- (void)didSelectPFNewShowItemViewButtonWithIndex:(NSInteger)index {
    
    if (index == _newType) {
        return;
    }
    
    switch (index) {
        case 0:{
            //微信热门
            [self.btn_nav_right setTitle:@"微信热门" forState:UIControlStateNormal];
            _str_server=TX_weixin_news_server;
        }
            break;
        case 1:{
            //社会新闻
            [self.btn_nav_right setTitle:@"社会新闻" forState:UIControlStateNormal];
            _str_server=TX_shehui_news_server;

        }
            break;
        case 2:{
            //国内新闻
            [self.btn_nav_right setTitle:@"国内新闻" forState:UIControlStateNormal];
            _str_server=TX_guonei_news_server;

        }
            break;
        case 3:{
            //国际新闻
            [self.btn_nav_right setTitle:@"国际新闻" forState:UIControlStateNormal];
            _str_server=TX_guoji_news_server;

        }
            break;
        case 4:{
            //美女图片
            [self.btn_nav_right setTitle:@"美女图片" forState:UIControlStateNormal];
            _str_server=TX_meinv_news_server;

        }
            break;
        case 5:{
            //科技新闻
            [self.btn_nav_right setTitle:@"科技新闻" forState:UIControlStateNormal];
            _str_server=TX_keji_news_server;

        }
            break;
        case 6:{
            //娱乐花边
            [self.btn_nav_right setTitle:@"娱乐花边" forState:UIControlStateNormal];
            _str_server=TX_yule_news_server;

        }
            break;
        case 7:{
            //体育新闻
            [self.btn_nav_right setTitle:@"体育新闻" forState:UIControlStateNormal];
            _str_server=TX_tiyu_news_server;
        }
            break;
        case 8:{
            //旅游热点
            [self.btn_nav_right setTitle:@"旅游热点" forState:UIControlStateNormal];
            _str_server=TX_lvyou_news_server;
        }
            break;
        case 9:{
            //奇闻异事
            [self.btn_nav_right setTitle:@"奇闻异事" forState:UIControlStateNormal];
            _str_server=TX_qiwen_news_server;
        }
            break;
        case 10:{
            //苹果新闻
            [self.btn_nav_right setTitle:@"苹果新闻" forState:UIControlStateNormal];
            _str_server=TX_pingguo_news_server;
        }
            break;
        case 11:{
            //健康咨询
            [self.btn_nav_right setTitle:@"健康咨询" forState:UIControlStateNormal];
            _str_server=TX_jiankang_news_server;
        }
            break;
        default:
            break;
    }
    
    _newType = index;
    
    [self BeginRefreshing];

}





@end
