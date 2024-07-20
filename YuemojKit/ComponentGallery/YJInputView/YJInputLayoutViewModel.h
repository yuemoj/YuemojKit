//
//  YJInputLayoutViewModel.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/6/28.
//

#import <Foundation/Foundation.h>
//#import "YJComponentDataSource.h"
#import "YJLayoutDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJInputLayoutViewModel : NSObject</*YJComponentDataSource, */YJLayoutDataSource>
@property (nonatomic) UIEdgeInsets padding;

@property (nonatomic) BOOL shouldDisplayRightView;
@property (nonatomic) CGFloat leftMarginForRightView;
@end

NS_ASSUME_NONNULL_END
