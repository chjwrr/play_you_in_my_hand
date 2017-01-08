//
//  PF_ShowMoreItemView.m
//  贝塞尔曲线
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import "PF_ShowMoreItemView.h"

#define kspace_height         20

#define kViewHeight           kimageWidth*3+44+kspace_height*3

#define kleft_space_width     20

@interface PF_ShowMoreItemView (){
    NSArray *endpoints;

    BOOL isAnimal;
}

@property (nonatomic,strong)UIButton *btn_show;
@property (nonatomic,strong)UIImageView *imageView1;
@property (nonatomic,strong)UIImageView *imageView2;
@property (nonatomic,strong)UIImageView *imageView3;
@property (nonatomic,strong)UIImageView *imageView4;
@property (nonatomic,strong)UIImageView *imageView5;

@end

@implementation PF_ShowMoreItemView


- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initSubViews];
                
    }
    return self;
}
+ (CGFloat)ViewHeight {
    return kViewHeight;
}
- (void)initSubViews {
    endpoints=@[[NSValue valueWithCGPoint:CGPointMake(kimageWidth, 0)],
                [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width-kimageWidth-kimageWidth, 0)],
                [NSValue valueWithCGPoint:CGPointMake(kleft_space_width, kimageWidth+kspace_height)],
                [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width-kimageWidth-kleft_space_width, kimageWidth+kspace_height)],
                [NSValue valueWithCGPoint:CGPointMake((self.frame.size.width-kimageWidth)/2, self.frame.size.height-kimageWidth)]];
    
    
    
    _btn_show=[[UIButton alloc]initWithFrame:CGRectMake((self.frame.size.width-44)/2, kViewHeight-kimageWidth-kspace_height-44, 44, 44)];
    [self addSubview:_btn_show];
    [_btn_show addTarget:self action:@selector(showMoreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_btn_show setImage:[UIImage imageNamed:@"PF_home_showMore"] forState:UIControlStateNormal];

    _imageView1=[[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-44)/2, kViewHeight-kimageWidth-kspace_height-44, 44, 44)];
    [self addSubview:_imageView1];
    _imageView1.image=kImageName(@"PF_home_jiemeng");
    _imageView1.layer.masksToBounds=YES;
    _imageView1.layer.cornerRadius=kimageWidth/2;
    _imageView1.layer.borderWidth=0.5;
    _imageView1.layer.borderColor=[UIColor redColor].CGColor;
    
    _imageView2=[[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-44)/2, kViewHeight-kimageWidth-kspace_height-44, 44, 44)];
    [self addSubview:_imageView2];
    _imageView2.image=kImageName(@"PF_home_xiaotu");
    _imageView2.layer.masksToBounds=YES;
    _imageView2.layer.cornerRadius=kimageWidth/2;
    _imageView2.layer.borderWidth=0.5;
    _imageView2.layer.borderColor=[UIColor redColor].CGColor;
    
    
    _imageView3=[[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-44)/2, kViewHeight-kimageWidth-kspace_height-44, 44, 44)];
    [self addSubview:_imageView3];
    _imageView3.image=kImageName(@"PF_home_xingzuo");
    _imageView3.layer.masksToBounds=YES;
    _imageView3.layer.cornerRadius=kimageWidth/2;
    _imageView3.layer.borderWidth=0.5;
    _imageView3.layer.borderColor=[UIColor redColor].CGColor;
    
    _imageView4=[[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-44)/2, kViewHeight-kimageWidth-kspace_height-44, 44, 44)];
    [self addSubview:_imageView4];
    _imageView4.layer.masksToBounds=YES;
    _imageView4.image=kImageName(@"PF_home_shengxiao");
    _imageView4.layer.cornerRadius=kimageWidth/2;
    _imageView4.layer.borderWidth=0.5;
    _imageView4.layer.borderColor=[UIColor redColor].CGColor;
    
    
    _imageView5=[[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-44)/2, kViewHeight-kimageWidth-kspace_height-44, 44, 44)];
    [self addSubview:_imageView5];
    _imageView5.layer.masksToBounds=YES;
    _imageView5.image=kImageName(@"PF_home_shezhi");
    _imageView5.layer.cornerRadius=kimageWidth/2;
    _imageView5.layer.borderWidth=0.5;
    _imageView5.layer.borderColor=[UIColor redColor].CGColor;
    
    
    _imageView1.hidden=YES;
    _imageView2.hidden=YES;
    _imageView3.hidden=YES;
    _imageView4.hidden=YES;
    _imageView5.hidden=YES;
    
    
    
    UIButton *aaaa=[[UIButton alloc]initWithFrame:CGRectMake(kimageWidth, 0, kimageWidth, kimageWidth)];
    [self addSubview:aaaa];
    [aaaa addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    aaaa.tag=100;
    aaaa.layer.cornerRadius=kimageWidth/2;
    aaaa.layer.masksToBounds=YES;
    
    UIButton *aaaa1=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-kimageWidth-kimageWidth, 0, kimageWidth, kimageWidth)];
    [self addSubview:aaaa1];
    [aaaa1 addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    aaaa1.tag=101;
    aaaa1.layer.cornerRadius=kimageWidth/2;
    aaaa1.layer.masksToBounds=YES;
    
    
    UIButton *aaaa2=[[UIButton alloc]initWithFrame:CGRectMake(kleft_space_width, kimageWidth+kspace_height, kimageWidth, kimageWidth)];
    [self addSubview:aaaa2];
    [aaaa2 addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    aaaa2.tag=102;
    aaaa2.layer.cornerRadius=kimageWidth/2;
    aaaa.layer.masksToBounds=YES;
    
    
    UIButton *aaaa3=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-kimageWidth-kleft_space_width, kimageWidth+kspace_height, kimageWidth, kimageWidth)];
    [self addSubview:aaaa3];
    [aaaa3 addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    aaaa3.tag=103;
    aaaa3.layer.cornerRadius=kimageWidth/2;
    aaaa3.layer.masksToBounds=YES;
    
    
    UIButton *aaaa4=[[UIButton alloc]initWithFrame:CGRectMake((self.frame.size.width-kimageWidth)/2, self.frame.size.height-kimageWidth, kimageWidth, kimageWidth)];
    [self addSubview:aaaa4];
    [aaaa4 addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    aaaa4.tag=104;
    aaaa4.layer.cornerRadius=kimageWidth/2;
    aaaa4.layer.masksToBounds=YES;

}


- (void)showMoreButtonAction {
    
    [self endAnimal];
}


- (void)startAnimal {
    
    _imageView1.hidden=NO;
    _imageView2.hidden=NO;
    _imageView3.hidden=NO;
    _imageView4.hidden=NO;
    _imageView5.hidden=NO;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        NSValue *startvalues1=[endpoints objectAtIndex:0];
        
        CGPoint startpoint1=[startvalues1 CGPointValue];
        
        _imageView1.frame=CGRectMake(startpoint1.x, startpoint1.y, kimageWidth , kimageWidth);
        
        NSValue *startvalues2=[endpoints objectAtIndex:1];
        
        CGPoint startpoint2=[startvalues2 CGPointValue];
        
        _imageView2.frame=CGRectMake(startpoint2.x, startpoint2.y, kimageWidth , kimageWidth);
        
        NSValue *startvalues3=[endpoints objectAtIndex:2];
        
        CGPoint startpoint3=[startvalues3 CGPointValue];
        
        _imageView3.frame=CGRectMake(startpoint3.x, startpoint3.y, kimageWidth , kimageWidth);
        
        NSValue *startvalues4=[endpoints objectAtIndex:3];
        
        CGPoint startpoint4=[startvalues4 CGPointValue];
        
        _imageView4.frame=CGRectMake(startpoint4.x, startpoint4.y, kimageWidth , kimageWidth);
        
        NSValue *startvalues5=[endpoints objectAtIndex:4];
        
        CGPoint startpoint5=[startvalues5 CGPointValue];
        
        _imageView5.frame=CGRectMake(startpoint5.x, startpoint5.y, kimageWidth , kimageWidth);
        
        
        _imageView1.layer.cornerRadius=kimageWidth/2;
        _imageView2.layer.cornerRadius=kimageWidth/2;
        _imageView3.layer.cornerRadius=kimageWidth/2;
        _imageView4.layer.cornerRadius=kimageWidth/2;
        _imageView5.layer.cornerRadius=kimageWidth/2;

    }];
    
    
    isAnimal=YES;

}


- (void)endAnimal {
    
    [UIView animateWithDuration:0.1 animations:^{
        _imageView1.frame=CGRectMake((self.frame.size.width-44)/2, kViewHeight-kimageWidth-kspace_height-44, 44, 44);
        _imageView2.frame=CGRectMake((self.frame.size.width-44)/2, kViewHeight-kimageWidth-kspace_height-44, 44, 44);
        _imageView3.frame=CGRectMake((self.frame.size.width-44)/2, kViewHeight-kimageWidth-kspace_height-44, 44, 44);
        _imageView4.frame=CGRectMake((self.frame.size.width-44)/2, kViewHeight-kimageWidth-kspace_height-44, 44, 44);
        _imageView5.frame=CGRectMake((self.frame.size.width-44)/2, kViewHeight-kimageWidth-kspace_height-44, 44, 44);

    } completion:^(BOOL finished) {
        if (finished) {
            _imageView1.hidden=YES;
            _imageView2.hidden=YES;
            _imageView3.hidden=YES;
            _imageView4.hidden=YES;
            _imageView5.hidden=YES;

            
            isAnimal=NO;

            [self removeFromSuperview];
        }
    }];
    
}

- (void)itemAction:(UIButton *)button {
    [_moreDelegate didSelectShowMoreItemWithIndex:button.tag-100];
}

@end

