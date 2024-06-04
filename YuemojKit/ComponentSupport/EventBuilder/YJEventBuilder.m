//
//  CommonComponentTouchMaker.m
//  YuemojKit
//
//  Created by Yuemoj on 2022/1/6.
//

#import "YJEventBuilder.h"
#import "YJEventBuildDelegate.h"
#import "YJComponentDataSource.h"
#import "YJComponentWrapper.h"

@interface YJEventBuilder ()
@property (nonatomic, weak) id<YJEventBuildDelegate> delegate;
@property (nonatomic, getter=isBuilded) BOOL builded; // 记录是否已经加载过, 一般在buildEvent后设为YES
//@property (nonatomic, copy, nullable) void(^gestureRecognizer)(__kindof UIGestureRecognizer *);
/// TODO: btn action 多种不同的手势 或者不同的事件处理 同时存在呢? 后面的会覆盖前面的 -- 参考UIAlertAction实现
///
//@property (nonatomic, copy, nullable) BOOL(^btnAction)(__kindof UIButton *);
//@property (nonatomic, nullable) NSIndexPath *btnIndexPath;
@end

@implementation YJEventBuilder
+ (instancetype)eventBuilderWithDelegate:(id<YJEventBuildDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

- (instancetype)initWithDelegate:(id<YJEventBuildDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
}

- (void)didBuild {
    self.builded = YES;
}

- (id<YJEventBuilderProtocol>  _Nonnull (^)(id<YJComponentDataSource> _Nonnull, __kindof UIGestureRecognizer * _Nonnull (^ _Nonnull)(id _Nonnull, SEL _Nonnull), BOOL (^ _Nonnull)(id _Nonnull, __kindof UIView * _Nonnull, NSInteger), NSNumber * _Nullable, ...))addActionForGestureRecognizer {
    return ^(id<YJComponentDataSource,YJComponentDataSource> dataSource, __kindof UIGestureRecognizer *(^gestureBuilder)(id, SEL), BOOL (^action)(id, __kindof UIView * _Nonnull, NSInteger), NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJEventBuildGestureDelegate));
        YJSelectorAssert(self.delegate, @selector(buildComponent:forScene:withGestureRecognizer:action:));
        void(^build)(int) = ^(int nextScene) {
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate buildComponent:type forScene:nextScene withGestureRecognizer:gestureBuilder action:^BOOL(__kindof UIView * _Nonnull view, NSInteger scene) {
                if (!action) return NO;
                return action(self.delegate, view, scene);
            }];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isBuilded forScene:kYJDefaultPlaceHolderScene shouldUpdate:nil action:build];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isBuilded forScene:firstScene args:args shouldUpdate:nil action:build];
        }
        return self;
    };
}

- (id<YJEventBuilderProtocol>  _Nonnull (^)(id<YJComponentDataSource> _Nonnull, UIControlEvents, BOOL (^ _Nonnull)(id _Nonnull, __kindof UIControl * _Nonnull, NSInteger), NSNumber * _Nullable, ...))addActionForControlEvents {
    YJProtocolAssert(self.delegate, @protocol(YJEventBuildDelegate));
    YJSelectorAssert(self.delegate, @selector(buildComponent:forScene:controlEvents:action:));
    return ^(id<YJComponentDataSource> _Nonnull dataSource, UIControlEvents controlEvents, BOOL (^action)(id owner, __kindof UIControl * _Nonnull, NSInteger), NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        void(^build)(int) = ^(int nextScene) {
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate buildComponent:type forScene:nextScene controlEvents:controlEvents action:^BOOL(__kindof UIControl * _Nonnull sender, NSInteger scene) {
                if (!action) return NO;
                return action(self.delegate, sender, scene);
            }];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isBuilded forScene:kYJDefaultPlaceHolderScene shouldUpdate:nil action:build];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isBuilded forScene:firstScene args:args shouldUpdate:nil action:build];
        }
        return self;
    };
}
@end

