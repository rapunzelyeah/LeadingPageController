//
//  TWLeadingPageController.m
//  TWLeadingPageController
//
//  Created by air on 2017/4/7.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import "TWLeadingPageController.h"

@interface TWLeadingPageController () <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (copy, nonatomic) TWLeadingPageSetupCellHandler setupCellHandler;
@property (copy, nonatomic) TWLeadingPageFinishHandler finishHandler;

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (assign, nonatomic) NSInteger count;

@end

static NSString *const kTWLeadingPageCellId = @"kTWLeadingPageCellId";

@implementation TWLeadingPageController

#pragma mark - life cycle
- (instancetype)initWithPagesCount:(NSInteger)count setupCellHandler:(TWLeadingPageSetupCellHandler)setupCellHandler finishHandler:(TWLeadingPageFinishHandler)finishHandler {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _count = count;
        _setupCellHandler = [setupCellHandler copy];
        _finishHandler = [finishHandler copy];
        //使用懒加载初始化
        [self.view addSubview:self.collectionView];
        [self.view addSubview:self.pageControl];
        //注册cell
        [self.collectionView registerClass:[TWLeadingPageCell class] forCellWithReuseIdentifier:kTWLeadingPageCellId];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TWLeadingPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTWLeadingPageCellId forIndexPath:indexPath];
    if (indexPath.row != self.count - 1) {
        cell.finishBtn.hidden = YES;
    } else {
        cell.finishBtn.hidden = NO;
        [cell.finishBtn addTarget:self action:@selector(finishBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.setupCellHandler) {
        self.setupCellHandler(cell, indexPath);
    }
    return cell;
}

- (void)finishBtnOnClick:(UIButton *)finishBtn {
    if (self.finishHandler) {
        self.finishHandler(finishBtn);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    if (self.pageControl.currentPage != currentPage) {
        self.pageControl.currentPage = currentPage;
    }
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = self.view.bounds.size;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = self.count;
        pageControl.currentPage = 0;
        CGSize pageControlSize = [pageControl sizeForNumberOfPages:self.count];
        CGFloat pageControlX = (self.view.bounds.size.width - pageControlSize.width)/2;
        CGFloat pageControlY = (self.view.bounds.size.height - pageControlSize.height - 50.f);
        pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlSize.width, pageControlSize.height);
        _pageControl = pageControl;
    }
    return _pageControl;
}

@end
