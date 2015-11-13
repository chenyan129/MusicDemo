//
//  MusicPlayerViewController.m
//  Music
//
//  Created by qianfeng on 15/10/31.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "MusicPlayerViewController.h"

#define AutherImageW kScreenW*220/375

@interface MusicPlayerViewController ()<AFSoundManagerDelegate>

@end

@implementation MusicPlayerViewController

#pragma mark -播放器单例

+ (instancetype)sharedInstance{
    static MusicPlayerViewController *musicVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicVC = [[self alloc] init];
    });
    return musicVC;
}

- (instancetype)init{
    if (self = [super init]) {
        [AFSoundManager sharedManager].delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createGuesture];
    self.autherImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW-AutherImageW)/2, kScreenH*0.15, AutherImageW, AutherImageW)];
    self.autherImageView.layer.masksToBounds = YES;
    self.autherImageView.layer.cornerRadius = AutherImageW/2;
    [self.view addSubview:self.autherImageView];
    [self.slider setThumbImage:[UIImage imageNamed:@"silder"] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"silder"] forState:UIControlStateHighlighted];
}

- (void)createGuesture{
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipe)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:recognizer];
}

- (void)downSwipe{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    if (self.isPlaying) {
        [self playAnimation];
        [self.playButton setImage:[UIImage imageNamed:@"pause_down"] forState:UIControlStateNormal];
    }else{
        self.isFirst = YES;
        [self.playButton setImage:[UIImage imageNamed:@"play_down"] forState:UIControlStateNormal];
    }
    SongModel *model = self.listArray[self.index];
    [self.autherImageView sd_setImageWithURL:[NSURL URLWithString:model.songphoto] placeholderImage:[UIImage imageNamed:@"playing_bmwonboard_default"]];
    self.songnameLabel.text = model.songname;
    self.songerLabel.text = model.songer;
}



#pragma mark -播放音乐

- (void)playMusicWithMusicModel:(MusicModel *)musicModel Index:(NSInteger)index Section:(NSInteger)section{
    [self continueAnimation];
    self.musicModel = musicModel;
    self.index = index;
    self.section = section;
    self.listArray = musicModel.listArray;
    SongModel *model = self.listArray[self.index];
    [self playerMusicWithUrl:model.filename];
}

- (void)playerMusicWithUrl:(NSString *)url{
    [self updateSongInfo];
    [[AFSoundManager sharedManager] startStreamingRemoteAudioFromURL:url andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        if (!error) { 
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"mm:ss"];
            NSDate *elapsedTimeDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
            self.playTimeLabel.text = [formatter stringFromDate:elapsedTimeDate];
            NSDate *remainDate = [NSDate dateWithTimeIntervalSince1970:timeRemaining];
            self.remainTimeLabel.text = [formatter stringFromDate:remainDate];
            self.slider.value = percentage*0.01;
        }
    }];
}

- (void)currentPlayingStatusChanged:(AFSoundManagerStatus)status{
    if (status == AFSoundManagerStatusFinished) {
        [self stopPlayMusic];
        [self playNextMusicSong];
    }
}

- (void)updateSongInfo{
    self.isPlaying = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAYSTATUSCHANGED object:@(self.isPlaying)];
    SongModel *model = self.listArray[self.index];
    [self.playButton setImage:[UIImage imageNamed:@"pause_down"] forState:UIControlStateNormal];
    [self.autherImageView sd_setImageWithURL:[NSURL URLWithString:model.songphoto] placeholderImage:[UIImage imageNamed:@"playing_bmwonboard_default"]];
    self.songnameLabel.text = model.songname;
    self.songerLabel.text = model.songer;
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAYNEXTMUSIC object:@(self.index)];
}

#pragma mark -改变播放状态

- (void)playNextMusicSong{
    if (self.isFirst) {
        [self playAnimation];
        self.isFirst = NO;
    }
    [self continueAnimation];
    if (self.index == self.listArray.count-1) {
        self.index = 0;
    }else{
        self.index++;
    }
    SongModel *model = self.listArray[self.index];
    [self playerMusicWithUrl:model.filename];
}

- (void)stopPlayMusic{
    self.isPlaying = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAYSTATUSCHANGED object:@(self.isPlaying)];
    [self.playButton setImage:[UIImage imageNamed:@"play_down"] forState:UIControlStateNormal];
    [self pauseAnimation];
    [[AFSoundManager sharedManager] stop];
}

- (void)pausePlayMusic{
    self.isPlaying = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAYSTATUSCHANGED object:@(self.isPlaying)];
    [self.playButton setImage:[UIImage imageNamed:@"play_down"] forState:UIControlStateNormal];
    [self pauseAnimation];
    [[AFSoundManager sharedManager] pause];
}

- (void)resumePlayMusic{
    self.isPlaying = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAYSTATUSCHANGED object:@(self.isPlaying)];
    [self.playButton setImage:[UIImage imageNamed:@"pause_down"] forState:UIControlStateNormal];
    if (self.isFirst) {
        [self playAnimation];
        self.isFirst = NO;
    }
    [self continueAnimation];
    [[AFSoundManager sharedManager] resume];
}

#pragma mark -播放界面按钮控制

- (IBAction)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)listButton:(UIButton *)sender {
    [self createListBackView];
    [self createSongListView];
}

- (IBAction)playClick:(UIButton *)sender {
    if (self.isPlaying) {
        [self pausePlayMusic];
    } else {
        [self resumePlayMusic];
    }
}

- (IBAction)nextClick:(UIButton *)sender {
    if (self.isPlaying) {
        [self stopPlayMusic];
    }
    [self playNextMusicSong];
}

- (IBAction)sliderChange:(UISlider *)sender {
    [[AFSoundManager sharedManager] moveToSection:sender.value];
}


#pragma mark -图片动画控制
- (void)playAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(M_PI*2);
    rotationAnimation.duration = 8;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.autherImageView.layer addAnimation:rotationAnimation forKey:@"PlayMusic"];
}

- (void)pauseAnimation{
    CFTimeInterval pausedTime = [self.autherImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.autherImageView.layer.speed = 0.0;
    self.autherImageView.layer.timeOffset = pausedTime;
}

- (void)continueAnimation{
    CFTimeInterval pauesdTime = [self.autherImageView.layer timeOffset];
    self.autherImageView.layer.speed = 1.0;
    self.autherImageView.layer.timeOffset = 0.0;
    self.autherImageView.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.autherImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauesdTime;
    self.autherImageView.layer.beginTime = timeSincePause;
}

#pragma mark -创建歌单视图

- (void)createListBackView{
    self.listBackView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectView.contentView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    effectView.frame = self.listBackView.bounds;
    [self.listBackView addSubview:effectView];
    [self.view addSubview:self.listBackView];
}

- (void)createSongListView{
    self.listView = [[SongListView alloc] initWithFrame:self.view.frame MusicModel:self.musicModel Index:self.index];
    __weak typeof(self) weakSelf = self;
    self.listView.backBlock = ^(){
        [weakSelf removeListView];
    };
    self.listView.startPlayBlock = ^(NSInteger index){
        if (weakSelf.isFirst) {
            [weakSelf playAnimation];
            weakSelf.isFirst = NO;
        }
        weakSelf.index = index;
        SongModel *model = weakSelf.listArray[index];
        [weakSelf playerMusicWithUrl:model.filename];
        [weakSelf continueAnimation];
        [weakSelf removeListView];
    };
    self.listView.playNextBlock = ^(NSInteger index){
        [weakSelf stopPlayMusic];
        weakSelf.index = index;
        SongModel *model = weakSelf.listArray[index];
        [weakSelf playerMusicWithUrl:model.filename];
        [weakSelf continueAnimation];
        [weakSelf removeListView];
    };
    [self.view addSubview:self.listView];
}

- (void)removeListView{
    CGRect listRect = self.listView.frame;
    listRect.origin.y += kScreenH;
    [UIView animateWithDuration:0.5 animations:^{
        self.listView.transform = CGAffineTransformIdentity;
        self.listBackView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.listView removeFromSuperview];
        [self.listBackView removeFromSuperview];
        self.listView = nil;
        self.listBackView = nil;
    }];
}

@end
