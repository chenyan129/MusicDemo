//
//  SeeViewController.m
//  Music
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "SeeViewController.h"
#import "ClassSeeViewController.h"

#define kCachedVCName  @"kCachedVCName"

@interface SeeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic,strong) NSMutableDictionary *viewControllersCaches;

@property (nonatomic,strong) NSArray *categoryArray;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIView *currentView;

@end

@implementation SeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
    [self createTitleView];
}

- (void)createTitleView{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    self.titleLabel.text = @"最新";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = KAppColor;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    for (int i = 0; i < self.titleArray.count; i++) {
               UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12.5*i, 36, 5, 5)];
        view.layer.cornerRadius = 2.5;
        view.backgroundColor = [UIColor grayColor];
        view.tag = 10+i;
        [self.titleLabel addSubview:view];
        if (i == 0) {
            self.currentView = view;
        }
    }
    self.currentView.backgroundColor = KAppColor;
    self.navigationItem.titleView = self.titleLabel;
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenW, kScreenH-64-49);
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-49) collectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.viewControllersCaches = [[NSMutableDictionary alloc] init];
    self.titleArray = @[@"最新",@"艺文",@"有品"];
    self.categoryArray = @[@"28",@"29",@"650"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    ClassSeeViewController *cachedVC = (ClassSeeViewController *)[self getCachedVCByIndexPath:indexPath];
    if (!cachedVC) {
        cachedVC = [[ClassSeeViewController alloc] init];
        cachedVC.categotyID = self.categoryArray[indexPath.row];
    }
    [self addChildViewController:cachedVC];
    [self saveCachedVC:cachedVC ByIndexPath:indexPath];
    [cell.contentView addSubview:cachedVC.view];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *cachedViewController = [self getCachedVCByIndexPath:indexPath];
    if (!cachedViewController) {
        return;
    }
    [cachedViewController removeFromParentViewController];
    [cachedViewController.view removeFromSuperview];
}


- (UIViewController *)getCachedVCByIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cachedDic = [self.viewControllersCaches objectForKey:indexPath];
    UIViewController *cachedViewController = [cachedDic objectForKey:kCachedVCName];
    return cachedViewController;
}

- (void)saveCachedVC:(UIViewController *)viewController ByIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *newCacheDic = @{kCachedVCName:viewController};
    [self.viewControllersCaches setObject:newCacheDic forKey:indexPath];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x/kScreenW;
    self.currentView.backgroundColor = [UIColor grayColor];
    self.currentView = [self.titleLabel viewWithTag:currentPage+10];
    self.currentView.backgroundColor = KAppColor;
    self.titleLabel.text = self.titleArray[currentPage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
