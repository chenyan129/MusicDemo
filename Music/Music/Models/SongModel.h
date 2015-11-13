//
//  SongModel.h
//  LoveMusic
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "BaseModel.h"

@interface SongModel : BaseModel


@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger mid;

@property (nonatomic, copy) NSString *songname;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *filename;

@property (nonatomic, copy) NSString *resourcecode;

@property (nonatomic, copy) NSString *songer;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, copy) NSString *filename192;

@property (nonatomic, assign) NSInteger fsize;

@property (nonatomic, copy) NSString *thumbnailUrl;

@property (nonatomic, assign) NSInteger scnum;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *isshare;

@property (nonatomic, copy) NSString *songphoto;

@property (nonatomic, assign) NSInteger status;


@end
