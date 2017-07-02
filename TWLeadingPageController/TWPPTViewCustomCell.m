//
//  TWPPTViewCustomCell.m
//  TWUtils
//
//  Created by air on 2017/4/10.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import "TWPPTViewCustomCell.h"

@implementation TWPPTViewCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.clipsToBounds = YES;
}

@end
