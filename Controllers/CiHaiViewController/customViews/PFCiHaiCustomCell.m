//
//  DictionCell.m
//  ModelProduct
//
//  Created by apple on 16/2/23.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFCiHaiCustomCell.h"

@interface PFCiHaiCustomCell ()

@property (nonatomic,strong)UILabel *lab_content;

@end
@implementation PFCiHaiCustomCell


- (void)initSubViews {
    _lab_content=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
    [self addSubview:_lab_content];
    _lab_content.font=kSYS_FONT(17);
    _lab_content.numberOfLines=0;

}

+ (CGFloat)CellHeightWithData:(NSString *)string {
    NSScanner * scanner = [NSScanner scannerWithString:string];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"〖" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@"〗" intoString:&text];
        //替换字符
        string = [string stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@〗",text] withString:@""];
    }

    string=[string stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    
    
    CGFloat height= [string getStringHeightSizeWidth:kSCREEN_WIDTH-20 WithFontSize:17];
    
    return height+20;
}

- (void)cellForData:(id)data {
    NSString *string=(NSString *)data;
    
    NSScanner * scanner = [NSScanner scannerWithString:string];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"〖" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@"〗" intoString:&text];
        //替换字符
        string = [string stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@〗",text] withString:@""];
    }
    
    string=[string stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];

    _lab_content.text=string;
    
    CGFloat height= [string getStringHeightSizeWidth:kSCREEN_WIDTH-20 WithFontSize:17];
    
    _lab_content.frame=CGRectMake(10, 10, kSCREEN_WIDTH-20, height+20);
}

@end
