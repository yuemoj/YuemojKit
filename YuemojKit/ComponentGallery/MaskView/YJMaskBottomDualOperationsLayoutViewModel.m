//
//  YJMaskBottomDualOperationsLayoutViewModel.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/6/17.
//

#import "YJMaskBottomDualOperationsLayoutViewModel.h"

@implementation YJMaskBottomDualOperationsLayoutViewModel

@end

@implementation YJMaskBottomDualOperationsLayoutViewModel (ComponentType)
- (YJComponentType)componentTypeForScene:(NSInteger)scene {
    return yj_componentTypeForDualBottomMaskScene((YJMaskBottomDualScene)scene);
}
@end
@implementation YJMaskBottomDualOperationsLayoutViewModel (Layout)
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutDescriptionsWithProvider:(__kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger))provider {
    if (!provider) return nil;
    YJLayoutItem *lineItem = [YJLayoutItem new];
    [lineItem bindView:provider(YJMaskBottomDualSceneLine) withType:[self componentTypeForScene:YJMaskBottomDualSceneLine] scene:YJMaskBottomDualSceneLine];
    YJLayoutItemConstraintDescription *lineDescription = [lineItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.top.leading.trailing.yj_offset(0.f);
        maker.height.yj_offset(1.f);
    }];
    
    YJLayoutItem *leftItem = [YJLayoutItem new];
    [leftItem bindView:provider(YJMaskBottomDualSceneLeftOperation) withType:[self componentTypeForScene:YJMaskBottomDualSceneLeftOperation] scene:YJMaskBottomDualSceneLeftOperation];
    YJLayoutItemConstraintDescription *leftDescription = [leftItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.centerX.multipliedBy(.6f);
        maker.centerY.yj_offset(0.f);
    }];
    
    YJLayoutItem *rightItem = [YJLayoutItem new];
    [rightItem bindView:provider(YJMaskBottomDualSceneRightOperation) withType:[self componentTypeForScene:YJMaskBottomDualSceneRightOperation] scene:YJMaskBottomDualSceneRightOperation];
    YJLayoutItemConstraintDescription *rightDescription = [rightItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.centerX.multipliedBy(1.4f);
        maker.centerY.yj_offset(0.f);
    }];
    
    return @[lineDescription, leftDescription, rightDescription];
}
@end
