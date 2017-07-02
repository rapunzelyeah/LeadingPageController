//
//  TWLeadingPageCell.m
//  TWLeadingPageController
//
//  Created by air on 2017/4/7.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import "TWLeadingPageCell.h"

@implementation TWLeadingPageCell

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
    [self.finishBtn sizeToFit];         //根据字数自动调整宽高
    CGFloat margin = 10.0f;
    CGFloat btnHeight = self.finishBtn.bounds.size.height + 2 * margin;
    CGFloat btnWidth = self.finishBtn.bounds.size.width + 2 * margin;
    CGFloat btnX = (self.bounds.size.width - btnWidth) / 2;
    CGFloat btnY = self.bounds.size.height - 100.0f - btnHeight;
    self.finishBtn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
}

- (UIButton *)finishBtn {
    if (!_finishBtn) {
        UIButton *button = [UIButton new];
        button.backgroundColor = [UIColor yellowColor];
        _finishBtn = button;
    }
    return _finishBtn;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

- (void)commonInit {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.finishBtn];
}

@end
