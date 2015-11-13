//
//  SeeCell.h
//  Music
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeeModel.h"

@interface SeeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *seeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)showDataWithModel:(SeeModel *)model;

@end
