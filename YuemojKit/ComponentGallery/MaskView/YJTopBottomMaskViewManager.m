//
//  YJMultiSelectMaskView.m
//  NetworkSalesController
//
//  Created by HYT200841559 on 2023/4/25.
//

#import "YJTopBottomMaskViewManager.h"
#import "UIKit+Yuemoj.h"
#import "Masonry.h"

@interface YJTopBottomMaskViewManager ()
@property (nonatomic) BOOL displayed;
@end

@implementation YJTopBottomMaskViewManager
- (void)showOnViewController:(__kindof UIViewController *)viewController {
    UIViewController *parentViewController = viewController.tabBarController ?: (viewController.parentViewController ?: viewController);    
    [parentViewController.view addSubview:self.topMaskView];
    [self.topMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.offset(0.f);
        make.bottom.equalTo(parentViewController.view.mas_top);
        make.height.offset(self.topMaskHeight);
    }];
    [self.topMaskView layoutIfNeeded];
    
    [parentViewController.view addSubview:self.bottomMaskView];
    [self.bottomMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(parentViewController.view.mas_bottom);
        make.leading.trailing.offset(0.f);
        make.height.offset(self.bottomMaskHeight);
    }];
    [self.bottomMaskView layoutIfNeeded];
    self.displayed = YES;
    [UIView animateWithDuration:.25f animations:^{
        self.topMaskView.transform = CGAffineTransformMakeTranslation(0.f, self.topMaskView.yj_frame.height);
        self.bottomMaskView.transform = CGAffineTransformMakeTranslation(0.f, -self.bottomMaskView.yj_frame.height);
    }];
}

- (void)removeFromMaskingViewController {
    [UIView animateWithDuration:.25f animations:^{
        self.topMaskView.transform = CGAffineTransformIdentity;
        self.bottomMaskView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.topMaskView removeFromSuperview];
        [self.bottomMaskView removeFromSuperview];
    }];
    self.displayed = NO;
}

- (UIView *)topMaskView {
    if (!_topMaskView) _topMaskView = [UIView new];
    return _topMaskView;
}

- (UIView *)bottomMaskView {
    if (!_bottomMaskView) _bottomMaskView = [UIView new];
    return _bottomMaskView;
}

@end
