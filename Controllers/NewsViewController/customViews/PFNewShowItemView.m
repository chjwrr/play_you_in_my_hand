//
//  MWDDetailRightNavView.m
//  ModelProduct
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFNewShowItemView.h"

@implementation PFNewShowItemView


- (void)initSubView {
    
}

- (void)showItems {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    
    NSArray *items=@[@"微信热门",
                     @"社会新闻",
                     @"国内新闻",
                     @"国际新闻",
                     @"美女图片",
                     @"科技新闻",
                     @"娱乐花边",
                     @"体育新闻",
                     @"旅游热点",
                     @"奇闻异事",
                     @"苹果新闻",
                     @"健康咨询"];
    
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0.5;
    [self addSubview:bgView];
    
    bgView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remoMySelf)];
    [bgView addGestureRecognizer:tap];
    
    
    UIImageView *bgimageV=[[UIImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-120-10, 64, 120, 30+5*40)];
    [self addSubview:bgimageV];
    [bgimageV setImage:[[UIImage imageNamed:@"home_detail_right_top"]stretchableImageWithLeftCapWidth:10 topCapHeight:15]];

    UIScrollView *topView=[[UIScrollView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-120-10, 64+20, 120, 5*40)];
    [self addSubview:topView];
    topView.contentSize=CGSizeMake(120, [items count]*40);
    
   

    
    
    for (int i=0; i<[items count]; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 5+40*i, 120, 40)];
        [topView addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag=100+i;
        [button setTitle:[items objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    

    [[UIApplication sharedApplication].keyWindow addSubview:self];

}

- (void)remoMySelf {
    
    [self removeFromSuperview];
    
}

- (void)buttonAction:(UIButton *)button {

    [_delegate didSelectPFNewShowItemViewButtonWithIndex:button.tag-100];
    
    
    [self remoMySelf];
}


@end
