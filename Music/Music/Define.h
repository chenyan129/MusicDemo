//
//  Define.h
//  Music
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#ifndef Define_h
#define Define_h
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "LGHLoadingView.h"
#import "NetDataEngine.h"
#import "LZXHelper.h"
#import "MusicPlayerViewController.h"
#import "WebViewController.h"
#import <MJRefresh.h>


#ifdef DEBUG
#define DDLog(...) NSLog(__VA_ARGS__)
#else
#define DDLog(...)
#endif

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define KAppColor RGBColor(70,200,200)

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define PLAYNEXTMUSIC  @"PlayNextMusic"
#define PLAYSTATUSCHANGED @"playStatusChanged"

#endif /* Define_h */
