//
//  BaseModel.m
//  ModelProduct
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFBaseModel.h"

@implementation PFBaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        [self setValue:value forKey:@"descriptions"];
    }
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"str_ID"];
    }
    
}

@end
