//
//  TWProgressHUD.h
//  TWUtils
//
//  Created by air on 2017/4/11.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWPrivateHUDProtocol.h"

@interface TWProgressHUD : UIView
//单例方法
+ (instancetype)sharedInstance;

- (instancetype)init;

- (void)setHudView:(UIView *)hudView;

- (void)showWithTime:(CGFloat)time;

- (void)hide;

- (void)hideAllHUDs;

@end

@interface TWProgressHUD (Public)
/** 提示文字, 不会自动隐藏*/
+ (void)showStatus:(NSString *)status;
/** 提示文字, 会自动隐藏*/
+ (void)showStatus:(NSString *)status andAutoHideAfterTime:(CGFloat)showTime;

/** 提示成功 显示默认的图片, 不会自动隐藏*/
+ (void)showSuccess;
/** 提示成功 显示默认的图片, 会自动隐藏*/
+ (void)showSuccessAndAutoHideAfterTime:(CGFloat)showTime;

/** 提示成功 显示默认的图片, 同时显示设定的文字提示, 不会自动隐藏*/
+ (void)showSuccessWithStatus:(NSString *)status;
/** 提示成功 显示默认的图片, 同时显示设定的文字提示, 会自动隐藏*/
+ (void)showSuccessWithStatus:(NSString *)status andAutoHideAfterTime:(CGFloat)showTime;

/** 提示失败 显示默认的图片, 不会自动隐藏*/
+ (void)showError;
/** 提示失败 显示默认的图片, 会自动隐藏*/
+ (void)showErrorAndAutoHideAfterTime:(CGFloat)showTime;

/** 提示失败 显示默认的图片, 同时显示设定的文字提示, 不会自动隐藏*/
+ (void)showErrorWithStatus:(NSString *)status;
/** 提示失败 显示默认的图片, 同时显示设定的文字提示, 会自动隐藏*/
+ (void)showErrorWithStatus:(NSString *)status andAutoHideAfterTime:(CGFloat)showTime;

/** 提示正在加载 显示默认的图片 不会自动隐藏*/
+ (void)showProgress;
/** 提示正在加载 显示默认的图片, 同时显示设定的文字提示 不会自动隐藏*/
+ (void)showProgressWithStatus:(NSString *)status;

/** 弹出自定义的提示框 不会自动隐藏*/
+ (void)showCustomHUD:(UIView *)hudView;
/** 弹出自定义的提示框 会自动隐藏*/
+ (void)showCustomHUD:(UIView *)hudView andAutoHideAfterTime:(CGFloat)showTime;

/** 移除提示框*/
+ (void)hideHUD;
/** 移除所有提示框*/
+ (void)hideAllHUDs;

@end
