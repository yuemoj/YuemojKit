//
//  UIKit+Yuemoj.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/15.
//

#import <UIKit/UIKit.h>
#import "YuemojMacros.h"
#import "YuemojUIAbilities.h"

NS_ASSUME_NONNULL_BEGIN

@YJNamespaceInstanceDeclaration(UIView, NSObject, yj_extra, YuemojExtraAbility)
@end

@YJNamespaceInstanceDeclaration(UIView, NSObject, yj_frame, YuemojFrameAbility)
@end

@YJNamespaceInstanceDeclaration(UIView, NSObject, yj_action, YuemojActionAbility)
@end

@YJNamespaceInstanceDeclaration(UIButton, NSObject, yj_arrange, YuemojRearrangeAbility)
@end

@YJNamespaceInstanceDeclaration(UILabel, NSObject, yj_hyperlink, YuemojHyperlinkAbility)
@end

NS_ASSUME_NONNULL_END
