//
//  TWPPTViewDefaultCell.m
//  TWUtils
//
//  Created by air on 2017/4/10.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import "TWPPTViewDefaultCell.h"

@interface TWPPTViewDefaultCell ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *textLabel;

@end

@implementation TWPPTViewDefaultCell

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

- (void)commonInit {
    [self addSubview:self.imageView];
    [self addSubview:self.textLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _textLabel.frame = CGRectMake(0.f, self.bounds.size.height - 37.f, self.bounds.size.width, 37.f);
}

#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.clipsToBounds = YES;
        _imageView = imageView;
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        UILabel *label = [UILabel new];
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = YES;
        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        label.textColor = [UIColor whiteColor];
        _textLabel = label;
    }
    return _textLabel;
}


@end
