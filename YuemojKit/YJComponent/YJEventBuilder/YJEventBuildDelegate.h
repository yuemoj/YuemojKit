//
//  YJEventBuildDelegate.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/15.
//

#import <Foundation/Foundation.h>
#import "YJComponentEnum.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YJEventBuildGestureDelegate <NSObject>
@optional
- (void)buildComponent:(YJComponentType)type forScene:(NSInteger)scene withGestureRecognizer:(__kindof UIGestureRecognizer * _Nonnull(^)(id target, SEL))aRecognizer action:(BOOL(^)(__kindof UIView *, NSInteger))anEvent;
@end

@protocol YJEventBuildControlDelegate <NSObject>
@optional
- (void)buildComponent:(YJComponentType)type forScene:(NSInteger)scene controlEvents:(UIControlEvents)controlEvents action:(BOOL(^)(__kindof UIControl *sender, NSInteger scene))anEvent;
@end

@protocol YJEventBuildDelegate <YJEventBuildGestureDelegate, YJEventBuildControlDelegate>
@end
NS_ASSUME_NONNULL_END
