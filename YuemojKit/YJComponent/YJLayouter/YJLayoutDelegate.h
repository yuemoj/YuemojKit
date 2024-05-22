//
//  YJLayoutDelegate.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/4/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGeometry.h>
#import "YJComponentEnum.h"

NS_ASSUME_NONNULL_BEGIN
@class YJLayoutItemConstraintDescription;
@protocol YJLayoutDelegate <NSObject>
@optional
- (void)layoutWithItemDescriptions:(NSArray<YJLayoutItemConstraintDescription *> *)descriptions;
@end

@protocol YJLayoutOffsetDelegate
@optional
- (void)layoutComponent:(YJComponentType)type forScene:(NSInteger)scene withOffset:(UIOffset)offset;
@end

NS_ASSUME_NONNULL_END
