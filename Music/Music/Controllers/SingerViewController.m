//
//  SingerViewController.m
//  Music
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "SingerViewController.h"
#import "SingerModel.h"
#import "SingerCell.h"

@interface SingerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,assign) BOOL isRefreshing;

@property (nonatomic,assign) BOOL isLoadMore;

@property (nonatomic,strong) LGHLoadingView *loadingView;

@end

@implementation SingerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self createLoadingView];
    [self createRefreshView];
    [self createPullUpView];
    self.currentPage = 1;
    [self addTaskWithUrl:[NSString stringWithFormat:KSingerUrl,self.currentPage]];
}

- (void)createLoadingView{
    self.loadingView = [[LGHLoadingView alloc] initWithFrame:self.view.bounds loadingViewStyle:RTSpinKitViewStyleWave AnimationViewcolor:KAppColor backGroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.loadingView];
}

- (void)addTaskWithUrl:(NSString *)url{
    [[NetDataEngine sharedInstance] twoGET:url success:^(id responsData) {
        [self.loadingView removeLoadingView];
        if ([url isEqualToString:[NSString stringWithFormat:KSingerUrl,(NSInteger)1]]) {
            [self.dataArray removeAllObjects];
        }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responsData options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in arr) {
            SingerModel *model = [[SingerModel alloc] init];
            model.image = dict[@"image"];
            model.songname = dict[@"articleData"][@"songname"];
            model.bfnum = [dict[@"articleData"][@"bfnum"] integerValue];
            model.articleUrl = dict[@"articleUrl"];
            [self.dataArray addObject:model];
        }
        [self endRefreshing];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        DDLog(@"error:%@",error);
    }];
}

- (void)createRefreshView{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing = YES;
        weakSelf.currentPage = 1;
        [weakSelf addTaskWithUrl:[NSString stringWithFormat:KSingerUrl,weakSelf.currentPage]];
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
        [weakSelf addTaskWithUrl:[NSString stringWithFormat:KSingerUrl,weakSelf.currentPage]];
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-49-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.dataArray = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SingerCell" bundle:nil] forCellReuseIdentifier:@"SingerCell"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SingerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingerCell" forIndexPath:indexPath];
    SingerModel *model = self.dataArray[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenW*210/320;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController *webVC = [[WebViewController alloc] init];
    SingerModel *model = self.dataArray[indexPath.row];
    webVC.articleUrl = model.articleUrl;
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
