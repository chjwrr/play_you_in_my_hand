//
//  AFHTTPClickManager.h
//  ModelProduct
//
//  Created by apple on 16/1/13.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void(^RequestLoadingBlock)(void);
typedef void(^RequestSuccessBlock)(NSDictionary* respose);
typedef void(^RequestFailureBlock)(NSError *error);
typedef void(^RequestFinishBlock)(void);

typedef void(^DownLoadProgressBlock)(CGFloat progress);
typedef void(^DownLoadCompletionSuccessBlock)(NSString *filePath);
typedef void(^DownLoadCompletionFailureBlock)(NSError *error);


typedef void(^UpLoadProgressBlock)(CGFloat progress);
typedef void(^UpLoadCompletionSuccessBlock)(void);
typedef void(^UpLoadCompletionFailureBlock)(NSError *error);


@interface AFHTTPClickManager : AFHTTPSessionManager

+ (id)shareInstanceAPIStore;

+ (id)shareInstanceDT;

+ (id)shareInstanceTX;

+ (void)cancelRequest;

- (void)postRequestWithPath:(NSString *)path params:(NSDictionary *)params isHeader:(BOOL)isheader LoadingBolck:(RequestLoadingBlock)loadingblock SuccessBlock:(RequestSuccessBlock)successBlock FailureBlock:(RequestFailureBlock)failureBlock FinishBlock:(RequestFinishBlock)finishBlock;

- (void)getRequestWithPath:(NSString *)path params:(NSDictionary *)params isHeader:(BOOL)isheader LoadingBolck:(RequestLoadingBlock)loadingblock SuccessBlock:(RequestSuccessBlock)successBlock FailureBlock:(RequestFailureBlock)failureBlock FinishBlock:(RequestFinishBlock)finishBlock;

- (void)downLoadRequestWithURL:(NSString *)url filePath:(NSString *)filepath contentName:(NSString *)contentname progressBlock:(DownLoadProgressBlock)progressblock completSuccessBlock:(DownLoadCompletionSuccessBlock)completsuccessblock failureBlock:(DownLoadCompletionFailureBlock)failureblock;


- (void)upLoadRequestWithURL:(NSString *)url uploadData:(id)data progressBlock:(UpLoadProgressBlock)progressblock completSuccessBlock:(UpLoadCompletionSuccessBlock)completsuccessblock failureBlock:(UpLoadCompletionFailureBlock)failureblock;


@end
