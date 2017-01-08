//
//  XingXiaoDetailViewController.m
//  ModelProduct
//
//  Created by apple on 16/2/29.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFXingXiaoDetailViewController.h"
#import "PFXingXiaoDetailCell.h"
#import "PFXingZuoModel.h"
#import "PFShengXiaoModel.h"

@interface PFXingXiaoDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *dataSource;
    NSArray *titleSource;

}

@property (nonatomic)NSInteger number;
@property (nonatomic,strong)UITableView *tableview;

@property (nonatomic,strong)PFXingZuoModel *xz_Model;
@property (nonatomic,strong)PFShengXiaoModel *sx_Model;

@property (nonatomic,strong)UIView *navView;

@end

@implementation PFXingXiaoDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    _navView=[[UIView alloc]initWithFrame:CGRectMake(50, 0, kSCREEN_WIDTH-100, kNAVIGATIONBAR_HEIGHT)];
    _navView.backgroundColor=[UIColor redColor];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-100)/2-44-5, 0, 44, 44)];
    [_navView addSubview:imageview];
    imageview.image=kImageName(_str_imageName);
    
    UILabel *lab_title=[[UILabel alloc]initWithFrame:CGRectMake(imageview.frame.size.width+imageview.frame.origin.x+5, 0, 100, 44)];
    [_navView addSubview:lab_title];
    lab_title.textColor=[UIColor whiteColor];
    lab_title.text=_str_title;
    
    
    [self.navigationController.navigationBar addSubview:_navView];

    _navView.alpha=0.0;
    
    [UIView animateWithDuration:0.1 animations:^{
        _navView.alpha=1.0;
    }];
    
    
    
    

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIView animateWithDuration:0.1 animations:^{
        _navView.alpha=0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [_navView removeFromSuperview];
            _navView = nil;
        }
    }];
    
  
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.title=_str_title;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initDataSource {
    
    NSString *filePath=[[NSBundle mainBundle]pathForResource:_str_pathName ofType:@"plist"];
    
    NSDictionary *rootDic=[NSDictionary dictionaryWithContentsOfFile:filePath];
    
    if ([_type isEqualToString:@"0"]) {
        //生肖
        _number=[[rootDic allKeys] count]-1;

        _sx_Model=[[PFShengXiaoModel alloc]init];

        [_sx_Model setValuesForKeysWithDictionary:rootDic];
        
        titleSource=@[_sx_Model.duilian,@"一年总运势",@"流年运势",@"命理",@"性格",@"优点",@"缺点",@"事业",@"爱情",@"财运",@"健康",@"造字姻缘",@"民俗"];

        dataSource=@[_sx_Model.jieshao,_sx_Model.zongyunshi,_sx_Model.liunianyunshi,_sx_Model.mingli,_sx_Model.xingge,_sx_Model.youdian,_sx_Model.quedian,_sx_Model.shiye,_sx_Model.aiqing,_sx_Model.caiyun,_sx_Model.jiankang,_sx_Model.zaoziyinyuan,_sx_Model.minshu];
        
    }else{
        //星座
        _number=[[rootDic allKeys] count];

        _xz_Model=[[PFXingZuoModel alloc]init];

        [_xz_Model setValuesForKeysWithDictionary:rootDic];
        
        
        titleSource=@[@"时间",@"来历",@"传说",@"代表",@"属性",@"符号",@"优点",@"缺点",@"性格",@"心智",@"爱情",@"事业",@"体闲",[NSString stringWithFormat:@"%@父母",_str_title],[NSString stringWithFormat:@"%@子女",_str_title],@"幸运"];

        dataSource=@[_xz_Model.shijian,_xz_Model.laili,_xz_Model.chuanshuo,_xz_Model.daibiao,_xz_Model.shuxing,_xz_Model.fuhao,_xz_Model.youdian,_xz_Model.quedian,_xz_Model.xingge,_xz_Model.xinzhi,_xz_Model.aiqing,_xz_Model.shiye,_xz_Model.tixian,_xz_Model.fumu,_xz_Model.zinv,_xz_Model.xinyun];
        
    }
    
}
- (void)initSubViews {
    [self initLeftNavigationBarButtonWithImage:@"PF_back"];
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    [self.view addSubview:_tableview];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableview.sectionIndexBackgroundColor = [UIColor clearColor];
    _tableview.sectionIndexColor = [UIColor redColor];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  _number;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [PFXingXiaoDetailCell CellHeightWithData:[dataSource objectAtIndex:indexPath.section]];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr=@"cellStr";
    PFXingXiaoDetailCell *cell=(PFXingXiaoDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell=[[PFXingXiaoDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
     [cell cellForData:[dataSource objectAtIndex:indexPath.section]];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
    headview.backgroundColor=kColorHexString(@"fc8b8b");
    
    UILabel *lab_title=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, kSCREEN_WIDTH-20, 30)];
    [headview addSubview:lab_title];
    lab_title.text=[titleSource objectAtIndex:section];
    lab_title.font=kSYS_BOLDFONT(14);
    lab_title.textColor=[UIColor whiteColor];
    return headview;
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *array;
    if ([_type isEqualToString:@"0"]) {
        array=@[@"对联",@"总运",@"年运",@"命理",@"性格",@"优点",@"缺点",@"事业",@"爱情",@"财运",@"健康",@"造字",@"民俗"];
    }else
        array=@[@"时间",@"来历",@"传说",@"代表",@"属性",@"符号",@"优点",@"缺点",@"性格",@"心智",@"爱情",@"事业",@"体闲",@"父母",@"子女",@"幸运"];

    
    return [array objectAtIndex:section];
}


- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    NSArray *array;
    if ([_type isEqualToString:@"0"]) {
        array=@[@"对联",@"总运",@"年运",@"命理",@"性格",@"优点",@"缺点",@"事业",@"爱情",@"财运",@"健康",@"造字",@"民俗"];
    }else
        array=@[@"时间",@"来历",@"传说",@"代表",@"属性",@"符号",@"优点",@"缺点",@"性格",@"心智",@"爱情",@"事业",@"体闲",@"父母",@"子女",@"幸运"];
    
    return array;
}

@end
