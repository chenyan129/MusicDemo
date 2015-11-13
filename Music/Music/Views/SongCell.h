//
//  SongCell.h
//  LoveMusic
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongModel.h"

@interface SongCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *songImageView;
@property (weak, nonatomic) IBOutlet UILabel *songnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *songerLabel;

- (void)showDataWithModel:(SongModel *)model;

@end
