//
//  YJActionViewController.m
//  YuemojKit
//
//  Created by Yuemoj on 2023/6/12.
//

#import "YJActionViewController.h"
#import "UIKit+Yuemoj.h"
#import "Masonry.h"

@interface YJActionViewController ()
@property (nonatomic) UIView *actionView;
@end

@implementation YJActionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.f alpha:.3f];
    [self privateLayout];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:.25f animations:^{
        self.actionView.transform = CGAffineTransformMakeTranslation(0.f, -self.actionView.yj_frame.height);
    }];
}

- (void)presentOnViewController:(__kindof UIViewController *)presentingViewController {
    [presentingViewController presentViewController:self animated:NO completion:nil];
}

- (void)dismiss {
    [self onTap:nil];
}

- (void)onTap:(UITapGestureRecognizer *)sender {
    [UIView animateWithDuration:.25f animations:^{
        self.actionView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)privateLayout {
    [self.view addSubview:self.actionView];
    [self.actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.offset(0.f);
        make.top.equalTo(self.view.mas_bottom);
    }];
}

- (UIView *)actionView {
    if (!_actionView) _actionView = [UIView new];
    return _actionView;
}
@end
