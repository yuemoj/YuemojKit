//
//  YJDataFiller.h
//  YuemojKit
//
//  Created by Yuemoj on 2021/12/13.
//  Copyright © 2021 hytera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJDataFillerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YJDataFillDelegate;
/// @abstract
/// view内部持有对象, 通过调用方构建block, 将view需要显示的内容传入
@interface YJDataFiller : NSObject<YJDataFillerProtocol>
+ (instancetype)fillerWithDelegate:(id<YJDataFillDelegate>)component;
- (instancetype)initWithDelegate:(id<YJDataFillDelegate>)component NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)didFill;
@end

NS_ASSUME_NONNULL_END

