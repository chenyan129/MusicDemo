//
//  SingerModel.h
//  LoveMusic
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "BaseModel.h"

@interface SingerModel : BaseModel

@property (nonatomic,copy) NSString *uid;

@property (nonatomic,copy) NSString *image;

@property (nonatomic,copy) NSString *songname;

@property (nonatomic,assign) NSInteger bfnum;

@property (nonatomic,copy) NSString *articleUrl;

@end
