//
//  YJLayouter.h
//  YuemojKit
//
//  Created by Yuemoj on 2023/5/8.
//

#import <Foundation/Foundation.h>
#import "YJLayouterProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@protocol YJLayoutDelegate, YJLayoutUpdateDelegate;
@interface YJLayouter : NSObject<YJLayouterProtocol>
+ (instancetype)layouterWithDelegate:(id<YJLayoutDelegate, YJLayoutUpdateDelegate>)delegate;
- (instancetype)initWithDelegate:(id<YJLayoutDelegate, YJLayoutUpdateDelegate>)delegate NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (void)didLayout;
@end

NS_ASSUME_NONNULL_END
