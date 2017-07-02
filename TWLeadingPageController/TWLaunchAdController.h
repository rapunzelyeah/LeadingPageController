//
//  TWLaunchAdController.h
//  TWUtils
//
//  Created by air on 2017/4/7.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TWLaunchAdCallbackType) {
    TWLaunchAdCallbackTypeClickAd,
    TWLaunchAdCallbackTypeClickSkipBtn,
    TWLaunchAdCallbackTypeClickFinish
};

//各种点击相应block
typedef void(^TWLaunchAdFinishHandler)(TWLaunchAdCallbackType callbackType);
//设置广告图片block
typedef void(^TWLaunchAdSetAdImageHandler)(UIImageView *imageView);
//设置跳过按钮的属性block
typedef void(^TWLaunchAdSetSkipBtnHandler)(UIButton *skipBtn, NSInteger currentTime);

@interface TWLaunchAdController : UIViewController

/**
 *  广告显示时间 默认为 5s
 */
@property (assign, nonatomic) NSInteger countDownTime;
/**
 *  自定义广告图片的frame
 *  默认情况下需要显示启动图片的时候, 设置广告的高度为屏幕高度的2/3
 *  不需要显示启动图片的时候, 广告高度和屏幕高度相同
 */
@property (assign, nonatomic) CGRect adImageViewFrame;

/**
 *  类似网易新闻的半屏广告的初始化方法
 *
 *  @param launchImage       设置需要显示的启动图片
 *  @param setAdImageHandler 设置广告图片的block
 *  @param finishHandler     回调block
 *
 */
- (instancetype)initWithLaunchImage:(UIImage *)launchImage setAdImageHandler:(TWLaunchAdSetAdImageHandler)setAdImageHandler finishHandler:(TWLaunchAdFinishHandler)finishHandler;
/**
 *  全屏广告的初始化方法
 *
 *  @param setAdImageHandler 设置广告图片的block
 *  @param finishHandler     回调block
 *
 */
- (instancetype)initWithSetAdImageHandler:(TWLaunchAdSetAdImageHandler)setAdImageHandler finishHandler:(TWLaunchAdFinishHandler)finishHandler;
/**
 *  设置跳过按钮的属性, 文字, 背景...
 *
 *  @param setSkipBtnHandler setSkipBtnHandler
 */
- (void)setSkipBtnHandler:(TWLaunchAdSetSkipBtnHandler)setSkipBtnHandler;

@end
