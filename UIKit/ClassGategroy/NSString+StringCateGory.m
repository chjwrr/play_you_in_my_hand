//
//  NSString+StringCateGory.m
//  好友动态列表
//
//  Created by apple on 15/4/20.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#import "NSString+StringCateGory.h"

@implementation NSString (StringCateGory)


- (CGFloat)getStringHeightSizeWidth:(CGFloat)width WithFontSize:(NSInteger)font{
    CGSize size=[self boundingRectWithSize:CGSizeMake(width, 2000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size.height;
}
- (CGFloat)getStringWidthSizeHeight:(CGFloat)height WithFontSize:(NSInteger)font{
    CGSize size=[self boundingRectWithSize:CGSizeMake(2000, height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size.width;
}

- (NSString *)removeHTML
{
    NSString *html=self;
    
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    html =[html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    html =[html stringByReplacingOccurrencesOfString:@"&nbsp" withString:@""];
    html =[html stringByReplacingOccurrencesOfString:@"&lt;" withString:@""];
    html =[html stringByReplacingOccurrencesOfString:@"&lt" withString:@""];
    html =[html stringByReplacingOccurrencesOfString:@"&gt;" withString:@""];
    html =[html stringByReplacingOccurrencesOfString:@"&gt" withString:@""];
    
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}


@end
