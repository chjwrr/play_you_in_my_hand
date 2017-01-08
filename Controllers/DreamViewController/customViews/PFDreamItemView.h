//
//  PFDreamItemView.h
//  ModelProduct
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFBaseView.h"

@protocol PFDreamItemViewDelegate <NSObject>

- (void)didSelectPFDreamItemViewWithItemType:(NSString *)type;

@end

@interface PFDreamItemView : PFBaseView

@property (nonnull,strong)id<PFDreamItemViewDelegate>delegate;

@end
