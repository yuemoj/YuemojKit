//
//  YJLayoutProviderDataSource.h
//  NetworkSalesController
//
//  Created by Yuemoj on 2024/7/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol YJComponentDataSource, YJLayoutDataSource, YJLayoutUpdateDataSource;
@protocol YJLayoutProviderDataSource <NSObject>
@optional
@property (nonatomic, readonly) id<YJLayoutDataSource> yj_layoutDataSource;
@property (nonatomic, readonly) id<YJLayoutDataSource> yj_layoutDataSourceInSection;
@property (nonatomic, readonly) id<YJLayoutDataSource> yj_layoutDataSourceAtIndexPath;
@property (nonatomic, readonly) id<YJComponentDataSource, YJLayoutUpdateDataSource> yj_layoutUpdateDataSource;

- (__kindof UIView *)yj_componentForScene:(NSInteger)scene;
- (__kindof UIView *)yj_componentForScene:(NSInteger)scene inSection:(NSInteger)section;
- (__kindof UIView *)yj_componentForScene:(NSInteger)scene indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
