//
//  TWPPTViewController.m
//  TWUtils
//
//  Created by air on 2017/4/10.
//  Copyright © 2017年 twgj. All rights reserved.
//

#import "TWPPTViewController.h"
#import "TWPPTViewDefault.h"
#import "TWPPTViewCustom.h"
#import "TWPPTViewTextOnly.h"

@interface TWPPTViewController ()<TWPPTViewDelegate>

@property (strong, nonatomic) TWPPTViewDefault *defaultPPT;
@property (strong, nonatomic) TWPPTViewCustom *customPPT;
@property (strong, nonatomic) TWPPTViewTextOnly *textOnlyPPT;

@end

@implementation TWPPTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _defaultPPT = [[TWPPTViewDefault alloc] initWithDelegate:self];
    _defaultPPT.pageControlPosition = TWPPTViewPageControlPositionBottomCenter;
    //    ppt.pageControl.pageIndicatorTintColor = ...
    //    ppt.scrollDirection = UICollectionViewScrollDirectionVertical;
    _defaultPPT.frame = CGRectMake(0.f, 40.f, self.view.bounds.size.width, 200);
    
    [self.view addSubview: _defaultPPT];
    
    _customPPT = [[TWPPTViewCustom alloc] initWithDelegate:self];
    _customPPT.pageControlPosition = TWPPTViewPageControlPositionBottomRight;
    _customPPT.frame = CGRectMake(0.f, 260, self.view.bounds.size.width, 200);
    
    [self.view addSubview:_customPPT];
    
    _textOnlyPPT = [[TWPPTViewTextOnly alloc] initWithDelegate:self];
    _textOnlyPPT.frame = CGRectMake(0.f, 480, self.view.bounds.size.width, 60);
    _textOnlyPPT.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.view addSubview:_textOnlyPPT];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (NSInteger)numberOfPagesForPPTView:(TWPPTViewOC *)pptView {
    return 4;
}

- (void)pptView:(TWPPTViewOC *)pptView setUpPageCell:(UICollectionViewCell *)cell withIndex:(NSInteger)index {
    if (pptView == _defaultPPT) {
        TWPPTViewDefaultCell *defaultCell = (TWPPTViewDefaultCell *)cell;
        // 可自定义文字属性 ...
        //    defaultCell.textLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        //    defaultCell.textLabel.textAlignment = NSTextAlignmentCenter;
        //    defaultCell.textLabel.textColor = [UIColor whiteColor];
        defaultCell.textLabel.text = [NSString stringWithFormat:@"      这是第: %ld 页", index];
        // 设置图片  网络图片, 可自由使用SDWebimage等来加载
        if (index % 2 == 0) {
            UIImage *image = [UIImage imageNamed:@"1"];
            defaultCell.imageView.image = image;
        }
        else {
            UIImage *image = [UIImage imageNamed:@"2"];
            defaultCell.imageView.image = image;
        }
        
    }
    if (pptView == _customPPT) {
        TWPPTViewCustomCell *customCell = (TWPPTViewCustomCell *)cell;
        if (index % 2 == 0) {
            UIImage *image = [UIImage imageNamed:@"1"];
            customCell.imageView.image = image;
        }
        else {
            UIImage *image = [UIImage imageNamed:@"2"];
            customCell.imageView.image = image;
        }
    }
    
    if (pptView == _textOnlyPPT) {
        TWPPTViewTextOnlyCell *textCell = (TWPPTViewTextOnlyCell *)cell;
        textCell.backgroundColor = [UIColor yellowColor];
        textCell.textLabel.text = [NSString stringWithFormat:@"      这是第: %ld 页", index];
        textCell.textLabel.textColor = [UIColor purpleColor];
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
