//
//  TWProgressHUDView.h
//  TWUtils
//
//  Created by air on 2017/4/11.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWProgressHUDView : UIView

@property (strong, nonatomic) UIColor *indicatorColor;
/** 开始动画 */
- (void)startAnimation;
/** 设置文字提示 */
- (void)setText:(NSString *)text;

@end
