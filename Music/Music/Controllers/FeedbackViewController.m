//
//  FeedbackViewController.m
//  Music
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈意见";
    self.view.backgroundColor = RGBColor(230, 230, 230);
    [self createTextField];
}

- (void)navigationInit{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_up1"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClick:)];
}

- (void)leftClick:(UIBarButtonItem *)item{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createTextField{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenW-20, 150)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textAlignment = NSTextAlignmentJustified;
    textField.placeholder = @"请留下你的宝贵意见";
    textField.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:textField];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenW-70, 170, 50, 30)];
    button.backgroundColor = KAppColor;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.layer.cornerRadius = 5;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)click:(UIButton *)btn{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"反馈意见" message:@"是否发送" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alertView show];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
