//
//  AppDelegate.m
//  TWLeadingPageController
//
//  Created by air on 2017/4/7.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import "AppDelegate.h"
#import "TWLeadingPageController.h"
#import "TWLaunchAdController.h"
#import "TWPPTViewController.h"
#import "TWProgressHUDController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
     1. LeadingPageController
    TWLeadingPageController *leadController = [[TWLeadingPageController alloc] initWithPagesCount:5 setupCellHandler:^(TWLeadingPageCell *cell, NSIndexPath *indexPath) {
        NSString *imageName = [NSString stringWithFormat:@"%ld", indexPath.row];
        cell.imageView.image = [UIImage imageNamed:imageName];
        [cell.finishBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    } finishHandler:^(UIButton *finishBtn) {
        //跳转到下一个界面去
    }];
    leadController.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    leadController.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
     */
    
    /*
     2.LaunchAd
    TWLaunchAdController *launchController = [[TWLaunchAdController alloc] initWithLaunchImage:[UIImage imageNamed:@"loading"] setAdImageHandler:^(UIImageView *imageView) {
        // 这里可以直接使用SDWebimage等来请求服务器提供的广告图片(SDWebimage会处理好gif图片的显示)
        // 不过你需要注意选择SDWebimage的缓存策略
        imageView.image = [UIImage imageNamed:@"adImage"];
    } finishHandler:^(TWLaunchAdCallbackType callbackType) {
        switch (callbackType) {
            case TWLaunchAdCallbackTypeClickAd:
                NSLog(@"点击广告");
                break;
            case TWLaunchAdCallbackTypeClickFinish:
                NSLog(@"点击结束，进入App");
                break;
            case TWLaunchAdCallbackTypeClickSkipBtn:
                NSLog(@"点击跳过广告，进入App");
                break;
            default:
                break;
        }
    }];
    
    launchController.countDownTime = 6.f;
    [launchController setSkipBtnHandler:^(UIButton *skipBtn, NSInteger currentTime) {
        [skipBtn setTitle:[NSString stringWithFormat:@"%lds 跳过", currentTime] forState:UIControlStateNormal];
    }];
     */
    
//     3.
    TWPPTViewController *pptController = [TWPPTViewController new];
    
    //TWProgressHUDController *hudController = [TWProgressHUDController new];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = pptController;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
