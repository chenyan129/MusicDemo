//
//  SongListView.h
//  Music
//
//  Created by qianfeng on 15/11/4.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongModel.h"
#import "MusicModel.h"

typedef void(^BackBlock)();
typedef void(^StartPlayBlock)(NSInteger);
typedef void(^PlayNextBlock)(NSInteger);

@interface SongListView : UIView

@property (nonatomic,strong) MusicModel *musicModel;

@property (nonatomic,strong) NSArray *listArray;

@property (nonatomic,assign) NSInteger isPlayingIndex;

@property (nonatomic,copy) BackBlock backBlock;

@property (nonatomic,copy) StartPlayBlock startPlayBlock;

@property (nonatomic,copy) PlayNextBlock playNextBlock;

- (instancetype)initWithFrame:(CGRect)frame MusicModel:(MusicModel *)musicModel Index:(NSInteger)index;

@end
