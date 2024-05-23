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
@property (nonatomic, weak) id<YJLayoutDelegate, YJLayoutOffsetDelegate> delegate;
@property (nonatomic, getter=isLayouted) BOOL layouted;
@end

@implementation YJLayouter
+ (instancetype)layouterWithDelegate:(id<YJLayoutDelegate, YJLayoutOffsetDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

- (instancetype)initWithDelegate:(id<YJLayoutDelegate, YJLayoutOffsetDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
}

- (void)didLayout {
    self.layouted = YES;
}

- (id<YJLayouterProtocol>  _Nonnull (^)(id<YJLayoutDataSource> _Nonnull, __kindof UIView * _Nonnull (NS_NOESCAPE^ _Nonnull)(NSInteger)))layout {
//- (id<YJLayouterProtocol>  _Nonnull (^)(id<YJLayoutDataSource> _Nonnull))layout {
    return ^(id<YJLayoutDataSource> dataSource, __kindof UIView * _Nonnull (^provider)(NSInteger)) {
        YJProtocolAssert(dataSource, @protocol(YJLayoutDataSource));
        YJSelectorAssert(dataSource, @selector(layoutDescriptionsWithProvider:));
        YJProtocolAssert(self.delegate, @protocol(YJLayoutDelegate));
        YJSelectorAssert(self.delegate, @selector(layoutWithItemDescriptions:));
        [YJComponentWrapper componentDidLoaded:self.isLayouted forScene:kYJDefaultPlaceHolderScene shouldUpdate:^BOOL(int scene){return NO;} action:^(int scene) {
            [(id<YJLayoutDelegate>)self.delegate layoutWithItemDescriptions:[dataSource layoutDescriptionsWithProvider:provider]];
        }];
        return self;
    };
}

- (id<YJLayouterProtocol>  _Nonnull (^)(id<YJLayoutDataSource> _Nonnull, NSInteger, __attribute__((noescape)) __kindof UIView * _Nonnull (^ _Nonnull)(NSInteger)))layoutInSection {
    return ^(id<YJLayoutDataSource> dataSource, NSInteger section, __kindof UIView * _Nonnull (^provider)(NSInteger)) {
        YJProtocolAssert(dataSource, @protocol(YJLayoutDataSource));
        YJSelectorAssert(dataSource, @selector(layoutDescriptionsInSection:provider:));
        YJProtocolAssert(self.delegate, @protocol(YJLayoutDelegate));
        YJSelectorAssert(self.delegate, @selector(layoutWithItemDescriptions:));
        [YJComponentWrapper componentDidLoaded:self.isLayouted forScene:kYJDefaultPlaceHolderScene shouldUpdate:^BOOL(int scene){return NO;} action:^(int scene) {
            [(id<YJLayoutDelegate>)self.delegate layoutWithItemDescriptions:[dataSource layoutDescriptionsInSection:section provider:provider]];
        }];
        return self;
    };
}

- (id<YJLayouterProtocol>  _Nonnull (^)(id<YJLayoutDataSource> _Nonnull, NSIndexPath * _Nonnull, __attribute__((noescape)) __kindof UIView * _Nonnull (^ _Nonnull)(NSInteger)))layoutAtIndexPath {
    return ^(id<YJLayoutDataSource> dataSource, NSIndexPath *indexPath, __kindof UIView * _Nonnull (^provider)(NSInteger)) {
        YJProtocolAssert(dataSource, @protocol(YJLayoutDataSource));
        YJSelectorAssert(dataSource, @selector(layoutDescriptionsAtIndexPath:provider:));
        YJProtocolAssert(self.delegate, @protocol(YJLayoutDelegate));
        YJSelectorAssert(self.delegate, @selector(layoutWithItemDescriptions:));
        [YJComponentWrapper componentDidLoaded:self.isLayouted forScene:kYJDefaultPlaceHolderScene shouldUpdate:^BOOL(int scene){return NO;} action:^(int scene) {
            [(id<YJLayoutDelegate>)self.delegate layoutWithItemDescriptions:[dataSource layoutDescriptionsAtIndexPath:indexPath provider:provider]];
        }];
        return self;
    };
}

- (id<YJLayouterProtocol> _Nonnull (^)(id<YJLayoutOffsetDataSource, YJComponentDataSource> _Nonnull, NSNumber * _Nullable, ...))layoutOffset {
    return ^(id<YJLayoutOffsetDataSource, YJComponentDataSource> dataSource, NSNumber * _Nullable scene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJLayoutOffsetDataSource));
        YJSelectorAssert(dataSource, @selector(offsetForScene:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJLayoutOffsetDelegate));
        YJSelectorAssert(self.delegate, @selector(layoutComponent:forScene:withOffset:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJLayoutShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateOffsetForScene:)]) {
                return [(id<YJLayoutShouldUpdateDataSource>)dataSource shouldUpdateOffsetForScene:nextScene];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            UIOffset offset = [dataSource offsetForScene:nextScene];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [(id<YJLayoutOffsetDelegate>)self.delegate layoutComponent:type forScene:nextScene withOffset:offset];
        };
        if (scene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isLayouted forScene:kYJDefaultPlaceHolderScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, scene);
            [YJComponentWrapper componentDidLoaded:self.isLayouted forScene:scene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJLayouterProtocol> _Nonnull (^)(id<YJLayoutOffsetDataSource, YJComponentDataSource> _Nonnull, NSInteger, NSNumber * _Nullable, ...))layoutOffsetInSection {
    return ^(id<YJLayoutOffsetDataSource, YJComponentDataSource> dataSource, NSInteger section, NSNumber * _Nullable scene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJLayoutOffsetDataSource));
        YJSelectorAssert(dataSource, @selector(offsetForScene:inSection:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJLayoutOffsetDelegate));
        YJSelectorAssert(self.delegate, @selector(layoutComponent:forScene:withOffset:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJLayoutShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateOffsetForScene:)]) {
                return [(id<YJLayoutShouldUpdateDataSource>)dataSource shouldUpdateOffsetForScene:nextScene];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            UIOffset offset = [dataSource offsetForScene:nextScene inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [(id<YJLayoutOffsetDelegate>)self.delegate layoutComponent:type forScene:nextScene withOffset:offset];
        };
        if (scene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isLayouted forScene:kYJDefaultPlaceHolderScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, scene);
            [YJComponentWrapper componentDidLoaded:self.isLayouted forScene:scene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJLayouterProtocol> _Nonnull (^)(id<YJLayoutOffsetDataSource, YJComponentDataSource> _Nonnull, NSIndexPath * _Nonnull, NSNumber * _Nullable, ...))layoutOffsetAtIndexPath {
    return ^(id<YJLayoutOffsetDataSource, YJComponentDataSource> dataSource, NSIndexPath * _Nonnull indexPath, NSNumber * _Nullable scene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJLayoutOffsetDataSource));
        YJSelectorAssert(dataSource, @selector(offsetForScene:indexPath:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJLayoutOffsetDelegate));
        YJSelectorAssert(self.delegate, @selector(layoutComponent:forScene:withOffset:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJLayoutShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateOffsetForScene:)]) {
                return [(id<YJLayoutShouldUpdateDataSource>)dataSource shouldUpdateOffsetForScene:nextScene];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            UIOffset offset = [dataSource offsetForScene:nextScene indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [(id<YJLayoutOffsetDelegate>)self.delegate layoutComponent:type forScene:nextScene withOffset:offset];
        };
        if (scene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isLayouted forScene:kYJDefaultPlaceHolderScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, scene);
            [YJComponentWrapper componentDidLoaded:self.isLayouted forScene:scene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}
@end

