//
//  MusicViewController.m
//  LoveMusic
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicModel.h"
#import "SongModel.h"
#import "SongCell.h"
#import "MdescCell.h"
#import "MusicHeaderView.h"

@interface MusicViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,assign) BOOL isRefreshing;

@property (nonatomic,assign) BOOL isLoadMore;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,strong) LGHLoadingView *loadingView;

@property (nonatomic,assign) NSInteger isPlayingSection;

@property (nonatomic,assign) NSInteger isPlayingIndex;


@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self createLoadingView];
    [self createRefreshView];
    [self createPullUpView];
    self.currentPage = 1;
    [self addTaskWithUrl:[NSString stringWithFormat:KMusicUrl,self.currentPage]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playNextMusic:) name:PLAYNEXTMUSIC object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    if ([MusicPlayerViewController sharedInstance].isPlaying) {
        self.isPlayingIndex = [MusicPlayerViewController sharedInstance].index;
        self.isPlayingSection = [MusicPlayerViewController sharedInstance].section;
    }else{
        self.isPlayingSection = 1000;
        self.isPlayingIndex = 1000;
    }
    [self.tableView reloadData];
}

- (void)playNextMusic:(NSNotification *)nc{
    self.isPlayingIndex = [[nc object] integerValue];
    self.isPlayingSection = [MusicPlayerViewController sharedInstance].section;
    [self.tableView reloadData];
}

- (void)createLoadingView{
    self.loadingView = [[LGHLoadingView alloc] initWithFrame:self.view.bounds loadingViewStyle:RTSpinKitViewStyleWave AnimationViewcolor:KAppColor backGroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.loadingView];
}

- (void)addTaskWithUrl:(NSString *)url{
    [[NetDataEngine sharedInstance] oneGET:url success:^(id responsData) {
        [self.loadingView removeLoadingView];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responsData options:NSJSONReadingMutableContainers error:nil];
        if ([url isEqualToString:[NSString stringWithFormat:KMusicUrl,(NSInteger)1]]) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary *dict in arr) {
            MusicModel *model = [[MusicModel alloc] init];
            model.mnum = dict[@"mnum"];
            model.mphoto = dict[@"mphoto"];
            model.mname = dict[@"mname"];
            model.mdesc = dict[@"mdesc"];
            model.hist = [dict[@"hist"] integerValue];
            model.listArray = [[NSMutableArray alloc] init];
            for (NSDictionary *listDict in dict[@"list"]) {
                SongModel *songModel = [[SongModel alloc] init];
                [songModel setValuesForKeysWithDictionary:listDict];
                [model.listArray addObject:songModel];
            }
            [self.dataArray addObject:model];
        }
        [self endRefreshing];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        DDLog(@"error:%@",error);
    }];
}

- (void)createRefreshView{
    __weak typeof(self) weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakself.isRefreshing) {
            return ;
        }
        weakself.isRefreshing = YES;
        weakself.currentPage = 1;
        [weakself addTaskWithUrl:[NSString stringWithFormat:KMusicUrl,weakself.currentPage]];
    }];
}


- (void)createPullUpView{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        weakSelf.currentPage++;
        [weakSelf addTaskWithUrl:[NSString stringWithFormat:KMusicUrl,weakSelf.currentPage]];
    }];
}

- (void)endRefreshing{
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-49) style:UITableViewStyleGrouped];
    self.isPlayingSection = 1000;
    self.isPlayingIndex = 1000;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.dataArray = [[NSMutableArray alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"SongCell" bundle:nil] forCellReuseIdentifier:@"SongCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MdescCell" bundle:nil] forCellReuseIdentifier:@"MdescCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MusicModel *model = self.dataArray[section];
    if (model.isFloded) {
        return 1+model.listArray.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MdescCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MdescCell"];
        MusicModel *model = self.dataArray[indexPath.section];
        cell.mdescLabel.text = model.mdesc;
        CGRect labelRect = cell.mdescLabel.frame;
        labelRect.size.height =  [LZXHelper textHeightFromTextString:model.mdesc width:kScreenW-24 fontSize:14];
        cell.mdescLabel.frame = labelRect;
        return cell;
    } else {
        SongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongCell"];
        MusicModel *model = self.dataArray[indexPath.section];
        SongModel *songModel = model.listArray[indexPath.row-1];
        [cell showDataWithModel:songModel];
        if (self.isPlayingIndex == indexPath.row-1 & self.isPlayingSection == indexPath.section) {
            cell.songerLabel.textColor = KAppColor;
            cell.songnameLabel.textColor = KAppColor;
        }else{
            cell.songerLabel.textColor = [UIColor darkGrayColor];
            cell.songnameLabel.textColor = [UIColor blackColor];
        }
        return cell;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MusicHeaderView *headerView = [[MusicHeaderView alloc] init];
    if (self.isPlayingSection == section) {
        [headerView.PlayButton setImage:[UIImage imageNamed:@"hunter_pause_up"] forState:UIControlStateNormal];
    }
    MusicModel *model = self.dataArray[section];
    [headerView showDataWithModel:model];
    headerView.headerBlock = ^(CGFloat offsetY){
        CGFloat tableViewOffsetY = self.tableView.contentOffset.y;
        tableViewOffsetY += offsetY;
        [self.tableView setContentOffset:CGPointMake(0, tableViewOffsetY) animated:YES];
        model.isFloded = !model.isFloded;
        [self.tableView reloadData];
};
    
    __weak typeof(headerView) weakHeaderView = headerView;
    headerView.playMusicBlock = ^{
        if (self.isPlayingSection == section) {
            self.isPlayingSection = 1000;
            [[MusicPlayerViewController sharedInstance] stopPlayMusic];
        } else {
            [weakHeaderView.PlayButton setImage:[UIImage imageNamed:@"hunter_pause_up"] forState:UIControlStateNormal];
            self.isPlayingSection = section;
            self.isPlayingIndex = 0;
            [self playMusic];
        }
        [self.tableView reloadData];
    };
    return headerView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 0) {
        if (self.isPlayingSection == indexPath.section & self.isPlayingIndex == indexPath.row-1) {
            [self.view.window.rootViewController presentViewController:[MusicPlayerViewController sharedInstance] animated:YES completion:nil];
        } else {
            self.isPlayingSection = indexPath.section;
            self.isPlayingIndex = indexPath.row-1;
            [self.tableView reloadData];
            [self playMusic];
            [self.view.window.rootViewController presentViewController:[MusicPlayerViewController sharedInstance] animated:YES completion:nil];
        }
    }
}

- (void)playMusic{
    if ([MusicPlayerViewController sharedInstance].isPlaying) {
        [[MusicPlayerViewController sharedInstance] stopPlayMusic];
    }
    MusicModel *model = self.dataArray[self.isPlayingSection];
    [[MusicPlayerViewController sharedInstance] playMusicWithMusicModel:model Index:self.isPlayingIndex Section:self.isPlayingSection];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScreenW*250/375;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MusicModel *model = self.dataArray[indexPath.section];
        return [LZXHelper textHeightFromTextString:model.mdesc width:kScreenW-24 fontSize:14] + 20;
    } else {
        return 70;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
