//
//  YJMaskTopLayoutViewModel.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/6/17.
//

#import "YJMaskTopLayoutViewModel.h"

@implementation YJMaskTopLayoutViewModel

@end

@implementation YJMaskTopLayoutViewModel (ComponentType)
- (YJComponentType)componentTypeForScene:(NSInteger)scene {
    return yj_componentTypeForTopMaskScene((YJMaskTopScene)scene);
}
@end

@implementation YJMaskTopLayoutViewModel (Layout)
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutDescriptionsWithProvider:(__kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger scene))provider {
    if (!provider) return nil;
    YJLayoutItem *closeItem = [YJLayoutItem new];
    [closeItem bindView:provider(YJMaskTopSceneClose) withType:[self componentTypeForScene:YJMaskTopSceneClose] scene:YJMaskTopSceneClose];
    YJLayoutItemConstraintDescription *closeDescrition = [closeItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.leading.yj_offset(self.leading);
        maker.centerY.yj_offset(self.centerYOffset);
    }];
    
    YJLayoutItem *titleItem = [YJLayoutItem new];
    [titleItem bindView:provider(YJMaskTopSceneTitle) withType:[self componentTypeForScene:YJMaskTopSceneTitle] scene:YJMaskTopSceneTitle];
    YJLayoutItemConstraintDescription *titleDescription = [titleItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.centerX.yj_offset(0.f);
        maker.centerY.equalTo(closeItem);
    }];
    
    YJLayoutItem *rightItem = [YJLayoutItem new];
    [rightItem bindView:provider(YJMaskTopSceneRightBarButton) withType:[self componentTypeForScene:YJMaskTopSceneRightBarButton] scene:YJMaskTopSceneRightBarButton];
    YJLayoutItemConstraintDescription *rightDescription = [rightItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.leading.greaterThanOrEqualTo(titleItem.trailing).yj_offset(10.f);
        maker.trailing.yj_offset(self.trailing);
        maker.centerY.equalTo(closeItem);
    }];
    return @[closeDescrition, titleDescription, rightDescription];
}
@end
