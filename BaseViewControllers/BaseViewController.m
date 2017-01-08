//
//  BaseViewController.m
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "BaseViewController.h"



@interface BaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)MJRefreshNormalHeader *header;
@property (nonatomic,strong)MJRefreshBackNormalFooter *footer;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    if (kIOS_VERSION >= 7.0) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.modalPresentationCapturesStatusBarAppearance = NO;
//    }
//    

    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initDataSource];
    
    [self initSubViews];
    self.navigationController.interactivePopGestureRecognizer.delegate=self;
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }
 
    return YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)initDataSource {
    
}
- (void)initSubViews {
    
}

- (void)initLeftNavigationBarButtonWithImage:(NSString *)imageName {
    UIButton *btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_left setImage:kImageName(imageName) forState:UIControlStateNormal];
    [btn_left addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_left];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.leftBarButtonItems=@[space,bar];
}

- (void)initLeftNavigationBarButtonWithtTitle:(NSString *)title {
    UIButton *btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_left setTitle:title forState:UIControlStateNormal];
    [btn_left addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_left];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.leftBarButtonItems=@[space,bar];
}
- (void)initRightNavigationBarButtonWithtTitle:(NSString *)title {
    UIButton *btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_left setTitle:title forState:UIControlStateNormal];
    [btn_left addTarget:self action:@selector(RightAction) forControlEvents:UIControlEventTouchUpInside];
    btn_left.titleLabel.font=kSYS_FONT(14);
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_left];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar];
}

- (void)initRithBottomNavigationBarButtonWithTitle:(NSString *)title {
    _btn_nav_right=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [_btn_nav_right setTitle:title forState:UIControlStateNormal];
    [_btn_nav_right addTarget:self action:@selector(RightAction) forControlEvents:UIControlEventTouchUpInside];
    _btn_nav_right.titleLabel.font=kSYS_FONT(14);
    _btn_nav_right.titleEdgeInsets=UIEdgeInsetsMake(24, 0, 0, 1);
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:_btn_nav_right];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar];
}

- (void)initRithNavigationBarButtonWithImage:(NSString *)imageName {
    UIButton *btn_right=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_right setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn_right addTarget:self action:@selector(RightAction) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_right];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar];
}

- (void)initRithNavigationBarButtonWithDoubleImage:(NSString *)imageName1 otherImage:(NSString *)imageName2 {
    UIButton *btn_right=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    btn_right.tag=101;
    //[btn_right setImage:[UIImage imageNamed:imageName1] forState:UIControlStateNormal];
    [btn_right addTarget:self action:@selector(doubleRightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn_right1=[[UIButton alloc]initWithFrame:CGRectMake(44, 0, 44, 44)];
    [btn_right1 setBackgroundColor:[UIColor greenColor]];
    //[btn_right1 setImage:[UIImage imageNamed:imageName1] forState:UIControlStateNormal];
    [btn_right1 addTarget:self action:@selector(doubleRightAction:) forControlEvents:UIControlEventTouchUpInside];
    btn_right1.tag=100;

    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_right];
    UIBarButtonItem *bar1=[[UIBarButtonItem alloc]initWithCustomView:btn_right1];

    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar,space,bar1,space];
}

- (void)popAction {
    [AFHTTPClickManager cancelRequest];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)RightAction {
    self.rightNavBarBlock();
}
- (void)doubleRightAction:(UIButton *)button {
    if (button.tag == 100) {
        self.rightNavBarBlockLeft();
    }else
        self.rightNavBarBlockRight();
        
}

//tableview下拉刷新  上拉加载

/*
 self.tableview.mj_header=[self addTableViewRefreshHeaderWithTarget:self action:@selector(headerRefresh)];
 self.tableview.mj_footer=[self addTableViewRefreshFooterWithTarget:self action:@selector(footerRefresh)];

 */
- (MJRefreshNormalHeader *)addTableViewHeaderRefreshingTarget:(id)target refreshingAction:(SEL)action {
    _header=[MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    _header.stateLabel.hidden=YES;
    _header.lastUpdatedTimeLabel.hidden=YES;
    return _header;
}

- (MJRefreshBackNormalFooter *)addTableViewFooterRefreshingTarget:(id)target refreshingAction:(SEL)action {
    _footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    return _footer;
}
- (void)headerRefreshHiddent:(BOOL)hiddent {
    self.header.hidden=hiddent;
}
- (void)footerRefreshHiddent:(BOOL)hiddent {
    self.footer.hidden=hiddent;
}
- (void)headerEndRefresh {
    [self.header endRefreshing];
}
- (void)footerEndRefresh {
    [self.footer endRefreshing];
}
- (void)endRefresh {
    [self.header endRefreshing];
    [self.footer endRefreshing];
}
- (void)BeginRefreshing {
    [self.header beginRefreshing];
}


- (UIImage *)getNowViewImage {
    //获取当前屏幕截图
    UIGraphicsBeginImageContext(self.view.bounds.size);     //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文

    return viewImage;
}




@end
