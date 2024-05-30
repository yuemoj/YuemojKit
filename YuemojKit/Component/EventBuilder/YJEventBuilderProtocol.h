//
//  YJEventBuilderProtocol.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YuemojMacros.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YJComponentDataSource;
@protocol YJEventBuilderProtocol <NSObject>
@optional
@property (nonatomic, copy, readonly) id<YJEventBuilderProtocol>(^addActionForGestureRecognizer)(id<YJComponentDataSource> dataSource, __kindof UIGestureRecognizer *(^maker)(id, SEL), BOOL(^handler)(id owner, __kindof UIView *, NSInteger), NSNumber * _Nullable firstScene, ...);
@property (nonatomic, copy, readonly) id<YJEventBuilderProtocol>(^addActionForControlEvents)(id<YJComponentDataSource> dataSource, UIControlEvents, BOOL(^)(id owner, __kindof UIControl*, NSInteger), NSNumber * _Nullable firstScene, ...);
@end

@protocol YJEventBuildAbility <NSObject>
@property (nonatomic, readonly) void(^buildEvent)(void(^)(id<YJEventBuilderProtocol> builder));

@end

@YJNamespaceInstanceDeclaration(UIView, NSObject, yj_eventBuild, YJEventBuildAbility)
@end
NS_ASSUME_NONNULL_END
