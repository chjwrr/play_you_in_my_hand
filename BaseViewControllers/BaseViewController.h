//
//  BaseViewController.h
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^LeftNarBarBlock)(void);
typedef void(^RightNarBarBlock)(void);

typedef void(^RightNarBarBlockLeft)(void);
typedef void(^RightNarBarBlockRight)(void);

@interface BaseViewController : UIViewController

@property (nonatomic,copy)LeftNarBarBlock leftNavBarBlock;
@property (nonatomic,copy)RightNarBarBlock rightNavBarBlock;
@property (nonatomic,copy)RightNarBarBlockLeft rightNavBarBlockLeft;
@property (nonatomic,copy)RightNarBarBlockRight rightNavBarBlockRight;

@property (nonatomic,strong)UIButton *btn_nav_right;


- (void)popAction;

- (void)initDataSource;

- (void)initSubViews;

- (void)initLeftNavigationBarButtonWithImage:(NSString *)imageName;

- (void)initLeftNavigationBarButtonWithtTitle:(NSString *)title;

- (void)initRightNavigationBarButtonWithtTitle:(NSString *)title;

- (void)initRithBottomNavigationBarButtonWithTitle:(NSString *)title;

- (void)initRithNavigationBarButtonWithImage:(NSString *)imageName;

- (void)initRithNavigationBarButtonWithDoubleImage:(NSString *)imageName1 otherImage:(NSString *)imageName2;

- (MJRefreshNormalHeader *)addTableViewHeaderRefreshingTarget:(id)target refreshingAction:(SEL)action;

- (MJRefreshBackNormalFooter *)addTableViewFooterRefreshingTarget:(id)target refreshingAction:(SEL)action;

- (void)headerRefreshHiddent:(BOOL)hiddent;

- (void)footerRefreshHiddent:(BOOL)hiddent;

- (void)headerEndRefresh;

- (void)footerEndRefresh;

- (void)endRefresh;

- (void)BeginRefreshing;

- (UIImage *)getNowViewImage;

@end
