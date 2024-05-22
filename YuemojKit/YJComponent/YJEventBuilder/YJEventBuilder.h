//
//  CommonComponentTouchMaker.h
//  YuemojKit
//
//  Created by Yuemoj on 2022/1/6.
//  Copyright © 2022 hytera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJEventBuilderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YJEventBuildDelegate;
@interface YJEventBuilder : NSObject<YJEventBuilderProtocol>
+ (instancetype)eventBuilderWithDelegate:(id<YJEventBuildDelegate>)delegate;
- (instancetype)initWithDelegate:(id<YJEventBuildDelegate>)delegate NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)didBuild;
@end

NS_ASSUME_NONNULL_END

