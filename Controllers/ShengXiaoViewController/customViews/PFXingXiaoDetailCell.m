//
//  PFXingXiaoDetailCell.m
//  ModelProduct
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFXingXiaoDetailCell.h"

@interface PFXingXiaoDetailCell ()

@property (nonatomic,strong) UILabel *lab_content;
@property (nonatomic,strong)UIImageView *bgimageV;

@end
@implementation PFXingXiaoDetailCell

- (void)initSubViews {
    
    _lab_content=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
    [self addSubview:_lab_content];
    _lab_content.font=kSYS_FONT(17);
    _lab_content.numberOfLines=0;
    _lab_content.textColor=[UIColor blackColor];
}


+ (CGFloat)CellHeightWithData:(NSString *)string {
    
    CGFloat height= [[string removeHTML] getStringHeightSizeWidth:kSCREEN_WIDTH-40 WithFontSize:17];
    
    return height+20;
}

- (void)cellForData:(id)data {
    NSString *string=(NSString *)data;
    _lab_content.text=[string removeHTML];
    
    CGFloat height= [_lab_content.text getStringHeightSizeWidth:kSCREEN_WIDTH-40 WithFontSize:17];
    
    _lab_content.frame=CGRectMake(10, 10, kSCREEN_WIDTH-40, height);
    
    
    
}

@end
