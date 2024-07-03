//
//  YJComponentModels.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/1/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/NSLayoutConstraint.h>
#import <UIKit/UIView.h>
#import "YuemojCoreTypes.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(int, YJLayoutAttribute) {
    YJLayoutAttributeSame = -1,
    YJLayoutAttributeTop,
    YJLayoutAttributeBottom,
    YJLayoutAttributeLeading,
    YJLayoutAttributeTrailing,
    YJLayoutAttributeCenterX,
    YJLayoutAttributeCenterY,
    YJLayoutAttributeCenter,
    YJLayoutAttributeEdgeInset,
    YJLayoutAttributeWidth,
    YJLayoutAttributeHeight
};

typedef NS_ENUM(int, YJLayoutRelation) {
    YJLayoutRelationLessThanOrEqualTo = -1,
    YJLayoutRelationEqualTo,
    YJLayoutRelationGreaterThanOrEqualTo,
//    YJComponentRelationMultiBy,
    YJLayoutRelationInsets
};

@protocol YJLayoutConstraintAttributeDelegate;
@interface YJLayoutAnchor<OwnerType> : NSObject
@property (nonatomic, weak) OwnerType owner;
@property (nonatomic) YJLayoutAttribute layoutAttribute;

+ (instancetype)anchorWithAttribute:(YJLayoutAttribute)attribute owner:(OwnerType)owner;
- (instancetype)initWithAttribute:(YJLayoutAttribute)attribute owner:(OwnerType)owner NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@end

@class YJLayoutItemConstraintDescription;
@protocol YJLayoutConstraintAttributeDelegate;
@interface YJLayoutItem : NSObject
@property (nonatomic, readonly) NSInteger itemIdentifier;
@property (nonatomic, readonly) __kindof UIView *view;
@property (nonatomic) YJLayoutAnchor<YJLayoutItem *> *top;
@property (nonatomic) YJLayoutAnchor<YJLayoutItem *> *leading;
@property (nonatomic) YJLayoutAnchor<YJLayoutItem *> *bottom;
@property (nonatomic) YJLayoutAnchor<YJLayoutItem *> *trailing;
@property (nonatomic) YJLayoutAnchor<YJLayoutItem *> *centerX;
@property (nonatomic) YJLayoutAnchor<YJLayoutItem *> *centerY;
@property (nonatomic) YJLayoutAnchor<YJLayoutItem *> *center;
@property (nonatomic) YJLayoutAnchor<YJLayoutItem *> *width;
@property (nonatomic) YJLayoutAnchor<YJLayoutItem *> *height;
/// 默认非custom
- (void)bindView:(__kindof UIView *)view;
- (void)bindView:(__kindof UIView *)view withType:(YJComponentType)type; // 只有一个控件, 不设置scene时, 使用默认的scene
- (void)bindView:(__kindof UIView *)view withType:(YJComponentType)type scene:(NSInteger)scene;
- (void)bindView:(__kindof UIView *)view withType:(YJComponentType)type scene:(NSInteger)scene custom:(BOOL)isCustom;
/// 结合类型获取实际identifier
//- (NSInteger)itemIdentifier;

- (nullable YJLayoutItemConstraintDescription *)makeItemDescription:(void(NS_NOESCAPE^)(id<YJLayoutConstraintAttributeDelegate> maker))make;
- (nullable YJLayoutItemConstraintDescription *)updateItemDescription:(void(NS_NOESCAPE^)(id<YJLayoutConstraintAttributeDelegate> maker))make;
@end

@interface YJLayoutItemConstraint : NSObject
@property (nonatomic) YJLayoutAttribute firstItemAttribute;
@property (nonatomic) YJLayoutAttribute secondItemAttribute;
@property (nonatomic) YJLayoutRelation relation;
@property (nonatomic) CGFloat multiplier;
@property (nonatomic) CGFloat constant;
@property (nonatomic) UIEdgeInsets edgeInsets; // YJComponentAnchorEdgeInset类型时设置, 默认为UIEdgeInsetZero
@property (nonatomic) UILayoutPriority priority;
@end

@interface YJLayoutRelatedItem : NSObject
/// 有些时候可以设置实际值, 就不需要secondItem, 如width, height , size等
@property (nonatomic, nullable) YJLayoutItem *secondItem;
@property (nonatomic) YJLayoutItemConstraint *constraint;
@property (nonatomic) BOOL hasRelated;
@end

/// TODO: 有空的时候仿Masonry的方式来生成该对象
@interface YJLayoutItemConstraintDescription : NSObject
@property (nonatomic) YJLayoutItem *firstItem;
@property (nonatomic) NSArray<YJLayoutRelatedItem *> *relatedItems;
/// 容器
@property (nonatomic, nullable) YJLayoutItem *containerItem;
@property (nonatomic, nullable) YJLayoutItem *belowItem;    // insertSubview:below:
@property (nonatomic, nullable) YJLayoutItem *aboveItem;    // insertSubview:above:
@end

#pragma mark- Protocols
@protocol YJLayoutAnchorProtocol <NSObject>
- (id<YJLayoutAnchorProtocol>(^)(id))equalTo;
- (id<YJLayoutAnchorProtocol>(^)(id))greaterThanOrEqualTo;
- (id<YJLayoutAnchorProtocol>(^)(id))lessThanOrEqualTo;
- (id<YJLayoutAnchorProtocol>(^)(CGFloat))multipliedBy;
- (id<YJLayoutAnchorProtocol>(^)(UIEdgeInsets))insets;
- (id<YJLayoutAnchorProtocol>(^)(CGFloat))yj_offset;
- (id<YJLayoutAnchorProtocol>(^)(UILayoutPriority))priority;
@end

@protocol YJLayoutConstraintAttributeDelegate <NSObject>
@optional
@property (nonatomic, readonly) id<YJLayoutAnchorProtocol, YJLayoutConstraintAttributeDelegate> top;
@property (nonatomic, readonly) id<YJLayoutAnchorProtocol, YJLayoutConstraintAttributeDelegate> bottom;
@property (nonatomic, readonly) id<YJLayoutAnchorProtocol, YJLayoutConstraintAttributeDelegate> leading;
@property (nonatomic, readonly) id<YJLayoutAnchorProtocol, YJLayoutConstraintAttributeDelegate> trailing;
@property (nonatomic, readonly) id<YJLayoutAnchorProtocol, YJLayoutConstraintAttributeDelegate> centerX;
@property (nonatomic, readonly) id<YJLayoutAnchorProtocol, YJLayoutConstraintAttributeDelegate> centerY;
@property (nonatomic, readonly) id<YJLayoutAnchorProtocol, YJLayoutConstraintAttributeDelegate> center;
@property (nonatomic, readonly) id<YJLayoutAnchorProtocol, YJLayoutConstraintAttributeDelegate> width;
@property (nonatomic, readonly) id<YJLayoutAnchorProtocol, YJLayoutConstraintAttributeDelegate> height;
@property (nonatomic, readonly) id<YJLayoutAnchorProtocol> edges;
@end

NS_ASSUME_NONNULL_END
