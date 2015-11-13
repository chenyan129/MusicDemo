//
//  MusicModel.h
//  LoveMusic
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "BaseModel.h"
#import "SongModel.h"

@interface MusicModel : BaseModel

@property (nonatomic,copy) NSString *mname;

@property (nonatomic,copy) NSString *mnum;

@property (nonatomic,copy) NSString *mphoto;

@property (nonatomic,copy) NSString *mdesc;

@property (nonatomic,assign) NSInteger hist;

@property (nonatomic,strong) NSMutableArray *listArray;

@property (nonatomic,assign) BOOL isFloded;

@end
