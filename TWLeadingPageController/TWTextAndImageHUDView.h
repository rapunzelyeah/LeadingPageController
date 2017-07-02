//
//  TWTextAndImageHUDView.h
//  TWUtils
//
//  Created by air on 2017/4/11.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWTextAndImageHUDView : UIView

@property (strong, nonatomic) UIColor *textColor;

- (void)setText:(NSString *)text andImage:(UIImage *)image;

@end
