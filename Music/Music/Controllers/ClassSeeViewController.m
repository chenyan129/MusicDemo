//
//  ClassSeeViewController.m
//  Music
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "ClassSeeViewController.h"
#import "SeeModel.h"
#import "SeeCell.h"

@interface ClassSeeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,assign) BOOL isRefreshing;

@property (nonatomic,assign) BOOL isLoadMore;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,strong) LGHLoadingView *loadingView;

@end

@implementation ClassSeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
    [self createLoadingView];
    [self createRefreshView];
    [self createPullUpView];
    self.currentPage = 1;
    [self addTaskWithUrl:[NSString stringWithFormat:KSeeUrl,self.categotyID,self.currentPage]];
}

- (void)createLoadingView{
    self.loadingView = [[LGHLoadingView alloc] initWithFrame:self.view.bounds loadingViewStyle:RTSpinKitViewStyleWave AnimationViewcolor:KAppColor backGroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.loadingView];
}

- (void)addTaskWithUrl:(NSString *)url{
    [[NetDataEngine sharedInstance] twoGET:url success:^(id responsData) {
        [self.loadingView removeLoadingView];
        if ([url isEqualToString:[NSString stringWithFormat:KSeeUrl,self.categotyID,(NSInteger)1]]) {
            [self.dataArray removeAllObjects];
        }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responsData options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in arr) {
            SeeModel *model = [[SeeModel alloc] init];
            model.title = dict[@"title"];
            model.name = dict[@"category"][@"name"];
            model.nickname = dict[@"createBy"][@"nickname"];
            model.image = dict[@"image"];
            model.articleUrl = dict[@"articleUrl"];
            [self.dataArray addObject:model];
        }
        [self.collectionView reloadData];
        [self endRefreshing];
    } failed:^(NSError *error) {
        DDLog(@"error:%@",error);
    }];
}

- (void)createRefreshView{
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing = YES;
        weakSelf.currentPage = 1;
        [weakSelf addTaskWithUrl:[NSString stringWithFormat:KSeeUrl,weakSelf.categotyID,weakSelf.currentPage]];
    }];
}

- (void)endRefreshing{
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.collectionView.mj_header endRefreshing];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.collectionView.mj_footer endRefreshing];
    }
}

- (void)createPullUpView{
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        weakSelf.currentPage++;
        [weakSelf addTaskWithUrl:[NSString stringWithFormat:KSeeUrl,weakSelf.categotyID,weakSelf.currentPage]];
    }];
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kScreenW-15)/2, (kScreenW-15)*0.6);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-49) collectionViewLayout:layout];
    self.collectionView.backgroundColor = RGBColor(220, 220, 220);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.dataArray = [[NSMutableArray alloc] init];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SeeCell" bundle:nil] forCellWithReuseIdentifier:@"SeeCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SeeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SeeCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    SeeModel *model = self.dataArray[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SeeModel *model = self.dataArray[indexPath.row];
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.articleUrl = model.articleUrl;
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
