//
//  MusicHeaderView.h
//  Music
//
//  Created by qianfeng on 15/10/30.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

typedef void(^HeaderBlock)(CGFloat offsetY);
typedef void(^PlayMusicBlock)();

@interface MusicHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *mnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mnumLabel;
@property (weak, nonatomic) IBOutlet UILabel *histLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mphotoImageView;
@property (weak, nonatomic) IBOutlet UIButton *PlayButton;
@property (nonatomic,copy) HeaderBlock headerBlock;
@property (nonatomic,copy) PlayMusicBlock playMusicBlock;

- (IBAction)playClick:(UIButton *)sender;

- (void)showDataWithModel:(MusicModel *)model;

@end
