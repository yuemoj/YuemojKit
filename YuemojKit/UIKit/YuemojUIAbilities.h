//
//  YuemojUIAbilities.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/15.
//

#import <Foundation/Foundation.h>

#import "YuemojCoreTypes.h"
@class UIView, UIGestureRecognizer;
NS_ASSUME_NONNULL_BEGIN

@protocol YuemojActionAbility <NSObject>
@optional
/// TODO: 多事件支持??
@property (nonatomic, copy) BOOL (^extendAction)(__kindof UIView * _Nonnull sender, NSInteger scene);
@end

@protocol YuemojFrameAbility <NSObject>
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint orign;

@property (nonatomic, readonly) CGFloat left;
@property (nonatomic, readonly) CGFloat right;
@property (nonatomic, readonly) CGFloat top;
@property (nonatomic, readonly) CGFloat bottom;
@end

@protocol YuemojExtraAbility <NSObject>
@optional
@property (nonatomic, readonly) NSInteger jTag;
@property (nonatomic, readonly) void(^setJTag)(YJComponentType type, NSInteger scene);
@property (nonatomic, copy) __kindof UIView *(^viewForIdentifier)(YJComponentType type, NSInteger scene);
@end

typedef NS_ENUM(int, YJButtonArrangeStyle) {
    YJButtonArrangeStyleTopImageBottomTitle,
};
@protocol YuemojRearrangeAbility <NSObject>
@property (nonatomic, readonly, copy) void(^rearrange)(YJButtonArrangeStyle);
@end

@protocol YuemojHyperlinkAbility <NSObject>
@optional
@property (nonatomic, readonly, copy) void(^hyperlink)(void(^)(UIGestureRecognizer *, NSInteger indexOfCharacter));
@end
NS_ASSUME_NONNULL_END
