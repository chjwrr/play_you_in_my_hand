//
//  PFXiaoTuViewController.m
//  ModelProduct
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFXiaoTuViewController.h"


#import "PFXiaoHuaViewController.h"
#import "PFQuTuViewController.h"

@interface PFXiaoTuViewController ()

@property (nonatomic,strong) UISegmentedControl *segmentCtrl;
@property (nonatomic,strong) UIView *navView;

@property (nonatomic,strong)PFXiaoHuaViewController *xiaoVC;
@property (nonatomic,strong)PFQuTuViewController *tuVC;


@property (nonatomic,strong)BaseViewController *currentVC;

@end

@implementation PFXiaoTuViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    _segmentCtrl=[[UISegmentedControl alloc]initWithItems:@[@"笑话",@"趣图"]];
    _segmentCtrl.frame=CGRectMake((kSCREEN_WIDTH-200)/2, 5, 200, 30);
    [_navView addSubview:_segmentCtrl];
    _segmentCtrl.tintColor=[UIColor whiteColor];
    _segmentCtrl.selectedSegmentIndex=0;
    [_segmentCtrl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    [_segmentCtrl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [_segmentCtrl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    
    [self.navigationController.navigationBar addSubview:_segmentCtrl];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_segmentCtrl removeFromSuperview];
    _segmentCtrl  = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initDataSource {
    [self initLeftNavigationBarButtonWithImage:@"PF_back"];
    
}

- (void)initSubViews {
    [self initLeftNavigationBarButtonWithImage:@"PF_back"];
    
    self.currentVC=[[BaseViewController alloc]init];
    
    self.xiaoVC=[[PFXiaoHuaViewController alloc]init];
    [self addChildViewController:self.xiaoVC];
    
    self.tuVC=[[PFQuTuViewController alloc]init];
    [self addChildViewController:self.tuVC];
    
    [self.view addSubview:self.xiaoVC.view];
    
    self.currentVC=self.xiaoVC;
    
  

}

- (void)segmentAction:(UISegmentedControl *)segmentCtrl {
    if (segmentCtrl.selectedSegmentIndex == 0) {
        [self changeViewController:self.currentVC ToNewViewController:self.xiaoVC];
    }else{
        [self changeViewController:self.currentVC ToNewViewController:self.tuVC];
    }
}

- (void)changeViewController:(BaseViewController *)oldVC ToNewViewController:(BaseViewController *)newVC {
    [self addChildViewController:newVC];

    [self transitionFromViewController:oldVC toViewController:newVC duration:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        oldVC.view.alpha=0.0;
        newVC.view.alpha=1.0;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            [newVC didMoveToParentViewController:self];
            [oldVC willMoveToParentViewController:nil];
            [oldVC removeFromParentViewController];
            self.currentVC = newVC;
            
        }else{
            
            self.currentVC = oldVC;
            
        }
    }];
    
}


@end
