//
//  YJEventBuilderProtocol.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YJComponentDataSource;
@protocol YJEventBuilderProtocol <NSObject>
@optional
/// 具体的手势不定 由调用方直接生成
//- (id<YJEventBuilderProtocol>(^)(id<YJComponentDataSource> dataSource, __kindof UIGestureRecognizer *(^maker)(id, SEL), BOOL(^handler)(id owner, __kindof UIView *, NSInteger), NSNumber * _Nullable scene, ...))addActionForGestureRecognizer;
@property (nonatomic, copy, readonly) id<YJEventBuilderProtocol>(^addActionForGestureRecognizer)(id<YJComponentDataSource> dataSource, __kindof UIGestureRecognizer *(^maker)(id, SEL), BOOL(^handler)(id owner, __kindof UIView *, NSInteger), NSNumber * _Nullable scene, ...);
@property (nonatomic, copy, readonly) id<YJEventBuilderProtocol>(^addActionForControlEvents)(id<YJComponentDataSource> dataSource, UIControlEvents, BOOL(^)(id owner, __kindof UIControl*, NSInteger), NSNumber * _Nullable scene, ...);
//- (id<YJEventBuilderProtocol>(^)(id<YJComponentDataSource> dataSource, UIControlEvents, BOOL(^)(id owner, __kindof UIControl*, NSInteger), NSNumber * _Nullable scene, ...))addActionForControlEvents;
@end

@protocol YJEventBuildAbility <NSObject>
@property (nonatomic, readonly) void(^buildEvent)(void(^)(id<YJEventBuilderProtocol> builder));

@end
NS_ASSUME_NONNULL_END
