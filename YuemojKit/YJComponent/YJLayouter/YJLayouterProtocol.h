//
//  YJLayouterProtocol.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/4/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class UIView;
@protocol YJLayoutDataSource, YJLayoutOffsetDataSource, YJComponentDataSource;
@protocol YJLayouterProtocol <NSObject>
@optional
@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layout)(id<YJLayoutDataSource> dataSource, __kindof UIView *(NS_NOESCAPE^)(NSInteger scene));
@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutInSection)(id<YJLayoutDataSource> dataSource, NSInteger section, __kindof UIView *(NS_NOESCAPE^)(NSInteger scene));
@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutAtIndexPath)(id<YJLayoutDataSource> dataSource, NSIndexPath *indexPath, __kindof UIView *(NS_NOESCAPE^)(NSInteger scene));


@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutOffset)(id<YJLayoutOffsetDataSource, YJComponentDataSource> dataSource, NSNumber * _Nullable scene, ...);
@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutOffsetInSection)(id<YJLayoutOffsetDataSource, YJComponentDataSource> dataSource, NSInteger section, NSNumber * _Nullable scene, ...);
@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutOffsetAtIndexPath)(id<YJLayoutOffsetDataSource, YJComponentDataSource> dataSource, NSIndexPath *indexPath, NSNumber * _Nullable scene, ...);
@end

@protocol YJLayoutAbility <NSObject>
//@property (nonatomic, readonly, getter=isLayouterLoaded) BOOL layouterLoaded; // 记录是否已经加载过, 一般在fillComponent后设为YES
@property (nonatomic, copy, readonly) void(^layoutComponent)(void(NS_NOESCAPE^)(id<YJLayouterProtocol> layouter));
@end
NS_ASSUME_NONNULL_END
