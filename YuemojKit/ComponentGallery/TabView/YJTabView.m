//
//  YJTabView.m
//  NetworkSalesController
//
//  Created by HYT200841559 on 2023/4/25.
//

#import "YJTabView.h"
#import "YJTabEnums.h"
#import "UIKit+Yuemoj.h"
@interface YJTabView ()
@property (nonatomic) NSInteger selectedScene;
@end

@implementation YJTabView
- (void)eventWillBeganAtComponent:(__kindof UIView *)component {
    YJComponentType type = (YJComponentType)yj_componentType(component.yj_extra.jTag);
    if (type != YJComponentTypeButton) return;
    if (((UIButton *)component).selected) return;
    [self tabButtonTransform:component];
    [self indicatorTransformToTabButton:component];
    self.selectedScene = yj_componentScene(component.yj_extra.jTag);
}

- (void)tabButtonTransform:(UIButton *)sender {
    UIButton *lastTabBtn = self.yj_extra.viewForIdentifier(YJComponentTypeButton, self.selectedScene);
    [self layoutIfNeeded];
    
    if (self.transformScale > 0.f) {
        [UIView animateWithDuration:.25f animations:^{
            sender.transform = CGAffineTransformMakeScale(self.transformScale, self.transformScale);
            lastTabBtn.transform = CGAffineTransformIdentity;
        }];
    }
}

- (void)indicatorTransformToTabButton:(__kindof UIView *)sender {
    UIView *indicatorView = self.yj_extra.viewForIdentifier(YJComponentTypeView, YJTabSceneIndicator);
    if (!indicatorView) return;
    //    CGFloat distance = sender.yj.centerX - self.signView.yj.centerX; 仿射变换后 center没变
    CGFloat distance = sender.yj_frame.left - indicatorView.yj_frame.left + (sender.yj_frame.width - indicatorView.yj_frame.width) * .5f;
    [UIView animateWithDuration:.25f animations:^{
        indicatorView.transform = CGAffineTransformTranslate(indicatorView.transform, distance, 0);
    }];
}
@end
