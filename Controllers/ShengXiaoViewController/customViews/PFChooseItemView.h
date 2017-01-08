//
//  PFChooseItemView.h
//  ModelProduct
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFBaseView.h"

typedef enum : NSUInteger {
    leftDirection,
    rightDirection
} ItemViewFromDirection;;

@protocol PFChooseItemViewDelegate <NSObject>


- (void)didSelectPFChooseItemViewWithIndex:(NSInteger)index;

@end

@interface PFChooseItemView : PFBaseView

@property (nonatomic,weak)id<PFChooseItemViewDelegate>delegate;
@property (nonatomic,strong)NSArray *dataSource;

+ (instancetype)shareInstance;

- (void)setTitleDataSource:(NSArray *)titledataSource ImageDataSource:(NSArray *)imageDataSource;

- (void)showFromeDirection:(ItemViewFromDirection)direction;

- (void)hiddent;

@end
