//
//  SongCell.m
//  LoveMusic
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "SongCell.h"


@implementation SongCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(SongModel *)model{
    [self.songImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnailUrl] placeholderImage:[UIImage imageNamed:@"MusicImage"]];
    self.songerLabel.text = model.songer;
    self.songnameLabel.text = model.songname;
}

@end
