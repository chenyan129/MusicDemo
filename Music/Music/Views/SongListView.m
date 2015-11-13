//
//  SongListView.m
//  Music
//
//  Created by qianfeng on 15/11/4.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "SongListView.h"
#import "ListCell.h"
#import "GifView.h"

@interface SongListView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) GifView *gifView;

@end

@implementation SongListView

- (instancetype)initWithFrame:(CGRect)frame MusicModel:(MusicModel *)musicModel Index:(NSInteger)index{
    if (self = [super initWithFrame:frame]) {
        self.musicModel = musicModel;
        if ([MusicPlayerViewController sharedInstance].isPlaying) {
            self.isPlayingIndex = index;
        } else {
            self.isPlayingIndex = 1000;
        }
        self.listArray = musicModel.listArray;
        [self createTopView];
        [self createTableView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playNextMusic:) name:PLAYNEXTMUSIC object:nil];
    }
    return self;
}

- (void)playNextMusic:(NSNotification *)nc{
    self.isPlayingIndex = [[nc object] integerValue];
    [self.tableView reloadData];
}

- (void)createTopView{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(32, 32, 24, 24)];
    [backButton setImage:[UIImage imageNamed:@"back_up"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(70, 80, kScreenW-60, 30)];
    label1.text = [NSString stringWithFormat:@"猎乐 | %@期 %@的歌单",self.musicModel.mnum,self.musicModel.mname];
    [self addSubview:label1];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 110, 50, 30)];
    label2.text = [NSString stringWithFormat:@"共%ld首",self.listArray.count];
    label2.textColor = [UIColor darkGrayColor];
    label2.font = [UIFont systemFontOfSize:13];
    [self addSubview:label2];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(125, 117.5, 15, 15)];
    imageView.image = [UIImage imageNamed:@"iconfont-haoting"];
    [self addSubview:imageView];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(140, 110, 100, 30)];
    label3.text = [NSString stringWithFormat:@"%ld人听过",self.musicModel.hist];
    label3.font = [UIFont systemFontOfSize:13];
    label3.textColor = [UIColor darkGrayColor];
    [self addSubview:label3];
}

- (void)backClick{
    if (self.backBlock) {
        self.backBlock();
    }
}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, kScreenW, kScreenH-150) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:nil options:nil] lastObject];
    SongModel *model = self.listArray[indexPath.row];
    [cell showDataWithModel:model Index:indexPath.row];
    if (indexPath.row == self.isPlayingIndex) {
        cell.numLabel.text = nil;
        self.gifView = [[GifView alloc] initWithFrame:CGRectMake(0, 0, 20, 20) filePath:[[NSBundle mainBundle] pathForResource:@"music" ofType:@"gif"]];
        [cell.numLabel addSubview:self.gifView];
        cell.songerLabel.textColor = KAppColor;
        cell.songnameLabel.textColor = KAppColor;
    }else{
        cell.songerLabel.textColor = [UIColor darkGrayColor];
        cell.songnameLabel.textColor = [UIColor blackColor];
        cell.numLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([MusicPlayerViewController sharedInstance].isPlaying) {
        if (self.playNextBlock) {
                self.playNextBlock(indexPath.row);
        }
    } else {
        if (self.startPlayBlock) {
            self.startPlayBlock(indexPath.row);
        }
    }
    self.isPlayingIndex = indexPath.row;
    [self.tableView reloadData];
}

@end
