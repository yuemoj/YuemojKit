//
//  YJTabLayoutViewModel.m
//  YuemojKit
//
//  Created by HYT200841559 on 2024/5/31.
//

#import "YJTabLayoutViewModel.h"
#import "YJTabEnums.h"

@implementation YJTabLayoutViewModel

@end

@implementation YJTabLayoutViewModel (ComponentType)
- (YJComponentType)componentTypeForScene:(NSInteger)scene {
    return tabComponentTypeForScene((YJTabScene)scene);
}
@end

@implementation YJTabLayoutViewModel (Layout)
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutDescriptionsWithProvider:(__kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger))provider {
    if (!self.tabCount) return nil;
    if (!provider) return nil;
    CGFloat horizontalSpace = self.shouldSplit ? 12.f : 10.f;
    NSMutableArray<YJLayoutItemConstraintDescription *> *itemConstraintDescriptions = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.tabCount; i++) {
        YJLayoutItem *btnItem = YJLayoutItem.new;
        NSInteger btnScene = YJTabSceneFirstTabBtn + i;
        [btnItem bindView:provider(btnScene) withType:[self componentTypeForScene:btnScene] scene:btnScene];
        YJLayoutItemConstraintDescription *btnDescription = [btnItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
            maker.top.yj_offset(0.f);
            maker.bottom.yj_offset(0.f);
            if (!i) maker.leading.yj_offset(0.f);
            else {
                YJLayoutItem *lastItem = itemConstraintDescriptions[i * (self.shouldSplit ? 2 : 1) - 1].firstItem;
                maker.leading.equalTo(lastItem.trailing).yj_offset(horizontalSpace);
                if (i == self.tabCount - 1) maker.trailing.yj_offset(0.f);
            }
        }];
        [itemConstraintDescriptions addObject:btnDescription];
        
        if (i < self.tabCount -1 && self.shouldSplit) {
            YJLayoutItem *splitItem = YJLayoutItem.new;
            NSInteger splitScene = YJTabSceneFirstSplit + i;
            [splitItem bindView:provider(splitScene) withType:[self componentTypeForScene:splitScene] scene:splitScene];
            YJLayoutItemConstraintDescription *splitDescription = [splitItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
                maker.leading.equalTo(btnItem.trailing).yj_offset(horizontalSpace);
                maker.centerY.yj_offset(0.f);
                maker.width.equalTo(@2.f);
                maker.height.equalTo(@17.f);
            }];
            [itemConstraintDescriptions addObject:splitDescription];
        }
    }
    
    do {
        if (self.indicatorStyle == YJTabViewIndicatorStyleNone) break;
        YJLayoutItem *indicatorItem = YJLayoutItem.new;
        [indicatorItem bindView:provider(YJTabSceneIndicator) withType:[self componentTypeForScene:YJTabSceneIndicator] scene:YJTabSceneIndicator];
        YJLayoutItem *firstItem = itemConstraintDescriptions.firstObject.firstItem;
        YJLayoutItemConstraintDescription *indicatorDescription = [indicatorItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
            switch (self.indicatorStyle) {
                case YJTabViewIndicatorStyleUnderline: {
                    maker.centerX.equalTo(firstItem);
                    maker.bottom.equalTo(firstItem).yj_offset(3.f);
                    maker.width.equalTo(@30.f);
                    maker.height.equalTo(@3.f);
                } break;
                case YJTabViewIndicatorStyleBackground: {
                    maker.edges.equalTo(firstItem).insets(UIEdgeInsetsMake(-2.f, -5.f, -2.f, -5.f));
                } break;
                default: break;
            }
        }];
        indicatorDescription.belowItem = firstItem;
        [itemConstraintDescriptions addObject:indicatorDescription];
    } while (0);
    return itemConstraintDescriptions;
}
@end

