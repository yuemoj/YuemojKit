//
//  YJArrangeNamespace.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/15.
//

#import "YJUIKitNamespace.h"
#import "YuemojUIAbilities.h"
#import "UIKit+Yuemoj.h"

@interface YJArrangeNamespace ()<YuemojRearrangeAbility>
@end
@implementation YJArrangeNamespace
- (void (^)(YJButtonArrangeStyle))rearrange {
    return ^(YJButtonArrangeStyle style) {
        switch (style) {
            case YJButtonArrangeStyleTopImageBottomTitle: {
                UIButton *btn = self.owner;
                CGSize imgSize = btn.imageView.yj_frame.size;
                [btn.titleLabel sizeToFit];
                CGSize titleSize = btn.titleLabel.yj_frame.size;
                // label向左下偏移
                btn.titleEdgeInsets = UIEdgeInsetsMake(0.f, -imgSize.width, -imgSize.height-14.f, 0.f);
                // 图片向右上偏移
                btn.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height, 0.f, 0.f, -titleSize.width);
            } break;

            default: break;
        }
    };
}
@end
