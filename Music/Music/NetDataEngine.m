//
//  NetDataEngine.m
//  Music
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "NetDataEngine.h"



@implementation NetDataEngine

+(instancetype)sharedInstance{
    static NetDataEngine *netDataEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netDataEngine = [[self alloc] init];
    });
    return netDataEngine;
}

- (instancetype)init{
    if (self = [super init]) {
        self.manager = [[AFHTTPRequestOperationManager alloc] init];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

- (void)oneGET:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock{
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)twoGET:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock{
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *str1 = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *str2 = [str1 substringWithRange:NSMakeRange(5, str1.length-6)];
        NSData *data = [str2 dataUsingEncoding:NSUTF8StringEncoding];
        if (successBlock) {
            successBlock(data);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}


@end
