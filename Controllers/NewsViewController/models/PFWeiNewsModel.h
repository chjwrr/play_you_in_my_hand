//
//  WeiNewsModel.h
//  ModelProduct
//
//  Created by chj on 16/1/29.
//  Copyright © 2016年 chj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFBaseModel.h"
@interface PFWeiNewsModel : PFBaseModel

@property (nonatomic,strong)NSString *hottime;
@property (nonatomic,strong)NSString *picUrl;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *url;


@end
