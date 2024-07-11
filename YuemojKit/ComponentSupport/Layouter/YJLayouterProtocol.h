//
//  YJLayouterProtocol.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/4/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>
#import "YuemojMacros.h"
NS_ASSUME_NONNULL_BEGIN
@class YJLayoutItem;
@protocol YJLayoutDataSource, YJComponentDataSource;
@protocol YJLayouterProtocol <NSObject>
@optional
@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layout)(id<YJLayoutDataSource> dataSource, __kindof UIView *(NS_NOESCAPE^)(NSInteger scene));
@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutInSection)(id<YJLayoutDataSource> dataSource, NSInteger section, __kindof UIView *(NS_NOESCAPE^)(NSInteger scene));
@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutAtIndexPath)(id<YJLayoutDataSource> dataSource, NSIndexPath *indexPath, __kindof UIView *(NS_NOESCAPE^)(NSInteger scene));

@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutUpdate)(id<YJLayoutDataSource, YJComponentDataSource> dataSource);
@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutUpdateInSection)(id<YJLayoutDataSource, YJComponentDataSource> dataSource, NSInteger section);
@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutUpdateAtIndexPath)(id<YJLayoutDataSource, YJComponentDataSource> dataSource, NSIndexPath *indexPath);


//@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutOffset)(id<YJLayoutOffsetDataSource, YJComponentDataSource> dataSource, NSNumber * _Nullable firstScene, ...);
//@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutOffsetInSection)(id<YJLayoutOffsetDataSource, YJComponentDataSource> dataSource, NSInteger section, NSNumber * _Nullable firstScene, ...);
//@property (nonatomic, readonly, copy) id<YJLayouterProtocol>(^layoutOffsetAtIndexPath)(id<YJLayoutOffsetDataSource, YJComponentDataSource> dataSource, NSIndexPath *indexPath, NSNumber * _Nullable firstScene, ...);
@end

@protocol YJLayoutAbility <NSObject>
@property (nonatomic, copy, readonly) void(^layoutComponent)(void(NS_NOESCAPE^)(id<YJLayouterProtocol> layouter));
@end

@YJNamespaceInstanceDeclaration(UIView, NSObject, yj_layout, YJLayoutAbility)
@end

NS_ASSUME_NONNULL_END
