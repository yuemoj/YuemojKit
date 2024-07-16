//
//  YJActionSheetLayoutViewModel.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/6/21.
//

#import "YJActionSheetLayoutViewModel.h"

@implementation YJActionSheetLayoutViewModel

@end

@implementation YJActionSheetLayoutViewModel (ComponentDataSource)
- (YJComponentType)componentTypeForScene:(NSInteger)scene {
    return yj_componentTypeForActionSheetScene((YJActionSheetScene)scene);
}
@end

@implementation YJActionSheetLayoutViewModel (Layout)
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutDescriptionsWithProvider:(__kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger))provider {
    if (!provider) return nil;
    NSMutableArray *descriptionArray = [NSMutableArray arrayWithCapacity:0];
    YJLayoutItem *dragItem = [YJLayoutItem new];
    [dragItem bindView:provider(YJActionSheetSceneDrag) withType:[self componentTypeForScene:YJActionSheetSceneDrag] scene:YJActionSheetSceneDrag];
    YJLayoutItemConstraintDescription *dragDescription = [dragItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.top.yj_offset(self.padding.top);
        maker.centerX.yj_offset(0.f);
    }];
    [descriptionArray addObject:dragDescription];
    
    YJLayoutItem *lastItem = nil;
    for (int i = 0; i <= self.actionCount - 1; i++) {
        do {
            if (!i) break;
            YJLayoutItem *splitItem = [YJLayoutItem new];
            NSInteger splitScene = YJActionSheetSceneFirstSplit + i;
            [splitItem bindView:provider(splitScene) withType:[self componentTypeForScene:splitScene] scene:splitScene];
            YJLayoutItemConstraintDescription *splitDescription = [splitItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
                maker.top.equalTo(lastItem.bottom);
                maker.leading.yj_offset(self.padding.left);
                maker.trailing.yj_offset(-self.padding.right);
                maker.height.yj_offset(self.splitHeight);
            }];
            [descriptionArray addObject:splitDescription];
            lastItem = splitItem;
        } while (0);
        
        YJLayoutItem *btnItem = [YJLayoutItem new];
        YJActionSheetScene scene = YJActionSheetSceneFirstBtn + i;
        [btnItem bindView:provider(scene) withType:[self componentTypeForScene:scene] scene:scene];
        YJLayoutItemConstraintDescription *btnDescription = [btnItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
            if (lastItem) maker.top.equalTo(lastItem.bottom);
            else maker.top.equalTo(dragItem.bottom).yj_offset(self.actionTopMargin);
//            maker.top.equalTo(lastItem ? lastItem.bottom : @(self.actionTopMargin));
            maker.leading.yj_offset(self.padding.left);
            maker.trailing.yj_offset(-self.padding.right);
            maker.height.yj_offset(self.actionHeight);
            if (i == self.actionCount - 1) maker.bottom.yj_offset(-self.padding.bottom);
        }];
        [descriptionArray addObject:btnDescription];
        lastItem = btnItem;
    }
    return descriptionArray;
}
@end
