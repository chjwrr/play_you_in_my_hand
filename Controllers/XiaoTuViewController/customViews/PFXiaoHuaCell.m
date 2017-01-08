//
//  XiaoHuaCell.m
//  ModelProduct
//
//  Created by apple on 16/2/24.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFXiaoHuaCell.h"
#import "PFCopyLabel.h"
@interface PFXiaoHuaCell ()

@property (nonatomic,strong) PFCopyLabel *lab_content;
@property (nonatomic,strong) UIImageView *bgimageV;
@property (nonatomic,strong) UIImage *image;
@end
@implementation PFXiaoHuaCell

- (void)initSubViews {
    _bgimageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, kSCREEN_WIDTH, 0)];
    [self addSubview:_bgimageV];
    
    _lab_content=[[PFCopyLabel alloc]initWithFrame:CGRectMake(10, 20, kSCREEN_WIDTH-40, 0)];
    [self addSubview:_lab_content];
    _lab_content.font=kSYS_FONT(17);
    _lab_content.numberOfLines=0;

    _image=[UIImage imageNamed:@"PF_xiaotu_xiao_bgimage"];
    _image=[_image stretchableImageWithLeftCapWidth:59 topCapHeight:41];
    _bgimageV.image=_image;
}


+ (CGFloat)CellHeightWithData:(NSString *)string {
    
    CGFloat height=[string getStringHeightSizeWidth:kSCREEN_WIDTH-20 WithFontSize:17];
    
    
    return height+50;
}


- (void)cellForData:(id)data {
    
    NSString *string=(NSString *)data;
    
    if ([string isEmpty]) {
        string = @"";
    }
    
    CGFloat height=[string getStringHeightSizeWidth:kSCREEN_WIDTH-20 WithFontSize:17];

    _lab_content.frame=CGRectMake(10, 25, kSCREEN_WIDTH-20, height);
    _lab_content.text=string;

    _bgimageV.frame=CGRectMake(0, 10, kSCREEN_WIDTH, height+30);

}
@end
