//
//  YJComponentWrapper.h
//  YuemojKit
//
//  Created by Yuemoj on 2023/9/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJComponentWrapper : NSObject
+ (void)componentDidLoaded:(BOOL)isLoaded forScene:(NSNumber *)scene args:(va_list)args shouldUpdate:(BOOL(NS_NOESCAPE ^ _Nullable)(int))update action:(void (^)(int nextScene))action;
+ (void)componentDidLoaded:(BOOL)isLoaded forScene:(int)scene shouldUpdate:(BOOL(NS_NOESCAPE ^_Nullable)(int))update action:(void (^)(int nextScene))action;
@end

NS_ASSUME_NONNULL_END
