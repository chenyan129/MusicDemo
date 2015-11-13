//
//  BaseViewController.m
//  Music
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "BaseViewController.h"
#import "GifView.h"

@interface BaseViewController ()

@property (nonatomic,strong) UIBarButtonItem *stopItem;

@property (nonatomic,strong) UIBarButtonItem *playItem;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = KAppColor;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:KAppColor,NSForegroundColorAttributeName,nil]];
    [self navigationInit];
}

- (void)navigationInit{
    GifView *gifView = [[GifView alloc] initWithFrame:CGRectMake(0, 0, 25, 25) filePath:[[NSBundle mainBundle] pathForResource:@"music" ofType:@"gif"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightClick)];
    [gifView addGestureRecognizer:tap];
    self.playItem = [[UIBarButtonItem alloc] initWithCustomView:gifView];
    self.stopItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"stop_up"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    if ([MusicPlayerViewController sharedInstance].isPlaying) {
        self.navigationItem.rightBarButtonItem = self.playItem;
    } else {
        self.navigationItem.rightBarButtonItem = self.stopItem;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStatusChanged:) name:PLAYSTATUSCHANGED object:nil];
}

- (void)playStatusChanged:(NSNotification *)nc{
    if ([nc.object boolValue]) {
        GifView *gifView = [[GifView alloc] initWithFrame:CGRectMake(0, 0, 25, 25) filePath:[[NSBundle mainBundle] pathForResource:@"music" ofType:@"gif"]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightClick)];
        [gifView addGestureRecognizer:tap];
        self.playItem = [[UIBarButtonItem alloc] initWithCustomView:gifView];
        self.navigationItem.rightBarButtonItem = self.playItem;
    } else {
        self.navigationItem.rightBarButtonItem = self.stopItem;
    }
}

- (void)rightClick{
    [self.view.window.rootViewController presentViewController:[MusicPlayerViewController sharedInstance] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
