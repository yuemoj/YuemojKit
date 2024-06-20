//
//  YJMaskTopLayoutViewModel.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/6/17.
//

#import <Foundation/Foundation.h>
#import "YJMaskViewScenes.h"
#import "YJComponentDataSource.h"
#import "YJLayoutDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJMaskTopLayoutViewModel : NSObject<YJComponentDataSource, YJLayoutDataSource>
@property (nonatomic) CGFloat centerYOffset;
@property (nonatomic) CGFloat leading;
@property (nonatomic) CGFloat trailing;
@end

NS_ASSUME_NONNULL_END
