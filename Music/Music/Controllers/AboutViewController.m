//
//  AboutViewController.m
//  Music
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于软件";
    [self createScrollView];
}

- (void)navigationInit{
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_up1"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClick:)];
}

- (void)leftClick:(UIBarButtonItem *)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(kScreenW, (375+375+223+188.0)/375*kScreenW);
    scrollView.bounces = NO;
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW)];
    imageView1.image = [UIImage imageNamed:@"lielue"];
    [scrollView addSubview:imageView1];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenW, kScreenW, kScreenW)];
    imageView2.image = [UIImage imageNamed:@"haokan"];
    [scrollView addSubview:imageView2];
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2*kScreenW, kScreenW, 223.0/375*kScreenW)];
    imageView3.image = [UIImage imageNamed:@"yueren"];
    [scrollView addSubview:imageView3];
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2*kScreenW+223.0/375*kScreenW, kScreenW, 188.0/375*kScreenW)];
    imageView4.image = [UIImage imageNamed:@"guanyu"];
    [scrollView addSubview:imageView4];
    [self.view addSubview:scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
