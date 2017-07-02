//
//  TWProgressHUD.m
//  TWUtils
//
//  Created by air on 2017/4/11.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import "TWProgressHUD.h"
#import "TWPrivateHUDProtocol.h"
#import "TWTextOnlyHUDView.h"
#import "TWImageOnlyHUDView.h"
#import "TWTextAndImageHUDView.h"
#import "TWProgressHUDView.h"

@implementation TWProgressHUD (Public)

/** 提示文字, 不会自动隐藏*/
+ (void)showStatus:(NSString *)status {
    [TWProgressHUD showStatus:status andAutoHideAfterTime:0.f];
}

/** 提示文字, 会自动隐藏*/
+ (void)showStatus:(NSString *)status andAutoHideAfterTime:(CGFloat)showTime {
    TWProgressHUD *hudView = [TWProgressHUD sharedInstance];
    TWTextOnlyHUDView *textView = [[TWTextOnlyHUDView alloc] init];
    textView.text = status;
    [hudView setHudView:textView];
    [hudView showWithTime:showTime];
}

+ (void)showImage:(UIImage *)image withStatus:(NSString *)status andAutoHideAfterTime:(CGFloat)showTime {
    TWProgressHUD *hudView = [TWProgressHUD sharedInstance];
    TWTextAndImageHUDView *textAndImageView = [[TWTextAndImageHUDView alloc] init];
    [textAndImageView setText:status andImage:image];
    [hudView setHudView:textAndImageView];
    [hudView showWithTime:showTime];
}

+ (void)showImage:(UIImage *)image andAutoHideAfterTime:(CGFloat)showTime {
    TWProgressHUD *hudView = [TWProgressHUD sharedInstance];
    TWImageOnlyHUDView *imageView = [[TWImageOnlyHUDView alloc] init];
    imageView.image = image;
    [hudView setHudView:imageView];
    [hudView showWithTime:showTime];
}

/** 提示成功 显示默认的图片, 不会自动隐藏*/
+ (void)showSuccess {
    [TWProgressHUD showSuccessAndAutoHideAfterTime:0.0f];
}

/** 提示成功 显示默认的图片, 会自动隐藏*/
+ (void)showSuccessAndAutoHideAfterTime:(CGFloat)showTime {
    UIImage *image = [UIImage imageNamed:@"success"];
    [TWProgressHUD showImage:image andAutoHideAfterTime:showTime];
}

/** 提示成功 显示默认的图片, 同时显示设定的文字提示, 不会自动隐藏*/
+ (void)showSuccessWithStatus:(NSString *)status {
    [TWProgressHUD showSuccessWithStatus:status andAutoHideAfterTime:0.0f];
}

/** 提示成功 显示默认的图片, 同时显示设定的文字提示, 会自动隐藏*/
+ (void)showSuccessWithStatus:(NSString *)status andAutoHideAfterTime:(CGFloat)showTime {
    UIImage *image = [UIImage imageNamed:@"success"];
    [TWProgressHUD showImage:image withStatus:status andAutoHideAfterTime:showTime];
}

/** 提示失败 显示默认的图片, 不会自动隐藏*/
+ (void)showError {
    [TWProgressHUD showErrorAndAutoHideAfterTime:0.0f];
}

/** 提示失败 显示默认的图片, 会自动隐藏*/
+ (void)showErrorAndAutoHideAfterTime:(CGFloat)showTime {
    UIImage *image = [UIImage imageNamed:@"error"];
    [TWProgressHUD showImage:image andAutoHideAfterTime:showTime];
}
/** 提示失败 显示默认的图片, 同时显示设定的文字提示, 不会自动隐藏*/
+ (void)showErrorWithStatus:(NSString *)status {
    [TWProgressHUD showErrorWithStatus:status andAutoHideAfterTime:0.0f];
}

/** 提示失败 显示默认的图片, 同时显示设定的文字提示, 会自动隐藏*/
+ (void)showErrorWithStatus:(NSString *)status andAutoHideAfterTime:(CGFloat)showTime {
    UIImage *image = [UIImage imageNamed:@"error"];
    [TWProgressHUD showImage:image withStatus:status andAutoHideAfterTime:showTime];
}

/** 提示正在加载 显示默认的图片 不会自动隐藏*/
+ (void)showProgress {
    [TWProgressHUD showProgressWithStatus:nil];
}

/** 提示正在加载 显示默认的图片, 同时显示设定的文字提示 不会自动隐藏*/
+ (void)showProgressWithStatus:(NSString *)status {
    TWProgressHUD *hudView = [TWProgressHUD sharedInstance];
    TWProgressHUDView *progressView = [[TWProgressHUDView alloc] init];
    [progressView setText:status];
    [hudView setHudView:progressView];
    [hudView showWithTime:0.f];
    [progressView startAnimation];
}

/** 弹出自定义的提示框 不会自动隐藏*/
+ (void)showCustomHUD:(UIView *)hudView {
    [TWProgressHUD showCustomHUD:hudView andAutoHideAfterTime:0.0f];
}

/** 弹出自定义的提示框 会自动隐藏*/
+ (void)showCustomHUD:(UIView *)hudView andAutoHideAfterTime:(CGFloat)showTime {
    [[TWProgressHUD sharedInstance] setHudView:hudView];
    [[TWProgressHUD sharedInstance] showWithTime:showTime];
}

/** 移除提示框*/
+ (void)hideHUD {
    [[TWProgressHUD sharedInstance] hide];
}

/** 移除所有提示框*/
+ (void)hideAllHUDs {
    [[TWProgressHUD sharedInstance] hideAllHUDs];
}

@end

@implementation TWProgressHUD

//单例方法
+ (instancetype)sharedInstance {
    static TWProgressHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[TWProgressHUD alloc] init];
    });
    return hud;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setHudView:(UIView *)hudView {
    [self addSubview:hudView];
}

- (void)showWithTime:(CGFloat)time {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (self.superview == nil) {
        [window addSubview:self];
    }
    if (time > 0) {
        __weak typeof(self) weakself = self;
        delay(time, ^{
            __strong typeof(weakself) strongSelf = weakself;
            if (strongSelf) {
                [strongSelf hide];
            }
        });
    }
}

- (void)hide {
    UIView *firstHud = [self.subviews firstObject];
    if (firstHud) {
        [firstHud removeFromSuperview];
        if (self.subviews.count == 0) {
            [self removeFromSuperview];
        }
    } else {
        [self removeFromSuperview];
    }
}

- (void)hideAllHUDs {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    /*
     此遍历和上一句代码含义相同，让集合中的所有对象执行相同的selector
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
     */
    [self removeFromSuperview];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.superview) {
        self.frame = self.superview.bounds;
        for (UIView *subview in self.subviews) {
            if ([subview conformsToProtocol:@protocol(TWPrivateHUDProtocol)]) {
                subview.center = self.center;
            } else {
                CGRect frame = subview.frame;
                subview.frame = frame;
            }
        }
    }
}

// 这里直接使用了GCD, 当然推荐使用NSTimer
static void delay(CGFloat time, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}


@end
