//
//  YJEventBuildNamespace.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/15.
//

#import "YJEventBuildNamespace.h"
#import "YJEventBuilder.h"
#import "UIKit+Yuemoj.h"

@interface YJEventBuildNamespace ()<YJEventBuildAbility>
@property (nonatomic) YJEventBuilder *eventBuilder;

@end
@implementation YJEventBuildNamespace
- (void (^)(void (^ _Nonnull)(id<YJEventBuilderProtocol> _Nonnull)))buildEvent {
    return ^(void(^build)(id<YJEventBuilderProtocol>)) {
        if (build) build(self.eventBuilder);
    };
}

- (YJEventBuilder *)eventBuilder {
    if (!_eventBuilder) _eventBuilder = [YJEventBuilder eventBuilderWithDelegate:(id<YJEventBuildDelegate>)self];
    return _eventBuilder;;
}
@end

#import "YJEventBuildDelegate.h"
@interface YJEventBuildNamespace (EventBuildDelegate)<YJEventBuildDelegate>
@end
@implementation YJEventBuildNamespace (EventBuildDelegate)
- (void)buildComponent:(YJComponentType)type forScene:(NSInteger)scene withGestureRecognizer:(__kindof UIGestureRecognizer * _Nonnull (^)(id _Nonnull, SEL _Nonnull))aRecognizer action:(BOOL (^)(__kindof UIView * _Nonnull, NSInteger))anEvent {
    __kindof UIView *component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    if (!aRecognizer) return;
    [component addGestureRecognizer:aRecognizer(self, @selector(onGestureEventTrigged:))];
    component.yj_action.extendAction = anEvent;
}

- (void)buildComponent:(YJComponentType)type forScene:(NSInteger)scene controlEvents:(UIControlEvents)controlEvents action:(BOOL (^)(__kindof UIControl * _Nonnull, NSInteger))anEvent {
    __kindof UIView *component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    [component addTarget:self action:@selector(onControlEventTrigged:) forControlEvents:controlEvents];
    component.yj_action.extendAction = anEvent;
}

- (void)onGestureEventTrigged:(__kindof UIGestureRecognizer *)sender {
    if (!sender.view.yj_action.extendAction) return;
    if (!sender.view.yj_action.extendAction(sender.view, yj_componentScene(sender.view.yj_extra.jTag))) return;
    // do sth
}

- (void)onControlEventTrigged:(__kindof UIControl *)sender {
    if (!sender.yj_action.extendAction) return;
    sender.yj_action.extendAction(sender, yj_componentScene(sender.yj_extra.jTag));
}
@end
