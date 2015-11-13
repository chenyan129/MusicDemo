//
//  MusicHeaderView.m
//  Music
//
//  Created by qianfeng on 15/10/30.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "MusicHeaderView.h"

@implementation MusicHeaderView

- (instancetype)init{
    if (self = [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MusicHeaderView" owner:nil options:nil] lastObject];
        [self addGuesture];
    }
    return self;
}

- (void)addGuesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self addGestureRecognizer:tap];
}

- (void)tapClick{
    if (self.headerBlock) {
        self.headerBlock(self.frame.origin.y-self.superview.bounds.origin.y);
    }
}


- (IBAction)playClick:(UIButton *)sender {
    if (self.playMusicBlock) {
        self.playMusicBlock();
    }
}

- (void)showDataWithModel:(MusicModel *)model{
    self.mnameLabel.text = model.mname;
    self.mnumLabel.text = [NSString stringWithFormat:@"第%@期",model.mnum];
    self.histLabel.text = [NSString stringWithFormat:@"%ld人听过",model.hist];
    [self.mphotoImageView sd_setImageWithURL:[NSURL URLWithString:model.mphoto] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
}

@end
