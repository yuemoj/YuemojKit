//
//  YJActionTabLayoutViewModel.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/6/21.
//

#import "YJActionTabLayoutViewModel.h"

@implementation YJActionTabLayoutViewModel

@end

@implementation YJActionTabLayoutViewModel (ComponentDataSource)
- (YJComponentType)componentTypeForScene:(NSInteger)scene {
    return yj_componentTypeForActionTabScene((YJActionTabScene)scene);
}
@end
@implementation YJActionTabLayoutViewModel (Layout)
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutDescriptionsWithProvider:(__kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger))provider {
    if (!provider) return nil;
    NSMutableArray *descriptionArray = [NSMutableArray arrayWithCapacity:0];
    YJLayoutItem *dragItem = [YJLayoutItem new];
    [dragItem bindView:provider(YJActionTabSceneDrag) withType:[self componentTypeForScene:YJActionTabSceneDrag] scene:YJActionTabSceneDrag];
    YJLayoutItemConstraintDescription *dragDescription = [dragItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.top.yj_offset(self.padding.top);
        maker.centerX.yj_offset(0.f);
    }];
    [descriptionArray addObject:dragDescription];
    
    YJLayoutItem *lastPlaceholderItem = nil;
    for (int i = 0; i <= self.actionCount - 1; i++) {
        do {
            if (!i) break;
            YJLayoutItem *placeholderItem = [YJLayoutItem new];
            YJActionTabScene placeholderScene = YJActionTabScenePlaceholder + i;
            [placeholderItem bindView:provider(placeholderScene) withType:[self componentTypeForScene:placeholderScene] scene:placeholderScene];
            YJLayoutItemConstraintDescription *placeholderDescription = [placeholderItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
                maker.top.yj_offset(self.actionTopMargin);
                maker.height.yj_offset(self.actionSize.height);
                if (!lastPlaceholderItem) {
                    maker.leading.yj_offset(self.padding.left + self.actionSize.width);
                } else {
                    maker.leading.equalTo(lastPlaceholderItem.trailing).yj_offset(self.actionSize.width);
                    maker.width.equalTo(lastPlaceholderItem);
                }
            }];
            [descriptionArray addObject:placeholderDescription];
            lastPlaceholderItem = placeholderItem;
        } while (0);
        YJLayoutItem *btnItem = [YJLayoutItem new];
        YJActionTabScene scene = YJActionTabSceneFirstBtn + i;
        [btnItem bindView:provider(scene) withType:[self componentTypeForScene:scene] scene:scene];
        YJLayoutItemConstraintDescription *btnDescription = [btnItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
            maker.top.yj_offset(self.actionTopMargin);
            maker.leading.equalTo(lastPlaceholderItem ? lastPlaceholderItem.trailing : @(self.padding.left));
            maker.bottom.yj_offset(-self.padding.bottom);
            if (i == self.actionCount - 1) maker.trailing.yj_offset(-self.padding.right);
            
            maker.width.yj_offset(self.actionSize.width);
            maker.height.yj_offset(self.actionSize.height);
        }];
        [descriptionArray addObject:btnDescription];
    }
    return descriptionArray;
}
@end
