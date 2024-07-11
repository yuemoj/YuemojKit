//
//  YJLayoutDataSource.h
//  YuemojKit
//
//  Created by Yuemoj on 2023/5/8.
//

#import <Foundation/Foundation.h>
#import "YJLayoutModels.h"
NS_ASSUME_NONNULL_BEGIN

@protocol YJLayoutDataSource <NSObject>
@optional
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutDescriptionsWithProvider:(__kindof UIView *(NS_NOESCAPE^)(NSInteger scene))provider;
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutDescriptionsInSection:(NSInteger)section provider:(__kindof UIView *(NS_NOESCAPE^)(NSInteger scene))provider;
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutDescriptionsAtIndexPath:(NSIndexPath *)indexPath provider:(__kindof UIView *(NS_NOESCAPE^)(NSInteger scene))provider;
@end

@protocol YJLayoutUpdateDataSource <NSObject>
@optional
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutUpdateDescriptionsWithFetcher:(YJLayoutItem *(NS_NOESCAPE^)(NSInteger scene))itemFetcher;
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutUpdateDescriptionsInSection:(NSInteger)section fetcher:(YJLayoutItem *(NS_NOESCAPE^)(NSInteger scene))fetcher;
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutUpdateDescriptionsAtIndexPath:(NSIndexPath *)indexPath fetcher:(YJLayoutItem *(NS_NOESCAPE^)(NSInteger scene))fetcher;
@end

//@protocol YJLayoutOffsetDataSource <NSObject>
//@optional
//- (UIOffset)offsetForScene:(NSInteger)scene;
//- (UIOffset)offsetForScene:(NSInteger)scene inSection:(NSInteger)section;
//- (UIOffset)offsetForScene:(NSInteger)scene indexPath:(NSIndexPath *)indexPath;
//@end

//@protocol YJLayoutShouldUpdateDataSource <NSObject>
//@optional
//- (BOOL)shouldUpdateOffsetForScene:(NSInteger)scene;  // 如不实现, 默认YES
//@end

NS_ASSUME_NONNULL_END
