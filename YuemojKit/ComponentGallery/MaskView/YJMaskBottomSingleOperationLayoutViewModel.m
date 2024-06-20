//
//  YJMaskBottomSingleOperationLayoutViewModel.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/6/17.
//

#import "YJMaskBottomSingleOperationLayoutViewModel.h"

@implementation YJMaskBottomSingleOperationLayoutViewModel

@end

@implementation YJMaskBottomSingleOperationLayoutViewModel (ComponentType)
- (YJComponentType)componentTypeForScene:(NSInteger)scene {
    return yj_componentTypeForSingleBottomMaskScene((YJMaskBottomSingleScene)scene);
}
@end

@implementation YJMaskBottomSingleOperationLayoutViewModel (Layout)
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutDescriptionsWithProvider:(__kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger))provider {
    if (!provider) return nil;
    YJLayoutItem *lineItem = [YJLayoutItem new];
    [lineItem bindView:provider(YJMaskBottomSingleSceneLine) withType:[self componentTypeForScene:YJMaskBottomSingleSceneLine] scene:YJMaskBottomSingleSceneLine];
    YJLayoutItemConstraintDescription *lineDescription = [lineItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.top.leading.trailing.yj_offset(0.f);
        maker.height.yj_offset(1.f);
    }];
    
    YJLayoutItem *hintItem = [YJLayoutItem new];
    [hintItem bindView:provider(YJMaskBottomSingleSceneHint) withType:[self componentTypeForScene:YJMaskBottomSingleSceneHint] scene:YJMaskBottomSingleSceneHint];
    YJLayoutItemConstraintDescription *hintDescription = [hintItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.centerY.yj_offset(self.centerYOffset);
        maker.leading.yj_offset(self.leading);
    }];
    
    YJLayoutItem *countItem = [YJLayoutItem new];
    [countItem bindView:provider(YJMaskBottomSingleSceneCount) withType:[self componentTypeForScene:YJMaskBottomSingleSceneCount] scene:YJMaskBottomSingleSceneCount];
    YJLayoutItemConstraintDescription *countDescription = [countItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.centerY.equalTo(hintItem);
        maker.leading.equalTo(hintItem.trailing).yj_offset(8.f);
    }];
       
    YJLayoutItem *operationItem = [YJLayoutItem new];
    [operationItem bindView:provider(YJMaskBottomSingleSceneOperation) withType:[self componentTypeForScene:YJMaskBottomSingleSceneOperation] scene:YJMaskBottomSingleSceneOperation];
    YJLayoutItemConstraintDescription *operationDescription = [operationItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.centerY.equalTo(hintItem);
        maker.trailing.yj_offset(self.trailing);
        maker.width.yj_offset(self.operateBtnSize.width);
        maker.height.yj_offset(self.operateBtnSize.height);
    }];
    
    return @[lineDescription, hintDescription, countDescription, operationDescription];
}

@end
