//
//  YJEventBuilderProtocol.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YuemojMacros.h"
#import "YuemojCoreTypes.h"

NS_ASSUME_NONNULL_BEGIN
//typedef YJComponentType(^YJComponentTypeFetcher)(NSInteger scene);
@protocol YJComponentDataSource;
@protocol YJEventBuilderProtocol <NSObject>
@optional
//@property (nonatomic, copy, readonly) id<YJEventBuilderProtocol>(^addActionForGestureRecognizer)(id<YJComponentDataSource> dataSource, __kindof UIGestureRecognizer *(^maker)(id, SEL), BOOL(^handler)(id owner, __kindof UIView *, NSInteger), NSNumber * _Nullable firstScene, ...);
@property (nonatomic, copy, readonly) id<YJEventBuilderProtocol>(^addActionForGestureRecognizer)(YJComponentType(NS_NOESCAPE ^fetcher)(NSInteger), __kindof UIGestureRecognizer *(^maker)(id, SEL), BOOL(^handler)(id owner, __kindof UIView *, NSInteger), NSNumber * _Nullable firstScene, ...);
@property (nonatomic, copy, readonly) id<YJEventBuilderProtocol>(^addActionForControlEvents)(UIControlEvents, YJComponentType(NS_NOESCAPE ^fetcher)(NSInteger), BOOL(^)(id owner, __kindof UIControl*, NSInteger), NSNumber * _Nullable firstScene, ...);
@end

@protocol YJEventBuildAbility <NSObject>
@property (nonatomic, readonly) void(^buildEvent)(void(^)(id<YJEventBuilderProtocol> builder));
@optional
@property (nonatomic, readonly) void(^eventTrigger)(NSInteger componentType, NSInteger scene);
@end

@protocol YJEventBuildPoint <NSObject>
@optional
- (void)eventWillBeganAtComponent:(__kindof UIView *)component;
- (void)eventDidEndAtComponent:(__kindof UIView *)component;
@end

@YJNamespaceInstanceDeclaration(UIView, YJEventBuildPoint, yj_eventBuild, YJEventBuildAbility)
@end
NS_ASSUME_NONNULL_END
