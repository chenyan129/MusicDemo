//
//  AppDelegate.m
//  Music
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 Mr.liu. All rights reserved.
//

#import "AppDelegate.h"
#import "LXTabBarViewController.h"
#import "LeftViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    LXTabBarViewController *tbc = [[LXTabBarViewController alloc] init];
    self.leftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:tbc];
    [self.leftSlideVC setPanEnabled:YES];
    self.window.rootViewController = self.leftSlideVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self playLaunchImageView];
    return YES;
}

- (void)playLaunchImageView{
    UIImageView *launchImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    launchImageView.image = [UIImage imageNamed:@"launchImage"];
    [self.window addSubview:launchImageView];
    [self.window bringSubviewToFront:launchImageView];
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        launchImageView.frame = CGRectMake(-60, -85, kScreenW+60*2, kScreenH+85*2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            launchImageView.alpha = 0;
        } completion:^(BOOL finished) {
            [launchImageView removeFromSuperview];
        }];
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    if ([MusicPlayerViewController sharedInstance].isPlaying) {
        [[MusicPlayerViewController sharedInstance] playAnimation];
    }
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
