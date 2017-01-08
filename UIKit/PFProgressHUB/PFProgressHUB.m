//
//  PFProgressHUB.m
//  测试Demo
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import "PFProgressHUB.h"
@interface PFProgressHUB (){
    UIView *ball_1;
    UIView *ball_2;
    UIView *ball_3;
    
    CGFloat BALL_RADIUS;
    
    CAKeyframeAnimation *animation_ball_3;
    CAKeyframeAnimation *animation_ball_1;
}
@property (nonatomic,strong)UILabel *content;
@property (nonatomic,strong)NSTimer* fadeOutTimer;

@end

@implementation PFProgressHUB

+ (instancetype)shareInstance {
    static PFProgressHUB *view=nil;
    static dispatch_once_t oncet;
    dispatch_once(&oncet, ^{
        view=[[PFProgressHUB alloc]init];
        view.backgroundColor=[UIColor clearColor];
        view.layer.cornerRadius=10;
        view.layer.shadowColor=[UIColor redColor].CGColor;
        view.layer.shadowOffset=CGSizeMake(0, 0);
        view.layer.shadowOpacity=0.8;
        view.layer.shadowRadius=5;

    });
    return view;
}

- (instancetype)init {
    self=[super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}
- (UILabel *)content {
    if (_content == nil) {
        _content=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, 0, 0)];
        [self addSubview:_content];
        _content.textAlignment=NSTextAlignmentCenter;
        _content.font=[UIFont systemFontOfSize:14];
        _content.numberOfLines=0;

    }
    return _content;
}
- (void)initSubviews {
    
    /**
     *  初始化三个圆
     */
    BALL_RADIUS=20.0;
    CGFloat HEIGHT=100;
    CGFloat WIDTH=100;
    
    CGFloat centerPointY = HEIGHT / 2;
    CGFloat centerPointX = WIDTH / 2;
    
    CGPoint centerPoint = CGPointMake(centerPointX, centerPointY);
    
    ball_1 = [[UIView alloc] initWithFrame:CGRectMake(centerPoint.x - BALL_RADIUS*1.5, centerPoint.y, BALL_RADIUS, BALL_RADIUS)];
    ball_1.layer.cornerRadius = BALL_RADIUS / 2; // 成为圆形
    ball_1.backgroundColor = [UIColor blackColor];
    [self addSubview:ball_1];
    
    ball_2 = [[UIView alloc] initWithFrame:CGRectMake(centerPoint.x - BALL_RADIUS * 0.5, centerPoint.y, BALL_RADIUS, BALL_RADIUS)];
    ball_2.layer.cornerRadius = BALL_RADIUS / 2; // 成为圆形
    ball_2.backgroundColor =[UIColor blackColor];
    [self addSubview:ball_2];
    
    ball_3 = [[UIView alloc] initWithFrame:CGRectMake(centerPoint.x + BALL_RADIUS * 0.5, centerPoint.y, BALL_RADIUS, BALL_RADIUS)];
    ball_3.layer.cornerRadius = BALL_RADIUS / 2; // 成为圆形
    ball_3.backgroundColor = [UIColor blackColor];
    [self addSubview:ball_3];
    
    
    /**
     *  左边圆添加旋转动画
     */
    
    UIBezierPath* aPath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerPoint.x, centerPoint.y+BALL_RADIUS*0.5)
                                                          radius:BALL_RADIUS
                                                      startAngle:0
                                                        endAngle:2*M_PI
                                                       clockwise:NO];
    
    
    animation_ball_1=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_ball_1.path = aPath1.CGPath;
    animation_ball_1.repeatCount = MAX_CANON;
    animation_ball_1.duration = 1.4;
    animation_ball_1.delegate = self;
    
    
    
    /**
     *  右边圆添加旋转动画
     */
    
    UIBezierPath* aPath3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerPoint.x, centerPoint.y+BALL_RADIUS*0.5)
                                                          radius:BALL_RADIUS
                                                      startAngle:M_PI
                                                        endAngle:-M_PI
                                                       clockwise:NO];
    
    
    animation_ball_3=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_ball_3.path = aPath3.CGPath;
    animation_ball_3.repeatCount = MAX_CANON;
    animation_ball_3.duration = 1.4;
    animation_ball_3.delegate = self;
    
    
    
    
}
- (void)show {
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        self.alpha=1.0;
        ball_1.hidden=NO;
        ball_2.hidden=NO;
        ball_3.hidden=NO;
        
        self.frame=CGRectMake(0, 0, 100, 100);
        
        self.center=[UIApplication sharedApplication].keyWindow.center;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        
        [ball_3.layer addAnimation:animation_ball_3 forKey:@"animation"];
        [ball_1.layer addAnimation:animation_ball_1 forKey:@"animation"];
        
        
        [self animal];
        
        
    }];
    
    
}
- (void)configSetting {
    [self.fadeOutTimer invalidate];
    self.fadeOutTimer = nil;
    
    [ball_1.layer removeAllAnimations];
    [ball_3.layer removeAllAnimations];
    [self.layer removeAllAnimations];
    
    
    ball_1.hidden=YES;
    ball_2.hidden=YES;
    ball_3.hidden=YES;
    self.content.hidden=YES;
}

- (void)showWithContent:(NSString *)content {
    [self configSetting];
    
    
    __weak PFProgressHUB *weakSelf = self;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        __strong PFProgressHUB *strongSelf = weakSelf;
        
        self.content.hidden=NO;

        strongSelf.content.text=content;
        
        
        CGFloat width=[content boundingRectWithSize:CGSizeMake(2000, 20) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
        
        if(width >=[UIScreen mainScreen].bounds.size.width-40-20){
            //多行文字
            
            CGFloat height=[content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40-20-20, 20) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height+20;
            
            strongSelf.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40-20, height+20);
            strongSelf.content.frame=CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-40-20-20, height);
        }else{
            //一行文字
            strongSelf.frame=CGRectMake(0, 0, width+20, 40);
            strongSelf.content.frame=CGRectMake(0, 10, width+20, 20);
            
        }
        
        strongSelf.center=[UIApplication sharedApplication].keyWindow.center;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha=1.0;
        }];
        
        strongSelf.fadeOutTimer = [NSTimer timerWithTimeInterval:2 target:strongSelf selector:@selector(dismiss) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:strongSelf.fadeOutTimer forMode:NSRunLoopCommonModes];
    }];
    
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha=0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.fadeOutTimer invalidate];
            self.fadeOutTimer = nil;
            
            [ball_1.layer removeAllAnimations];
            [ball_3.layer removeAllAnimations];
            [self.layer removeAllAnimations];
            
            ball_1.hidden=YES;
            ball_2.hidden=YES;
            ball_3.hidden=YES;
            
            self.content.hidden=YES;
        }
    }];
}
/**
 *  缩小和外括动画
 */
- (void)animal {
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        ball_1.transform = CGAffineTransformMakeTranslation(-BALL_RADIUS, 0);
        ball_1.transform = CGAffineTransformScale(ball_1.transform, 0.7, 0.7);
        
        ball_3.transform = CGAffineTransformMakeTranslation(BALL_RADIUS, 0);
        ball_3.transform = CGAffineTransformScale(ball_3.transform, 0.7, 0.7);
        
        
        ball_2.transform = CGAffineTransformScale(ball_2.transform, 0.7, 0.7);
    } completion:^(BOOL finished) {
        
        if (finished) {
            [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseIn  | UIViewAnimationOptionBeginFromCurrentState animations:^{
                ball_1.transform = CGAffineTransformIdentity;
                ball_3.transform = CGAffineTransformIdentity;
                ball_2.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished){
                
                if (finished) {
                    [self animal];
                    
                }
                
            }];
            
        }
    }];
    
}
@end
