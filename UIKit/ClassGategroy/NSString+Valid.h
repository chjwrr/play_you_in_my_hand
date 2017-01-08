/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import <Foundation/Foundation.h>

@interface NSString (Valid)
-(BOOL)isChinese;
- (BOOL)isEmpty;
- (BOOL)isEmail;
- (BOOL)isMobilePhone;
- (NSString *)fromatterHasEmojiString;
- (NSMutableAttributedString *)getAttributeStringWithFont:(NSInteger)font WithRange:(NSRange)range;
- (NSMutableAttributedString *)setStringRangeColor:(UIColor *)color Range:(NSRange)range;
- (NSString *)formatterTime;

@end
