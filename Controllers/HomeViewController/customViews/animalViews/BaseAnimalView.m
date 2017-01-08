//
//  BaseAnimalView.m
//  贝塞尔曲线
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import "BaseAnimalView.h"

@implementation BaseAnimalView

- (CGFloat)W {
    return self.frame.size.width;
}

- (CGFloat)H {
    return self.frame.size.height;
}

- (CGFloat)downH {
    return self.W/2-40;
}

- (CGFloat)h {
    return (self.H-self.downH-40)/6;
}
- (void)startAnimal {
    
}

- (void)endAnimal {
    
    UIImageView *imageView1=(UIImageView *)[self viewWithTag:100];
    UIImageView *imageView2=(UIImageView *)[self viewWithTag:101];
    UIImageView *imageView3=(UIImageView *)[self viewWithTag:102];
    UIImageView *imageView4=(UIImageView *)[self viewWithTag:103];
    UIImageView *imageView5=(UIImageView *)[self viewWithTag:104];
    UIImageView *imageView6=(UIImageView *)[self viewWithTag:105];
    UIImageView *imageView7=(UIImageView *)[self viewWithTag:106];
    
    [self animal:imageView1 WithChangePoint:CGPointMake(40, self.H-self.downH-40) WithRemovePoint:CGPointMake(-100, self.H-self.downH-40)];
    [self animal:imageView3 WithChangePoint:CGPointMake(40, self.H-self.downH-self.h*2-40) WithRemovePoint:CGPointMake(-100,self. H-self.downH-40-self.h*2)];
    [self animal:imageView5 WithChangePoint:CGPointMake(40, self.H-self.downH-self.h*4-40) WithRemovePoint:CGPointMake(-100, self.H-self.downH-40-self.h*4)];
    
    [self animal:imageView2 WithChangePoint:CGPointMake(self.W-kimageWidth-40, self.H-self.downH-self.h*1-40) WithRemovePoint:CGPointMake(self.W+20, self.H-self.downH-self.h*1-40)];
    [self animal:imageView4 WithChangePoint:CGPointMake(self.W-kimageWidth-40, self.H-self.downH-self.h*3-40) WithRemovePoint:CGPointMake(self.W+20, self.H-self.downH-self.h*3-40)];
    [self animal:imageView6 WithChangePoint:CGPointMake(self.W-kimageWidth-40, self.H-self.downH-self.h*5-40) WithRemovePoint:CGPointMake(self.W+20, self.H-self.downH-self.h*5-40)];
    
    [self animal:imageView7 WithChangePoint:CGPointMake(self.W/2-40,40+20) WithRemovePoint:CGPointMake(self.W/2-40,-100)];
    
}
- (void)animal:(UIImageView *)imageView WithChangePoint:(CGPoint)changePoint WithRemovePoint:(CGPoint)removePoint{
    [UIView animateWithDuration:0.15 animations:^{
        imageView.frame=CGRectMake(changePoint.x, changePoint.y, kimageWidth, kimageWidth);
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.1 animations:^{
                imageView.frame=CGRectMake(removePoint.x, removePoint.y, kimageWidth, kimageWidth);
            } completion:^(BOOL finished) {
                if (finished) {
                    [imageView removeFromSuperview];
                }
            }];
        }
    }];
    
}

@end
