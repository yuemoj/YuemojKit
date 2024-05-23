//
//  YJComponentDataSource.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/2/22.
//

#import <Foundation/Foundation.h>
#import "YuemojCoreTypes.h"

NS_ASSUME_NONNULL_BEGIN

/// @abstract 通常由viewmodel遵循这些协议, 在filler的block中指定viewmodel和场景来为view传参
@protocol YJComponentDataSource <NSObject>
@optional
- (YJComponentType)componentTypeForScene:(NSInteger)scene;
- (YJComponentType)componentTypeForScene:(NSInteger)scene inSection:(NSInteger)section;
- (YJComponentType)componentTypeForScene:(NSInteger)scene indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
