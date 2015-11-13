//
//  MusicPlayerViewController.h
//  Music
//
//  Created by qianfeng on 15/10/31.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongModel.h"
#import "MusicModel.h"
#import <AFSoundManager.h>
#import "SongListView.h"

@interface MusicPlayerViewController : UIViewController
+ (instancetype)sharedInstance;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainTimeLabel;
- (IBAction)backClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)listButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *songnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *songerLabel;
- (IBAction)playClick:(UIButton *)sender;
- (IBAction)nextClick:(UIButton *)sender;
- (IBAction)sliderChange:(UISlider *)sender;
- (void)playMusicWithMusicModel:(MusicModel *)musicModel Index:(NSInteger)index Section:(NSInteger)section;
- (void)stopPlayMusic;
- (void)pauseAnimation;
- (void)continueAnimation;
- (void)playAnimation;
@property (nonatomic,assign) BOOL isFirst;
@property (nonatomic,assign) BOOL isPlaying;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) NSInteger section;
@property (nonatomic,strong) UIImageView *autherImageView;
@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic,strong) MusicModel *musicModel;
@property (nonatomic,strong) SongListView *listView;
@property (nonatomic,strong) UIView *listBackView;


@end
