//
//  TuKuModel.h
//  ModelProduct
//
//  Created by apple on 16/2/18.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFBaseModel.h"

@interface PFTuKuModel : PFBaseModel

@property (nonatomic,strong)NSString *keywords;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *seq;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *imageName;


@end
