//
//  DictionModel.h
//  ModelProduct
//
//  Created by apple on 16/2/23.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFBaseModel.h"

@interface PFDictionModel : PFBaseModel

@property (nonatomic,strong)NSString *hanzi;
@property (nonatomic,strong)NSString *pinyin;
@property (nonatomic,strong)NSString *duyin;
@property (nonatomic,strong)NSString *bushou;
@property (nonatomic,strong)NSString *bihua;
@property (nonatomic,strong)NSString *jianjie;
@property (nonatomic,strong)NSString *xiangjie;



@end
