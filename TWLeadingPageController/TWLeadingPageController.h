//
//  TWLeadingPageController.h
//  TWLeadingPageController
//
//  Created by air on 2017/4/7.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWLeadingPageCell.h"

typedef void(^TWLeadingPageSetupCellHandler)(TWLeadingPageCell *cell, NSIndexPath *indexPath);
typedef void(^TWLeadingPageFinishHandler)(UIButton *finishBtn);

@interface TWLeadingPageController : UIViewController

- (instancetype)initWithPagesCount:(NSInteger)count setupCellHandler:(TWLeadingPageSetupCellHandler)setupCellHandler finishHandler:(TWLeadingPageFinishHandler)finishHandler;

@property (strong, nonatomic, readonly) UIPageControl *pageControl;
@property (strong, nonatomic, readonly) UICollectionView *collectionView;
@property (assign, nonatomic, readonly) NSInteger count;

@end
