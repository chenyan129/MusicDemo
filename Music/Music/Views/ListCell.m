//
//  ListCell.m
//  Music
//
//  Created by qianfeng on 15/11/5.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "ListCell.h"


@implementation ListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(SongModel *)model Index:(NSInteger)index{
    self.numLabel.text = [NSString stringWithFormat:@"%ld",index+1];
    self.songerLabel.text = model.songer;
    self.songnameLabel.text = model.songname;
}

@end
