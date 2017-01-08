//
//  NSString+StringCateGory.h
//  好友动态列表
//
//  Created by apple on 15/4/20.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (StringCateGory)
- (CGFloat)getStringHeightSizeWidth:(CGFloat)width WithFontSize:(NSInteger)font;
- (CGFloat)getStringWidthSizeHeight:(CGFloat)height WithFontSize:(NSInteger)font;

- (NSString *)removeHTML;
@end
