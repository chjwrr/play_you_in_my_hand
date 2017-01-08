//
//  QuTuCell.m
//  ModelProduct
//
//  Created by apple on 16/2/24.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFQuTuCell.h"
#import "PFQuTuModel.h"


#define imageHeight     200

@interface PFQuTuCell ()

@property (nonatomic,strong) UILabel *lab_title;
@property (nonatomic,strong) UIImageView *imageview;

@end

@implementation PFQuTuCell
- (void)initSubViews {
    UIImageView *upimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 10)];
    [self addSubview:upimg];
    upimg.backgroundColor=kviewlightbgColor;
    
    _lab_title=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, kSCREEN_WIDTH-20, 20)];
    [self addSubview:_lab_title];
    _lab_title.font=kSYS_FONT(17);
    _lab_title.numberOfLines=0;
    
    _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20+20+20, kSCREEN_WIDTH-20, imageHeight)];
    [self addSubview:_imageview];
    _imageview.contentMode=UIViewContentModeScaleAspectFill;
    _imageview.layer.masksToBounds=YES;
}


+ (CGFloat)CellHeightWithData:(id)data {
    PFQuTuModel *model=(PFQuTuModel *)data;

    CGFloat height=[model.content getStringHeightSizeWidth:kSCREEN_WIDTH-20 WithFontSize:17];
    
    return height+imageHeight+40;
}


- (void)cellForData:(id)data {
    
    PFQuTuModel *model=(PFQuTuModel *)data;
    
    CGFloat height=[model.content getStringHeightSizeWidth:kSCREEN_WIDTH-20 WithFontSize:17];
    
    //标题
    _lab_title.frame=CGRectMake(10, 20, kSCREEN_WIDTH-20, height);
    _lab_title.text=model.content;
    
    //图片
    _imageview.frame=CGRectMake(10, 20+height+10, kSCREEN_WIDTH-20, imageHeight);
  
    [_imageview setShowActivityIndicatorView:YES];
    [_imageview setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_imageview sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:nil];
}

@end
