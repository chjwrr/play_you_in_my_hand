//
//  BaseAnimalView.h
//  贝塞尔曲线
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kimageWidth                  74
#define ktime                        0.1

typedef void(^AnimalViewComplete)(void);

@protocol AnimalViewDelegate <NSObject>

- (void)didSelectAnimalViewWithIndex:(NSInteger)index;

@end

@interface BaseAnimalView : UIView

@property (nonatomic,assign)CGFloat W;
@property (nonatomic,assign)CGFloat H;
@property (nonatomic,assign)CGFloat downH;
@property (nonatomic,assign)CGFloat h;


@property (nonatomic,weak)id<AnimalViewDelegate>delegate;
@property (nonatomic,copy)AnimalViewComplete completeBlock;
- (void)startAnimal;

- (void)endAnimal;

@end
