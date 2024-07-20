//
//  YJInputLayoutViewModel.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/6/28.
//

#import "YJInputLayoutViewModel.h"
#import "YJInputViewScene.h"
#import "YJLayoutItemProcessor.h"

@implementation YJInputLayoutViewModel
//- (YJComponentType)componentTypeForScene:(NSInteger)scene {
//    return yj_componentTypeForInputViewScene((YJInputViewScene)scene);
//}

- (NSArray<YJLayoutItemConstraintDescription *> *)layoutDescriptionsWithProvider:(__kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger))provider {
    if (!provider) return nil;
    
    NSMutableArray<YJLayoutItemConstraintDescription *> *descriptionArray = [NSMutableArray arrayWithCapacity:0];
    YJLayoutItem *inputItem = [YJLayoutItemProcessor generateItemForScene:YJInputViewSceneTextField componentTypeFetcher:yj_componentTypeForInputViewScene viewProvider:provider];
    YJLayoutItemConstraintDescription *inputDescription = [inputItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        if (!self.shouldDisplayRightView) {
            maker.edges.insets(self.padding);
            return;
        }
        maker.top.yj_offset(self.padding.top);
        maker.leading.yj_offset(self.padding.left);
        maker.bottom.yj_offset(self.padding.bottom);
    }];
    [descriptionArray addObject:inputDescription];
    
    if (self.shouldDisplayRightView) {
        YJLayoutItem *rightItem = [YJLayoutItemProcessor generateItemForScene:YJInputViewSceneRightView componentTypeFetcher:yj_componentTypeForInputViewScene viewProvider:provider];
        YJLayoutItemConstraintDescription *rightDescription = [rightItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
            maker.leading.equalTo(inputItem.trailing).yj_offset(self.leftMarginForRightView);
            maker.trailing.yj_offset(-self.padding.right);
            maker.centerY.equalTo(inputItem);
        }];
        [descriptionArray addObject:rightDescription];
    }
    
    return descriptionArray;
}
@end
