//
//  YJMultiSelectMaskView.h
//  NetworkSalesController
//
//  Created by HYT200841559 on 2023/4/25.
//

#import <UIKit/UIKit.h>
#import "YJMaskViewScenes.h"

NS_ASSUME_NONNULL_BEGIN
/// 操作按钮默认红色, 其他色在colorForState:scene:中配置
@interface YJTopBottomMaskViewManager : NSObject
@property (nonatomic) UIView *topMaskView;
@property (nonatomic) UIView *bottomMaskView;
@property (nonatomic) CGFloat topMaskHeight;
@property (nonatomic) CGFloat bottomMaskHeight;
@property (nonatomic, readonly, getter=isDisplayed) BOOL displayed;
- (void)showOnViewController:(__kindof UIViewController *)viewController;
- (void)removeFromMaskingViewController;
@end

NS_ASSUME_NONNULL_END
