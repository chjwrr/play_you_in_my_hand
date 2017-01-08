//
//  PFChooseItemView.m
//  ModelProduct
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFChooseItemView.h"

#define viewWidth      100.0f


@interface PFChooseItemView (){
    UIScrollView *scrollview;
    NSArray *images;
    NSArray *titles;
}

@property (nonatomic,assign)ItemViewFromDirection direction;

@end

@implementation PFChooseItemView

+ (instancetype)shareInstance {
    static PFChooseItemView *itemView;
    static dispatch_once_t abc;
    
    dispatch_once(&abc, ^{
        itemView=[[PFChooseItemView alloc]initWithFrame:CGRectMake(0, 0, 0, kSCREEN_HEIGHT)];
    });
    return itemView;
    
}

- (void)setTitleDataSource:(NSArray *)titledataSource ImageDataSource:(NSArray *)imageDataSource {
    images=imageDataSource;
    titles=titledataSource;
    
    
    UIImageView *bgimageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, kSCREEN_HEIGHT)];
    [self addSubview:bgimageV];
    bgimageV.backgroundColor=[UIColor whiteColor];
    bgimageV.alpha=0.8;
    
    
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, kSCREEN_HEIGHT)];
    [self addSubview:scrollview];
    scrollview.contentSize=CGSizeMake(viewWidth, 20+12*110+20);
    
    for (int i=0; i<[titles count]; i++) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 20+110*i, viewWidth, 110)];
        [scrollview addSubview:view];
        
        view.tag=100+i;
        view.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecognizer:)];
        [view addGestureRecognizer:tap];
        
        
        UIImageView *bgimageV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 80, 80)];
        [view addSubview:bgimageV];
        bgimageV.image=kImageName([images objectAtIndex:i]);
        
        UILabel *lab_name=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, viewWidth, 30)];
        [view addSubview:lab_name];
        lab_name.textAlignment=NSTextAlignmentCenter;
        lab_name.textColor=[UIColor redColor];
        lab_name.text=[titles objectAtIndex:i];
        lab_name.font=kSYS_FONT(14);
    }

}


- (void)showFromeDirection:(ItemViewFromDirection)direction {
    scrollview.contentOffset=CGPointMake(0, 0);
    
    _direction=direction;
    

    if (direction == leftDirection) {
        //从左到右
        self.frame=CGRectMake(-viewWidth, 0, viewWidth, kSCREEN_HEIGHT);
        [[UIApplication sharedApplication].keyWindow addSubview:self];

        [UIView animateWithDuration:0.15 animations:^{
            
            self.frame=CGRectMake(0, 0, viewWidth, kSCREEN_HEIGHT);

        } completion:^(BOOL finished) {
            if (finished) {
                
            }
        }];
    }
    if (direction == rightDirection) {
        //从右到左
        self.frame=CGRectMake(kSCREEN_WIDTH, 0, viewWidth, kSCREEN_HEIGHT);
        [[UIApplication sharedApplication].keyWindow addSubview:self];

        [UIView animateWithDuration:0.15 animations:^{

            self.frame=CGRectMake(kSCREEN_WIDTH-viewWidth, 0, viewWidth, kSCREEN_HEIGHT);

        } completion:^(BOOL finished) {
            if (finished) {
                
            }
        }];
    }
    
}


- (void)hiddent{

    if (_direction == leftDirection) {
        //从左到右 隐藏
        
        [UIView animateWithDuration:0.15 animations:^{
            
            self.frame=CGRectMake(-viewWidth, 0, viewWidth, kSCREEN_HEIGHT);
            
        } completion:^(BOOL finished) {
            if (finished) {
            }
        }];
    }
    if (_direction == rightDirection) {
        //从右到左 隐藏
        [UIView animateWithDuration:0.15 animations:^{
            
            self.frame=CGRectMake(kSCREEN_WIDTH, 0, viewWidth, kSCREEN_HEIGHT);
            
        } completion:^(BOOL finished) {
            if (finished) {
            }
        }];
    }
}

- (void)tapRecognizer:(UITapGestureRecognizer *)tap {
    [self hiddent];
    [_delegate didSelectPFChooseItemViewWithIndex:tap.view.tag-100];
}

+ (CGFloat)viewWidht {
    return viewWidth;
}


@end
