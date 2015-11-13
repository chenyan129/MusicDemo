//
//  LXTabBarViewController.m
//  Music
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "LXTabBarViewController.h"

@interface LXTabBarViewController ()

@end

@implementation LXTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBar];
}

- (void)createTabBar{
    self.tabBar.tintColor = KAppColor;
    NSArray *VCNames = @[@"MusicViewController",@"SeeViewController",@"SingerViewController"];
    NSArray *titleNames = @[@"好听",@"好看",@"乐人"];
    NSArray *imageNames = @[@"haoting",@"haokan",@"yueren"];
    NSMutableArray *VCs = [[NSMutableArray alloc] init];
    for (int i = 0; i < VCNames.count; i++) {
        Class vcClass = NSClassFromString(VCNames[i]);
        UIViewController *baseVC = [[vcClass alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:baseVC];
        baseVC.title = titleNames[i];
        nvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleNames[i] image:[UIImage imageNamed:[NSString stringWithFormat:@"iconfont-%@",imageNames[i]]] tag:10+i];
        [VCs addObject:nvc];
    }
    self.viewControllers = VCs;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
