//
//  TWLaunchAdController.m
//  TWUtils
//
//  Created by air on 2017/4/7.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import "TWLaunchAdController.h"

@interface TWLaunchAdController () {
    BOOL _isBegin;
}

// 启动图片
@property (strong, nonatomic) UIImage *launchImage;
// 全屏显示启动图片
@property (strong, nonatomic) UIImageView *launchImageView;
// 显示广告图片
@property (strong, nonatomic) UIImageView *adImageView;
// 跳过按钮
@property (strong, nonatomic) UIButton *skipBtn;
// 倒计时
@property (strong, nonatomic) NSTimer *timer;

@property (copy, nonatomic) TWLaunchAdFinishHandler finishHandler;
@property (copy, nonatomic) TWLaunchAdSetSkipBtnHandler setSkipBtnHandler;

@end

@implementation TWLaunchAdController

- (instancetype)initWithLaunchImage:(UIImage *)launchImage setAdImageHandler:(TWLaunchAdSetAdImageHandler)setAdImageHandler finishHandler:(TWLaunchAdFinishHandler)finishHandler {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _finishHandler = [finishHandler copy];
        _launchImage = launchImage;
        if (launchImage) {
            //需要显示启动图片的时候，设置广告的高度为屏幕的2/3
            _adImageViewFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 2 / 3);
        } else {
            _adImageViewFrame = [UIScreen mainScreen].bounds;
        }
        //调用设置广告图片的block，不管外界怎样加载图片（可能使用SDWebImage来加载），都可以
        setAdImageHandler(self.adImageView);
        //注意触发setter方法
        self.countDownTime = 5;
    }
    return self;
}

//便利构造器
- (instancetype)initWithSetAdImageHandler:(TWLaunchAdSetAdImageHandler)setAdImageHandler finishHandler:(TWLaunchAdFinishHandler)finishHandler {
    return [self initWithLaunchImage:nil setAdImageHandler:setAdImageHandler finishHandler:finishHandler];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加手势，响应广告的点击
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedAdHandler)];
    tapGes.numberOfTapsRequired = 1;
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tapGes];
    
    if (_launchImage) {
        self.launchImageView.image = _launchImage;
        [self.view addSubview:self.launchImageView];
    }
    [self.view addSubview:self.adImageView];
    [self.view addSubview:self.skipBtn];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)dealloc {
    [self stopTimer];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (_launchImage) {
        self.launchImageView.frame = self.view.bounds;
    }
    self.adImageView.frame = _adImageViewFrame;
    {
        [self.skipBtn sizeToFit];
        CGRect skipBtnFrame = self.skipBtn.bounds;
        CGFloat margin = 20.f;
        skipBtnFrame.origin.x = self.view.bounds.size.width - margin - skipBtnFrame.size.width;
        skipBtnFrame.origin.y = margin;
        skipBtnFrame.size.width += 10;
        self.skipBtn.frame = skipBtnFrame;
    }
}

#pragma mark - 定时器
- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}

- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - 事件响应处理
- (void)timerHandler:(NSTimer *)timer {
    if (!_isBegin) {
        _isBegin = YES;
        return;
    }
    self.countDownTime--;         //重写set方法，设置按钮的文字
    if (_countDownTime == 0 && _finishHandler) {
        [self stopTimer];
        _finishHandler(TWLaunchAdCallbackTypeClickFinish);
    }
}

- (void)skipBtnOnClick:(UIButton *)skipBtn {
    if (_finishHandler) {
        _finishHandler(TWLaunchAdCallbackTypeClickSkipBtn);
    }
}

- (void)tapedAdHandler {
    if (_finishHandler) {
        _finishHandler(TWLaunchAdCallbackTypeClickAd);
    }
}

- (void)setSkipBtnHandler:(TWLaunchAdSetSkipBtnHandler)setSkipBtnHandler {
    _setSkipBtnHandler = [setSkipBtnHandler copy];
}

- (void)setCountDownTime:(NSInteger)countDownTime {
    _countDownTime = countDownTime;
    if (self.setSkipBtnHandler) {
        self.setSkipBtnHandler(self.skipBtn, countDownTime);
    } else {
        [self.skipBtn setTitle:[NSString stringWithFormat:@"%lds 跳过", countDownTime] forState:UIControlStateNormal];
    }
    if (!_isBegin) {
        [self.view setNeedsLayout];
    }
}

- (void)setAdImageViewFrame:(CGRect)adImageViewFrame {
    _adImageViewFrame = adImageViewFrame;
    [self.view setNeedsLayout];
}

#pragma mark - 懒加载
- (UIImageView *)adImageView {
    if (!_adImageView) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.clipsToBounds = YES;
        _adImageView = imageView;
    }
    return _adImageView;
}

- (UIImageView *)launchImageView {
    if (!_launchImageView) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.clipsToBounds = YES;
        _launchImageView = imageView;
    }
    return _launchImageView;
}

- (UIButton *)skipBtn {
    if (!_skipBtn) {
        UIButton *skipBtn = [UIButton new];
        skipBtn.layer.masksToBounds = YES;
        skipBtn.layer.cornerRadius = 10.f;
        skipBtn.backgroundColor = [UIColor blackColor];
        [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        skipBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [skipBtn addTarget:self action:@selector(skipBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _skipBtn = skipBtn;
    }
    return _skipBtn;
}

@end
