//
//  PFDreamViewController.m
//  ModelProduct
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFDreamViewController.h"

#import "PFDreamItemView.h"
#import "PFDreamSearchEndViewController.h"
#import "PFDreamTypeViewController.h"

@interface PFDreamViewController ()<UISearchBarDelegate,PFDreamItemViewDelegate>

@property (nonatomic,strong)UISearchBar *searchBar;

@end

@implementation PFDreamViewController
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
    lab_title.text=@"梦者,魇也";
    lab_title.textColor=kColorHexString(@"673ab7");
    lab_title.font=kSYS_FONT(23);
    
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(10, 64, kSCREEN_WIDTH-20, 44)];
    _searchBar.backgroundImage=[[UIImage alloc]init];
    
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
    _searchBar.placeholder=@"搜索梦到的关键字";
    
    [self.view addSubview:_searchBar];
    

    PFDreamItemView *itemView=[[PFDreamItemView alloc]initWithFrame:CGRectMake(30, 108, kSCREEN_WIDTH-60, kSCREEN_HEIGHT-108-20)];
    itemView.delegate=self;
    [self.view addSubview:itemView];
}

/**
 *  返回上一级
 */
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  PFDreamItemView Delegate
 *
 *  @param index item tag
 */
- (void)didSelectPFDreamItemViewWithItemType:(NSString *)type {
    
    PFDreamTypeViewController *searchVC=[[PFDreamTypeViewController alloc]init];
    searchVC.str_type=type;
    [self.navigationController pushViewController:searchVC animated:YES];

}

#pragma UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text isEmpty]) {
        return;
    }
    
    [searchBar resignFirstResponder];
    
    
    PFDreamSearchEndViewController *searchVC=[[PFDreamSearchEndViewController alloc]init];
    searchVC.str_keyWord=searchBar.text;
    [self.navigationController pushViewController:searchVC animated:YES];
    
}




@end
