//
//  TWPPTViewCustom.m
//  TWUtils
//
//  Created by air on 2017/4/10.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import "TWPPTViewCustom.h"

@interface TWPPTViewCustom ()
@property (strong, nonatomic) UILabel *label;
@end

@implementation TWPPTViewCustom

static NSString *const kCustomCellId = @"TWPPTViewCustomCell";

- (instancetype)initWithDelegate:(id<TWPPTViewDelegate>)delegate {
    if (self = [super initWithDelegate:delegate]) {
        [self addSubview:self.label];
    }
    return self;
}

//重写父类方法
- (void)registerCellForCollectionView:(UICollectionView *)collectionView {
    [super registerCellForCollectionView:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:@"TWPPTViewCustomCell" bundle:nil] forCellWithReuseIdentifier:kCustomCellId];
}

- (UICollectionViewCell *)dequeueReusableCellForCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath {
    [super dequeueReusableCellForCollectionView:collectionView withIndexPath:indexPath];
    TWPPTViewCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCustomCellId forIndexPath:indexPath];
    return cell;
}

//改变当前下标的时候，调用代理方法设置新数据
- (void)currentPageDidChange:(NSInteger)currentPage {
    [super currentPageDidChange:currentPage];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pptView:setUpTextLabel:withIndex:)]) {
        [self.delegate pptView:self setUpTextLabel:self.label withIndex:currentPage];
    }
    NSLog(@"%ld --- %ld", self.pages, self.currentPage);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat laybelHeight = 37.f;
    self.label.frame = CGRectMake(0.f, self.bounds.size.height - laybelHeight, self.bounds.size.width, laybelHeight);
}

#pragma mark - 懒加载
- (UILabel *)label {
    if (!_label) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        label.textColor = [UIColor whiteColor];
        
        _label = label;
    }
    return _label;
}

@end
