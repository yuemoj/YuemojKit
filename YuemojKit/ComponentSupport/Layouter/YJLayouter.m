//
//  YJLayouter.m
//  YuemojKit
//
//  Created by Yuemoj on 2023/5/8.
//

#import "YJLayouter.h"
#import "YJComponentWrapper.h"
#import "YJLayoutDataSource.h"
#import "YJComponentDataSource.h"
#import "YJLayoutDelegate.h"

@interface YJLayouter ()
@property (nonatomic, weak) id<YJLayoutDelegate> delegate;
@property (nonatomic, getter=isLayouted) BOOL layouted;
@end

@implementation YJLayouter
+ (instancetype)layouterWithDelegate:(id<YJLayoutDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

- (instancetype)initWithDelegate:(id<YJLayoutDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
}

- (void)didLayout {
    self.layouted = YES;
}

- (id<YJLayouterProtocol>  _Nonnull (^)(id<YJLayoutDataSource> _Nonnull, __kindof UIView * _Nonnull (NS_NOESCAPE^ _Nonnull)(NSInteger)))layout {
    return ^(id<YJLayoutDataSource> dataSource, __kindof UIView * _Nonnull (^provider)(NSInteger)) {
        YJProtocolAssert(dataSource, @protocol(YJLayoutDataSource));
        YJSelectorAssert(dataSource, @selector(layoutDescriptionsWithProvider:));
        YJProtocolAssert(self.delegate, @protocol(YJLayoutDelegate));
        YJSelectorAssert(self.delegate, @selector(layoutWithItemDescriptions:));
        if (!self.isLayouted) [(id<YJLayoutDelegate>)self.delegate layoutWithItemDescriptions:[dataSource layoutDescriptionsWithProvider:provider]];
        return self;
    };
}

- (id<YJLayouterProtocol>  _Nonnull (^)(id<YJLayoutDataSource> _Nonnull, NSInteger, __attribute__((noescape)) __kindof UIView * _Nonnull (^ _Nonnull)(NSInteger)))layoutInSection {
    return ^(id<YJLayoutDataSource> dataSource, NSInteger section, __kindof UIView * _Nonnull (^provider)(NSInteger)) {
        YJProtocolAssert(dataSource, @protocol(YJLayoutDataSource));
        YJSelectorAssert(dataSource, @selector(layoutDescriptionsInSection:provider:));
        YJProtocolAssert(self.delegate, @protocol(YJLayoutDelegate));
        YJSelectorAssert(self.delegate, @selector(layoutWithItemDescriptions:));
        if (!self.isLayouted) [(id<YJLayoutDelegate>)self.delegate layoutWithItemDescriptions:[dataSource layoutDescriptionsInSection:section provider:provider]];
        return self;
    };
}

- (id<YJLayouterProtocol>  _Nonnull (^)(id<YJLayoutDataSource> _Nonnull, NSIndexPath * _Nonnull, __attribute__((noescape)) __kindof UIView * _Nonnull (^ _Nonnull)(NSInteger)))layoutAtIndexPath {
    return ^(id<YJLayoutDataSource> dataSource, NSIndexPath *indexPath, __kindof UIView * _Nonnull (^provider)(NSInteger)) {
        YJProtocolAssert(dataSource, @protocol(YJLayoutDataSource));
        YJSelectorAssert(dataSource, @selector(layoutDescriptionsAtIndexPath:provider:));
        YJProtocolAssert(self.delegate, @protocol(YJLayoutDelegate));
        YJSelectorAssert(self.delegate, @selector(layoutWithItemDescriptions:));
        if (!self.isLayouted) [(id<YJLayoutDelegate>)self.delegate layoutWithItemDescriptions:[dataSource layoutDescriptionsAtIndexPath:indexPath provider:provider]];
        return self;
    };
}

- (id<YJLayouterProtocol>  _Nonnull (^)(id<YJLayoutUpdateDataSource,YJComponentDataSource> _Nonnull))layoutUpdate {
    return ^(id<YJLayoutUpdateDataSource, YJComponentDataSource> dataSource) {
        YJProtocolAssert(dataSource, @protocol(YJLayoutUpdateDataSource));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(layoutUpdateDescriptionsWithFetcher:));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJLayoutDelegate));
        YJSelectorAssert(self.delegate, @selector(layoutUpdateWithItemDescriptions:));
        YJSelectorAssert(self.delegate, @selector(layoutItemForIdentifier:));
        NSArray<YJLayoutItemConstraintDescription *> *descriptions = [dataSource layoutUpdateDescriptionsWithFetcher:^YJLayoutItem * _Nonnull(NSInteger scene) {
            YJComponentType type = [dataSource componentTypeForScene:scene];
            return [self.delegate layoutItemForIdentifier:yj_componentIdentifier(type, scene)];
        }];
        [self.delegate layoutUpdateWithItemDescriptions:descriptions];
        return self;
    };
}

- (id<YJLayouterProtocol>  _Nonnull (^)(id<YJLayoutUpdateDataSource,YJComponentDataSource> _Nonnull, NSInteger))layoutUpdateInSection {
    return ^(id<YJLayoutUpdateDataSource, YJComponentDataSource> dataSource, NSInteger section) {
        YJProtocolAssert(dataSource, @protocol(YJLayoutUpdateDataSource));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(layoutUpdateDescriptionsInSection:fetcher:));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:inSection:));
        YJProtocolAssert(self.delegate, @protocol(YJLayoutDelegate));
        YJSelectorAssert(self.delegate, @selector(layoutUpdateWithItemDescriptions:));
        YJSelectorAssert(self.delegate, @selector(layoutItemForIdentifier:));
        NSArray<YJLayoutItemConstraintDescription *> *descriptions = [dataSource layoutUpdateDescriptionsInSection:section fetcher:^YJLayoutItem * _Nonnull(NSInteger scene) {
            YJComponentType type = [dataSource componentTypeForScene:scene inSection:section];
            return [self.delegate layoutItemForIdentifier:yj_componentIdentifier(type, scene)];
        }];
        [self.delegate layoutUpdateWithItemDescriptions:descriptions];
        return self;
    };
}

- (id<YJLayouterProtocol>  _Nonnull (^)(id<YJLayoutUpdateDataSource,YJComponentDataSource> _Nonnull, NSIndexPath * _Nonnull))layoutUpdateAtIndexPath {
    return ^(id<YJLayoutUpdateDataSource, YJComponentDataSource> dataSource, NSIndexPath *indexPath) {
        YJProtocolAssert(dataSource, @protocol(YJLayoutUpdateDataSource));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(layoutUpdateDescriptionsAtIndexPath:fetcher:));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:indexPath:));
        YJProtocolAssert(self.delegate, @protocol(YJLayoutDelegate));
        YJSelectorAssert(self.delegate, @selector(layoutUpdateWithItemDescriptions:));
        YJSelectorAssert(self.delegate, @selector(layoutItemForIdentifier:));
        NSArray<YJLayoutItemConstraintDescription *> *descriptions = [dataSource layoutUpdateDescriptionsAtIndexPath:indexPath fetcher:^YJLayoutItem * _Nonnull(NSInteger scene) {
            YJComponentType type = [dataSource componentTypeForScene:scene indexPath:indexPath];
            return [self.delegate layoutItemForIdentifier:yj_componentIdentifier(type, scene)];
        }];
        [self.delegate layoutUpdateWithItemDescriptions:descriptions];
        return self;
    };
}
@end

