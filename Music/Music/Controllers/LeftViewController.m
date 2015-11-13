//
//  LeftViewController.m
//  Music
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "LeftViewController.h"
#import <SDImageCache.h>
#import "AppDelegate.h"
#import "AboutViewController.h"
#import "FeedbackViewController.h"

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *imageArray;

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) UILabel *currentLabel;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(40, 43, 53);
    [self createTableView];
}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.bounces = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 55;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataArray = @[@"回到首页",@"清除缓存",@"反馈意见",@"关于软件"];
    self.imageArray = @[@"zhuye",@"qingchu",@"fankui",@"guanyu"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconfont-%@",self.imageArray[indexPath.row]]];
    cell.selectionStyle = UITableViewCellStyleDefault;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (kScreenH-220)/2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, (kScreenH-220)/2)];
    view.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW*0.2, kScreenH*0.15, kScreenW*0.2, kScreenW*0.2)];
    imageView.image = [UIImage imageNamed:@"LeftMusicImage"];
    imageView.layer.cornerRadius = kScreenW*0.1;
    imageView.layer.masksToBounds = YES;
    [view addSubview:imageView];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self backToHome];
            break;
        case 1:
            [self clearCaches];
            break;
        case 2:
            [self jumpToFeedVC];
            break;
        case 3:
            [self jumpToAboutVC];
            break;
        default:
            break;
    }
}

- (void)backToHome{
    AppDelegate *tempAppDelegate = [[UIApplication sharedApplication] delegate];
    [tempAppDelegate.leftSlideVC closeLeftView];
}

- (void)clearCaches{
    [self.currentLabel removeFromSuperview];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenH-80, kScreenW*0.6, 20)];
    CGFloat sdSize = [[SDImageCache sharedImageCache] getSize];
    label.text = [NSString stringWithFormat:@"共清除%.2fM内存",sdSize/1024.0/1024.0];
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    self.currentLabel = label;
    [UIView animateWithDuration:5 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}

- (void)jumpToAboutVC{
    AboutViewController *aboutVC = [[AboutViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:aboutVC];
    [self.view.window.rootViewController presentViewController:nvc animated:YES completion:nil];
}

- (void)jumpToFeedVC{
    FeedbackViewController *feedVC = [[FeedbackViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:feedVC];
    [self.view.window.rootViewController presentViewController:nvc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
