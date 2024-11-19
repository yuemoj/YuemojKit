//
//  YJLayoutProcessor.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/7/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>

NS_ASSUME_NONNULL_BEGIN
@protocol YJLayoutProviderDataSource;
@interface YJLayoutProcessor : NSObject
+ (void)layoutComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider;
+ (void)layoutComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider inSection:(NSInteger)section;
+ (void)layoutComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider indexPath:(NSIndexPath *)indexPath;

+ (void)layoutAndUpdateComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider;
+ (void)layoutAndUpdateComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider inSection:(NSInteger)section;
+ (void)layoutAndUpdateComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
