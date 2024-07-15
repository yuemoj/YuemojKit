//
//  YJTabLayoutViewModel.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/31.
//

#import <Foundation/Foundation.h>
#import "YJComponentDataSource.h"
#import "YJLayoutDataSource.h"
//#import "YJDataFillDataSource.h"

typedef NS_ENUM (int, YJTabViewIndicatorStyle) {
    YJTabViewIndicatorStyleNone,
    YJTabViewIndicatorStyleUnderline,
    YJTabViewIndicatorStyleBackground
};

NS_ASSUME_NONNULL_BEGIN

@interface YJTabLayoutViewModel : NSObject<YJComponentDataSource, YJLayoutDataSource>
@property (nonatomic) NSInteger tabCount;
@property (nonatomic) YJTabViewIndicatorStyle indicatorStyle;
@property (nonatomic) BOOL shouldSplit;
/// YJTabViewIndicatorStyleUnderline
@property (nonatomic) CGFloat indicatorWidth;
/// YJTabViewIndicatorStyleBackground
@property (nonatomic) UIEdgeInsets indicatorInsets;
@end

NS_ASSUME_NONNULL_END
