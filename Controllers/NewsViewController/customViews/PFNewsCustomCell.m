//
//  PFNewsCustomCell.m
//  ModelProduct
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFNewsCustomCell.h"

#import "PFWeiNewsModel.h"

#define kcell_Height   80.0f


@interface PFNewsCustomCell ()

@property (nonatomic,strong)UILabel *lab_title;
@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,strong)UILabel *lab_describe;

@end

@implementation PFNewsCustomCell


- (void)initSubViews {
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    [self addSubview:_imageview];
    _imageview.contentMode=UIViewContentModeScaleAspectFill;
    _imageview.layer.masksToBounds=YES;
    
    _lab_title=[[UILabel alloc]initWithFrame:CGRectMake(kcell_Height, 10, kSCREEN_WIDTH-kcell_Height-10, 45)];
    [self addSubview:_lab_title];
    _lab_title.numberOfLines=2;
    
    _lab_describe=[[UILabel alloc]initWithFrame:CGRectMake(kcell_Height, 60, kSCREEN_WIDTH-kcell_Height-10, 15)];
    [self addSubview:_lab_describe];
    _lab_describe.font=kSYS_FONT(14);
    _lab_describe.textColor=kColorHexString(@"cccacc");
    _lab_describe.textAlignment=NSTextAlignmentRight;
    
    /*
     UIImageView *jubaoImg=[[UIImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-10-19, kcell_Height-15, 19, 4)];
     [self addSubview:jubaoImg];
     jubaoImg.image=kImageName(@"ju_bao");
     
     
     UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-50, kcell_Height-30, 40, 24)];
     [self addSubview:button];
     [button addTarget:self action:@selector(jubaoAction) forControlEvents:UIControlEventTouchUpInside];
     [button setBackgroundColor:[UIColor redColor]];
     */
    
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(10, kcell_Height-1, kSCREEN_WIDTH-20, 1)];
    [self addSubview:line];
    line.backgroundColor=klineColor;
    line.alpha=0.5;

}


- (void)cellForData:(id)data {
    PFWeiNewsModel *model=(PFWeiNewsModel *)data;
    
    
    _lab_title.text=model.title;
    _lab_describe.text=model.descriptions;
    
    [_imageview setShowActivityIndicatorView:YES];
    [_imageview setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_imageview sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:nil];
}
- (void)jubaoAction{
    
}


+(CGFloat)cellHeight {
    return kcell_Height;
}



@end
