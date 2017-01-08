//
//  PF_ShowMoreItemView.h
//  贝塞尔曲线
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAnimalView.h"

@protocol PF_ShowMoreItemViewDelegate <NSObject>

- (void)didSelectShowMoreItem;

- (void)didSelectShowMoreItemWithIndex:(NSInteger)index;

@end

@interface PF_ShowMoreItemView : BaseAnimalView

@property (nonatomic,weak)id<PF_ShowMoreItemViewDelegate>moreDelegate;

+ (CGFloat)ViewHeight;


@end
