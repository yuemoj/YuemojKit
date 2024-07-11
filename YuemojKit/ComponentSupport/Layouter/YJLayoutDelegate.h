//
//  YJLayoutDelegate.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/4/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGeometry.h>
#import "YuemojCoreTypes.h"

NS_ASSUME_NONNULL_BEGIN
@class YJLayoutItem, YJLayoutItemConstraintDescription;
@protocol YJLayoutDelegate <NSObject>
@optional
- (void)layoutWithItemDescriptions:(NSArray<YJLayoutItemConstraintDescription *> *)descriptions;
//@end
//
//@class YJLayoutItem;
//@protocol YJLayoutUpdateDelegate <NSObject>
//@optional
- (YJLayoutItem *)layoutItemForIdentifier:(NSInteger)identifier;
- (void)layoutUpdateWithItemDescriptions:(NSArray<YJLayoutItemConstraintDescription *> *)descriptions;
@end

NS_ASSUME_NONNULL_END
