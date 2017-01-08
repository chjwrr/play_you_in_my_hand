//
//  DictionCell.m
//  ModelProduct
//
//  Created by apple on 16/2/23.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFDictionCell.H"

@interface PFDictionCell ()

@property (nonatomic,strong)UILabel *lab_content;

@end
@implementation PFDictionCell

- (void)initSubViews {
    _lab_content=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, kSCREEN_WIDTH, 44)];
    [self addSubview:_lab_content];
    _lab_content.font=kSYS_FONT(17);
    _lab_content.textColor=[UIColor blackColor];

    
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 43, kSCREEN_WIDTH, 1)];
    [self addSubview:line];
    line.backgroundColor=klineColor;
}

+ (CGFloat)cellHeight {
    return 44;
}

- (void)cellForData:(id)data {
    NSString *string=(NSString *)data;
    
    _lab_content.text=string;
}

@end
