//
//  TWPPTViewTextOnly.m
//  TWUtils
//
//  Created by air on 2017/4/10.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import "TWPPTViewTextOnly.h"

@implementation TWPPTViewTextOnly

static NSString *const kTextOnlyCellId = @"TWPPTViewTextOnlyCell";

- (instancetype)initWithDelegate:(id<TWPPTViewDelegate>)delegate {
    if (self = [super initWithDelegate:delegate]) {
        self.pageControl.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//重写父类方法
- (void)registerCellForCollectionView:(UICollectionView *)collectionView {
    [super registerCellForCollectionView:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:@"TWPPTViewTextOnlyCell" bundle:nil] forCellWithReuseIdentifier:kTextOnlyCellId];
}

- (UICollectionViewCell *)dequeueReusableCellForCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath {
    [super dequeueReusableCellForCollectionView:collectionView withIndexPath:indexPath];
    TWPPTViewTextOnlyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTextOnlyCellId forIndexPath:indexPath];
    [self.delegate pptView:self setUpPageCell:cell withIndex:indexPath.row];
    return cell;
}

// 改变当前下标的时候, 调用代理方法设置新数据
- (void)currentPageDidChange:(NSInteger)currentPage {
    [super currentPageDidChange:currentPage];
    NSLog(@"%ld --- %ld", self.pages, self.currentPage);
}

@end
