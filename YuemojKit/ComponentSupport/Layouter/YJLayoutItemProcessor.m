//
//  YJLayoutItemProcessor.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/7/10.
//

#import "YJLayoutItemProcessor.h"
#import "YJLayoutModels.h"

@implementation YJLayoutItemProcessor
+ (YJLayoutItem *)generateItemForScene:(int)scene componentTypeFetcher:(YJComponentType(* _Nonnull)(int))fetcher viewProvider:(__kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger))provider {
    YJLayoutItem *layoutItem = [YJLayoutItem new];
    [layoutItem bindView:provider(scene) withType:fetcher(scene) scene:scene];
    return layoutItem;
}

+ (YJLayoutItem *)generateItemWithComponentType:(YJComponentType)type viewProvider:(__kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger))provider {
    YJLayoutItem *layoutItem = [YJLayoutItem new];
    [layoutItem bindView:provider(0) withType:type];
    return layoutItem;
}
@end
