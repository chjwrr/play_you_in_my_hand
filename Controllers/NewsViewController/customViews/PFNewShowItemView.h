//
//  MWDDetailRightNavView.h
//  ModelProduct
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFBaseView.h"

@protocol PFNewShowItemViewDelegate <NSObject>

- (void)didSelectPFNewShowItemViewButtonWithIndex:(NSInteger)index;

@end

@interface PFNewShowItemView  : PFBaseView


@property (nonatomic,weak)id<PFNewShowItemViewDelegate>delegate;

- (void)showItems;

@end
