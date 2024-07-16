//
//  YJLayoutItemProcessor.h
//  NetworkSalesController
//
//  Created by Yuemoj on 2024/7/10.
//

#import <Foundation/Foundation.h>
#import "YJComponentDataSource.h"

NS_ASSUME_NONNULL_BEGIN
@class YJLayoutItem;
@interface YJLayoutItemProcessor : NSObject
+ (YJLayoutItem *)generateItemForScene:(int)scene componentTypeFetcher:(YJComponentType(*)(int))fetcher viewProvider:(__kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger))provider;
+ (YJLayoutItem *)generateItemWithComponentType:(YJComponentType)type viewProvider:(__kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger))provider;
@end

NS_ASSUME_NONNULL_END
