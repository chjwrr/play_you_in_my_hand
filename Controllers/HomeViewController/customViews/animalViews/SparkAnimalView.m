//
//  SparkAnimalView.m
//  贝塞尔曲线
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import "SparkAnimalView.h"

@interface SparkAnimalView (){
    
    int count;
    NSArray *endpoints;
    NSArray *startpoints;

    CALayer *layerAnimal;
    
    NSArray *titles;
    NSArray *images;
    
}
@end

@implementation SparkAnimalView

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
     
        
        count=0;
        
        
        startpoints=@[[NSValue valueWithCGPoint:CGPointMake(40, self.H-self.downH)],
                 [NSValue valueWithCGPoint:CGPointMake(self.W-40, self.H-self.downH-self.h)],
                 [NSValue valueWithCGPoint:CGPointMake(40, self.H-self.downH-self.h*2)],
                 [NSValue valueWithCGPoint:CGPointMake(self.W-40, self.H-self.downH-self.h*3)],
                 [NSValue valueWithCGPoint:CGPointMake(40, self.H-self.downH-self.h*4)],
                 [NSValue valueWithCGPoint:CGPointMake(self.W-40,self. H-self.downH-self.h*5)],
                 [NSValue valueWithCGPoint:CGPointMake(self.W/2, 40)]];

        
        endpoints=@[[NSValue valueWithCGPoint:CGPointMake(40-kimageWidth/2, self.H-self.downH-40)],
                 [NSValue valueWithCGPoint:CGPointMake(self.W-40-kimageWidth/2, self.H-self.downH-self.h-40)],
                 [NSValue valueWithCGPoint:CGPointMake(40-kimageWidth/2, self.H-self.downH-self.h*2-40)],
                 [NSValue valueWithCGPoint:CGPointMake(self.W-40-kimageWidth/2, self.H-self.downH-self.h*3-40)],
                 [NSValue valueWithCGPoint:CGPointMake(40-kimageWidth/2, self.H-self.downH-self.h*4-40)],
                 [NSValue valueWithCGPoint:CGPointMake(self.W-40-kimageWidth/2, self.H-self.downH-self.h*5-40)],
                 [NSValue valueWithCGPoint:CGPointMake(self.W/2-40, 40-kimageWidth/2)]];
        
        titles=@[@"辞海",@"名人名言",@"急转弯",@"成语",@"歇后语",@"新华字典",@"姓氏起源"];
        images=@[@"PF_home_ci_hai",@"PF_home_ming_yan",@"PF_home_ji_zhuan_wan",@"PF_home_cheng_yu",@"PF_home_xie_hou_yu",@"PF_home_zi_dian",@"PF_home_xing_shi_qi_yuan"];

        
    }
    return self;
}
- (void)startAnimal {
    count=0;

    for (int i=0; i<7; i++) {
        
        [self performSelector:@selector(showAnimal) withObject:nil afterDelay:ktime*(i+1)];
        
    }
    
}
- (void)showAnimal {
  
    
    if (count >= [startpoints count]) {
        
        return;
    }
    
    
    NSValue *startvalues=[startpoints objectAtIndex:count];
    
    CGPoint startpoint=[startvalues CGPointValue];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(startpoint.x ,startpoint.y, 0, 0)];
    view.layer.cornerRadius=kimageWidth/2;
    view.layer.masksToBounds=YES;
    view.tag=100+count;
    [self addSubview:view];
    view.layer.borderWidth=0.5;
    view.layer.borderColor=[UIColor redColor].CGColor;
    
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(10 ,0, kimageWidth-20, kimageWidth-20)];
    [view addSubview:imageView1];
    imageView1.image=kImageName([images objectAtIndex:count]);
    
    
    UILabel *lab_title=[[UILabel alloc]initWithFrame:CGRectMake(0, kimageWidth-20, kimageWidth, 20)];
    [view addSubview:lab_title];
    lab_title.textAlignment=NSTextAlignmentCenter;
    lab_title.font=kSYS_FONT(10);
    lab_title.textColor=[UIColor redColor];
    lab_title.text=[titles objectAtIndex:count];
    
    UITapGestureRecognizer *imageVtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemAction:)];
    view.userInteractionEnabled=YES;
    [view addGestureRecognizer:imageVtap];
    

    
    NSValue *endvalues=[endpoints objectAtIndex:count];
    
    CGPoint endpoint=[endvalues CGPointValue];
    
    [UIView animateWithDuration:0.25 animations:^{
        view.frame=CGRectMake(endpoint.x ,endpoint.y, kimageWidth, kimageWidth);
        
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
    count++;

    
    if (count == 7) {
        self.completeBlock();
    }
    

}
- (void)itemAction:(UITapGestureRecognizer *)recognizer {
    [self.delegate didSelectAnimalViewWithIndex:recognizer.view.tag-100];
}
@end
