//
//  SingerCell.h
//  LoveMusic
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingerModel.h"

@interface SingerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *singerImageView;
@property (weak, nonatomic) IBOutlet UILabel *songnameLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UILabel *bfnumLabel;

- (void)showDataWithModel:(SingerModel *)model;

@end
