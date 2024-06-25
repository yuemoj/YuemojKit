//
//  YJActionViewController.h
//  YuemojKit
//
//  Created by Yuemoj on 2023/6/12.
//

#import <UIKit/UIKit.h>
//#import "YJActionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJActionViewController : UIViewController
//+ (instancetype)viewControllerWithActionView:(__kindof YJActionView *)actionView;
//- (instancetype)initWithActionView:(__kindof YJActionView *)actionView NS_DESIGNATED_INITIALIZER;
//- (instancetype)init NS_UNAVAILABLE;
//- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
//- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
@property (nonatomic, readonly) UIView *actionView;
- (void)presentOnViewController:(__kindof UIViewController *)presentingViewController;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
