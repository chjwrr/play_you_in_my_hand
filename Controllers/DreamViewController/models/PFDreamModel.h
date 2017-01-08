//
//  DreamModel.h
//  ModelProduct
//
//  Created by apple on 16/2/22.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFBaseModel.h"

@interface PFDreamModel : PFBaseModel
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *type;
@end
