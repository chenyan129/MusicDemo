//
//  NetDataEngine.h
//  Music
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id responsData);
typedef void(^FailedBlock)(NSError *error);

@interface NetDataEngine : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

- (void)oneGET:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock;

- (void)twoGET:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock;

@end
