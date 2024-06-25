//
//  YJActionSheetLayoutViewModel.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/6/21.
//

#import <Foundation/Foundation.h>
#import "YJComponentDataSource.h"
#import "YJLayoutDataSource.h"
#import "YJActionViewScenes.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJActionSheetLayoutViewModel : NSObject<YJComponentDataSource, YJLayoutDataSource>
@property (nonatomic) UIEdgeInsets padding;
@property (nonatomic) NSInteger actionCount;
@property (nonatomic) CGFloat actionTopMargin;
@property (nonatomic) CGFloat actionHeight;
@property (nonatomic) CGFloat splitHeight;
@end

NS_ASSUME_NONNULL_END
