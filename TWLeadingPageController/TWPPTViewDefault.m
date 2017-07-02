//
//  TWPPTViewDefault.m
//  TWUtils
//
//  Created by air on 2017/4/10.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import "TWPPTViewDefault.h"

@implementation TWPPTViewDefault

static NSString *const kCustomCellId = @"ZJPPTViewCustomCell";

- (instancetype)initWithDelegate:(id<TWPPTViewDelegate>)delegate {
    if (self = [super initWithDelegate:delegate]) {
        //TODO:添加自定义的控件
    }
    return self;
}

// 重写父类方法
- (void)registerCellForCollectionView:(UICollectionView *)collectionView {
    [super registerCellForCollectionView:collectionView];
    [collectionView registerClass:[TWPPTViewDefaultCell class] forCellWithReuseIdentifier:kCustomCellId];
    
}

- (UICollectionViewCell *)dequeueReusableCellForCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath {
    [super dequeueReusableCellForCollectionView:collectionView withIndexPath:indexPath];
    TWPPTViewDefaultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCustomCellId forIndexPath:indexPath];
    //TODO
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //TODO
}

@end
