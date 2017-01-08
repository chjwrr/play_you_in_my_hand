//
//  DreamCell.m
//  ModelProduct
//
//  Created by apple on 16/2/22.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFXingQiYuanCell.h"
#import "PFCopyLabel.h"

@interface PFXingQiYuanCell ()

@property (nonatomic,strong) PFCopyLabel *lab_content;
@end
@implementation PFXingQiYuanCell

- (void)initSubViews {
    _lab_content=[[PFCopyLabel alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
    [self addSubview:_lab_content];
    _lab_content.font=kSYS_FONT(17);
    _lab_content.numberOfLines=0;

}

+ (CGFloat)CellHeightWithData:(NSString *)string {
        

    CGFloat height= [[string removeHTML] getStringHeightSizeWidth:kSCREEN_WIDTH-20 WithFontSize:17];
    
    return height+40;
}

- (void)cellForData:(id)data {
    NSString *string=(NSString *)data;


    CGFloat height= [[string removeHTML] getStringHeightSizeWidth:kSCREEN_WIDTH-20 WithFontSize:17];

    _lab_content.frame=CGRectMake(10, 10, kSCREEN_WIDTH-20, height+20);
    
    _lab_content.text=[string removeHTML];
}

@end
