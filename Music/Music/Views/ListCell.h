//
//  ListCell.h
//  Music
//
//  Created by qianfeng on 15/11/5.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongModel.h"

@interface ListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *songnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *songerLabel;

- (void)showDataWithModel:(SongModel *)model Index:(NSInteger)index;

@end
