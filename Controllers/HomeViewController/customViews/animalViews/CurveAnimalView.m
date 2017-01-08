//
//  CurveAnimalView.m
//  贝塞尔曲线
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import "CurveAnimalView.h"

@interface CurveAnimalView (){

    int count;
    NSArray *points;
    
    CALayer *layerAnimal;

    NSArray *titles;
    NSArray *images;
}
@end

@implementation CurveAnimalView

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
                 [NSValue valueWithCGPoint:CGPointMake(self.W/2-40, 40-kimageWidth/2)]];
        
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
    
    layerAnimal.frame=CGRectMake(self.W/2-40,0, 80, 80);
    layerAnimal.cornerRadius=40;
    layerAnimal.masksToBounds=YES;
    layerAnimal.borderWidth=1;
    layerAnimal.borderColor=[UIColor redColor].CGColor;
    
    [self.layer addSublayer:layerAnimal];
    
    CAKeyframeAnimation *animal1=[self creatAnimalWithStartPoint:CGPointMake(self.W/2, self.H) WithEndPoint:CGPointMake(40, self.H-self.downH) WithControlPoint:CGPointMake(self.W/2, self.H-self.downH) WithBeginTime:0.0];
    
    CAKeyframeAnimation *animal2=[self creatAnimalWithStartPoint:CGPointMake(40, self.H-self.downH) WithEndPoint:CGPointMake(self.W-40,self.H-self.h-self.downH) WithControlPoint:CGPointMake(40+40, self.H-self.downH-self.h*2) WithBeginTime:ktime];
    
    CAKeyframeAnimation *animal3=[self creatAnimalWithStartPoint:CGPointMake(self.W-40,self.H-self.h-self.downH) WithEndPoint:CGPointMake(40,self.H-self.downH-self.h*2) WithControlPoint:CGPointMake(self.W-40-80, self.H-self.downH-self.h*3) WithBeginTime:ktime*2.0];
    
    CAKeyframeAnimation *animal4=[self creatAnimalWithStartPoint:CGPointMake(40,self.H-self.downH-self.h*2) WithEndPoint:CGPointMake(self.W-40,self.H-self.downH-self.h*3) WithControlPoint:CGPointMake(40+40, self.H-self.downH-self.h*4) WithBeginTime:ktime*3.0];
    
    CAKeyframeAnimation *animal5=[self creatAnimalWithStartPoint:CGPointMake(self.W-40,self.H-self.downH-self.h*3) WithEndPoint:CGPointMake(40,self.H-self.downH-self.h*4) WithControlPoint:CGPointMake(self.W-40-80, self.H-self.downH-self.h*5) WithBeginTime:ktime*4.0];
    
    CAKeyframeAnimation *animal6=[self creatAnimalWithStartPoint:CGPointMake(40,self.H-self.downH-self.h*4) WithEndPoint:CGPointMake(self.W-40,self.H-self.downH-self.h*5) WithControlPoint:CGPointMake(40+40, self.H-self.downH-self.h*6) WithBeginTime:ktime*5.0];
    
    CAKeyframeAnimation *animal7=[self creatAnimalWithStartPoint:CGPointMake(self.W-40,self.H-self.downH-self.h*5) WithEndPoint:CGPointMake(self.W/2,40) WithControlPoint:CGPointMake(self.W/2,self.h+40) WithBeginTime:ktime*6.0];
    
    //动画组
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:animal1,animal2,animal3,animal4,animal5,animal6,animal7, nil];
    animGroup.duration =ktime*7.0;
    animGroup.removedOnCompletion=YES;
    [layerAnimal addAnimation:animGroup forKey:@"move"];
    
}

- (CAKeyframeAnimation *)creatAnimalWithStartPoint:(CGPoint)startPoint WithEndPoint:(CGPoint)endPoint WithControlPoint:(CGPoint)controlPoint WithBeginTime:(CGFloat)beginTime{
    
    CAKeyframeAnimation *animal = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef thePath1 = CGPathCreateMutable();
    CGPathMoveToPoint(thePath1, NULL, startPoint.x, startPoint.y);
    CGPathAddQuadCurveToPoint(thePath1, NULL, controlPoint.x, controlPoint.y, endPoint.x, endPoint.y);
    animal.path = thePath1;
    CGPathRelease(thePath1);
    animal.duration = ktime;
    animal.beginTime=beginTime;
    
    return animal;
}



- (void)startAnimal {
    count=0;
    
    [self animalAction];
    
    for (int i=0; i<7; i++) {
        

        [self performSelector:@selector(aaaaaa) withObject:nil afterDelay:ktime*(i+1)];
    }

}



- (void)itemAction:(UITapGestureRecognizer *)Recognizer {
    [self.delegate didSelectAnimalViewWithIndex:Recognizer.view.tag-100];
}
@end
