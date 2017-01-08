//
//  DreamCell.m
//  ModelProduct
//
//  Created by apple on 16/2/22.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFDreamCell.h"

@interface PFDreamCell ()

@property (nonatomic,strong) UILabel *lab_content;
@property (nonatomic,strong)UIImageView *bgimageV;

@end
@implementation PFDreamCell


- (void)initSubViews {
    
    _bgimageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
    [self addSubview:_bgimageV];
    _bgimageV.image=kImageName(@"PF_dream_content_bgimage");
    _bgimageV.alpha=0.3;
    _bgimageV.layer.cornerRadius=5;
    _bgimageV.layer.masksToBounds=YES;
    
    _lab_content=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
    [self addSubview:_lab_content];
    _lab_content.font=kSYS_FONT(17);
    _lab_content.numberOfLines=0;
    _lab_content.textColor=[UIColor blackColor];
}


+ (CGFloat)CellHeightWithData:(NSString *)string {
    
    CGFloat height= [[string removeHTML] getStringHeightSizeWidth:kSCREEN_WIDTH-40-40 WithFontSize:17];
    
    return height+40;
}

- (void)cellForData:(id)data {
    NSString *string=(NSString *)data;
    _lab_content.text=[string removeHTML];

    CGFloat height= [_lab_content.text getStringHeightSizeWidth:kSCREEN_WIDTH-40-40 WithFontSize:17];

    _lab_content.frame=CGRectMake(20, 20, kSCREEN_WIDTH-40-40, height);
    
    _bgimageV.frame=CGRectMake(10, 10, kSCREEN_WIDTH-40-20, height+20);

    
}

@end
