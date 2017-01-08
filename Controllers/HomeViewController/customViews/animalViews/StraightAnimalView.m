//
//  StraightAnimalView.m
//  贝塞尔曲线
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import "StraightAnimalView.h"


@interface StraightAnimalView (){

    
    int count;
    NSArray *points;
    
    CALayer *layerAnimal;
    
    NSArray *titles;
    NSArray *images;
    
}
@end

@implementation StraightAnimalView

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
           
        count=0;
        
        
        points=@[[NSValue valueWithCGPoint:CGPointMake(40-kimageWidth/2, self.H-self.downH-40)],
                 [NSValue valueWithCGPoint:CGPointMake(self.W-40-kimageWidth/2, self.H-self.downH-self.h-40)],
                 [NSValue valueWithCGPoint:CGPointMake(40-kimageWidth/2, self.H-self.downH-self.h*2-40)],
                 [NSValue valueWithCGPoint:CGPointMake(self.W-40-kimageWidth/2, self.H-self.downH-self.h*3-40)],
                 [NSValue valueWithCGPoint:CGPointMake(40-kimageWidth/2, self.H-self.downH-self.h*4-40)],
                 [NSValue valueWithCGPoint:CGPointMake(self.W-40-kimageWidth/2, self.H-self.downH-self.h*5-40)],
                 [NSValue valueWithCGPoint:CGPointMake(self.W/2, 40)]];

        titles=@[@"辞海",@"名人名言",@"急转弯",@"成语",@"歇后语",@"新华字典",@"姓氏起源"];
        images=@[@"PF_home_ci_hai",@"PF_home_ming_yan",@"PF_home_ji_zhuan_wan",@"PF_home_cheng_yu",@"PF_home_xie_hou_yu",@"PF_home_zi_dian",@"PF_home_xing_shi_qi_yuan"];

    }
    return self;
}


- (void)aaaaaa {
    
    if (count >= [points count]) {
        
        return;
    }
    
    NSValue *values=[points objectAtIndex:count];
    
    
    CGPoint point=[values CGPointValue];
    
    if (count == 6) {
        point=CGPointMake(self.W/2-kimageWidth/2, 40-kimageWidth/2);
    }
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(point.x ,point.y, kimageWidth, kimageWidth)];
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
    
    
    count++;
    
    if (count == 7) {
        self.completeBlock();
    }

}


- (void)removeAnimalLayer {
    [layerAnimal removeFromSuperlayer];
}
- (void)animalAction {
    
    [NSTimer scheduledTimerWithTimeInterval:ktime*7 target:self selector:@selector(removeAnimalLayer) userInfo:nil repeats:NO];
    
    layerAnimal=[CALayer layer];
    
    layerAnimal.frame=CGRectMake(self.W/2-40,self.H-40, 80, 80);
    layerAnimal.backgroundColor=[UIColor redColor].CGColor;
    layerAnimal.cornerRadius=40;
    layerAnimal.masksToBounds=YES;
    
    [self.layer addSublayer:layerAnimal];
    
    
    [self creatAnimal];
}

- (void)creatAnimal{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position";
    
    NSValue *value0=[NSValue valueWithCGPoint:CGPointMake(self.W/2-kimageWidth/2,self.H-kimageWidth/2)];
    
    NSValue *value1=[points objectAtIndex:0];
    
    NSValue *value2=[points objectAtIndex:1];
    
    NSValue *value3=[points objectAtIndex:2];
    
    NSValue *value4=[points objectAtIndex:3];
    
    NSValue *value5=[points objectAtIndex:4];
    
    NSValue *value6=[points objectAtIndex:5];

    NSValue *value7=[points objectAtIndex:6];
    
    animation.values=@[value0,value1,value2,value3,value4,value5,value6,value7];
    
    animation.duration = ktime*7;
    
    [layerAnimal addAnimation:animation forKey:nil];
 
}


- (void)startAnimal {
    count=0;

    [self animalAction];
    for (int i=0; i<7; i++) {
        
        [self performSelector:@selector(aaaaaa) withObject:nil afterDelay:ktime*(i+1)];
        
    }
    
}
- (void)itemAction:(UITapGestureRecognizer *)recognizer {
    [self.delegate didSelectAnimalViewWithIndex:recognizer.view.tag-100];
}
@end
