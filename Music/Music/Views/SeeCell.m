//
//  SeeCell.m
//  Music
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "SeeCell.h"

@implementation SeeCell

- (void)awakeFromNib {
    self.nameLabel.layer.masksToBounds = YES;
}

- (void)showDataWithModel:(SeeModel *)model{
    [self.seeImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    self.nameLabel.text = model.name;
    self.nicknameLabel.text = model.nickname;
    self.titleLabel.text = model.title;
}

@end
