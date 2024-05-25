//
//  YJLayoutNamespace.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/4/28.
//

#import <UIKit/UIView.h>
#import "YJLayoutNamespace.h"
#import "YJLayoutDelegate.h"
#import "YJLayouter.h"
#import "Masonry.h"

@interface YJLayoutNamespace ()<YJLayoutAbility>
@property (nonatomic) YJLayouter *layouter;
@property (nonatomic) NSMutableDictionary<NSNumber *, __kindof UIView *> *componentLayouts;
@end

@implementation YJLayoutNamespace
- (void (^)(__attribute__((noescape)) void (^ _Nonnull)(id<YJLayouterProtocol> _Nonnull)))layoutComponent {
    return ^(void(^layout)(id<YJLayouterProtocol>)) {
        if (layout) layout(self.layouter);
        [self.layouter didLayout];
    };
}

- (YJLayouter *)layouter {
    if (!_layouter) _layouter = [YJLayouter layouterWithDelegate:(id<YJLayoutDelegate, YJLayoutOffsetDelegate>)self];
    return _layouter;
}

- (NSMutableDictionary<NSNumber *,__kindof UIView *> *)componentLayouts {
    if (!_componentLayouts) _componentLayouts = [NSMutableDictionary dictionaryWithCapacity:0];
    return _componentLayouts;
}

@end

#import "UIKit+Yuemoj.h"
#import "YJLayoutModels.h"
@interface YJLayoutNamespace (LayoutDelegate)<YJLayoutDelegate, YJLayoutOffsetDelegate>
@end
@implementation YJLayoutNamespace(LayoutDelegate)
- (void)layoutWithItemDescriptions:(NSArray<YJLayoutItemConstraintDescription *> *)descriptions {
    for (YJLayoutItemConstraintDescription *tmpDescription in descriptions) {
        __kindof UIView *component = tmpDescription.firstItem.view;
        [self record:component usingItem:tmpDescription.firstItem];
        // TODO: container和secondItem不用上层指定顺序, 自动递归处理, 以后再实现吧
        __kindof UIView *containerView = tmpDescription.containerItem.view ?: self.owner;//.contentView;
        [containerView addSubview:component];
        for (YJLayoutRelatedItem *tmpItemConstraint in tmpDescription.relatedItems) {
            [component mas_makeConstraints:^(MASConstraintMaker *make) {
                MASConstraint *constraint = [self getFirstItemConstraintFromMaker:make itemConstraint:tmpItemConstraint];
                NSAssert(constraint, @"fatal: invalid constraint!");
                MASConstraint * (^relation)(id) = [self getItemRelationForConstraint:constraint itemConstraint:tmpItemConstraint];
                if (!relation) return; // relation为空表示已经设置了简单类型的值, 不需要再关联下面的约束了.
                                
                [self relationSecondItemView:tmpItemConstraint.secondItem.view constraint:tmpItemConstraint using:relation];
                // 有secondItem时, constant默认为0 就不需要额外offset了
                if (fabs(tmpItemConstraint.constraint.constant) > FLT_EPSILON) {
                    constraint.offset(tmpItemConstraint.constraint.constant);
                }
                if (tmpItemConstraint.constraint.multiplier > 0.f) {
                    constraint.multipliedBy(tmpItemConstraint.constraint.multiplier);
                }
                if (tmpItemConstraint.constraint.priority > 0.f) {
                    constraint.priority(tmpItemConstraint.constraint.priority);
                }
            }];
        }
    }
    __weak typeof(self) weakself = self;
    ((UIView *)self.owner).yj_extra.viewForIdentifier = ^__kindof UIView * _Nonnull(YJComponentType type, NSInteger scene) {
        return weakself.componentLayouts[@(yj_componentIdentifier(type, scene))];
    };
}

- (void)record:(__kindof UIView *)component usingItem:(YJLayoutItem *)item {
    // TODO: 需不需要检测和提醒已存在的情况?
//    component.yj_extra.jTag = item.itemIdentifier;
    self.componentLayouts[@(item.view.yj_extra.jTag)] = component;
}

- (MASConstraint *)getFirstItemConstraintFromMaker:(MASConstraintMaker *)make itemConstraint:(YJLayoutRelatedItem *)itemConstraint {
    switch (itemConstraint.constraint.firstItemAttribute) {
        case YJLayoutAttributeTop:          return make.top;
        case YJLayoutAttributeLeading:      return make.leading;
        case YJLayoutAttributeBottom:       return make.bottom;
        case YJLayoutAttributeTrailing:     return make.trailing;
        case YJLayoutAttributeCenterX:      return make.centerX;
        case YJLayoutAttributeCenterY:      return make.centerY;
        case YJLayoutAttributeCenter:       return make.center;
        case YJLayoutAttributeEdgeInset:    return make.edges;
        case YJLayoutAttributeWidth:        return make.width;
        case YJLayoutAttributeHeight:       return make.height;
        default: break;
    }
    return nil;
}

- (MASConstraint * (^)(id))getItemRelationForConstraint:(MASConstraint *)constraint itemConstraint:(YJLayoutRelatedItem *)itemConstraint {
    do {
        if (!itemConstraint.secondItem) {
            // 设置实际值时不需要secondItem, secondItem为父容器时可忽略不写.
            if (itemConstraint.constraint.relation == YJLayoutRelationInsets) {
                constraint.insets(itemConstraint.constraint.edgeInsets);
            } else {
                constraint.offset(itemConstraint.constraint.constant);
            }
            break;
        }
        switch (itemConstraint.constraint.relation) {
            case YJLayoutRelationLessThanOrEqualTo:      return constraint.lessThanOrEqualTo;
            case YJLayoutRelationEqualTo:                return constraint.equalTo;
            case YJLayoutRelationGreaterThanOrEqualTo:   return constraint.greaterThanOrEqualTo;
            default: break;
        }
    } while (0);
    return nil;
}

- (void)relationSecondItemView:(__kindof UIView *)secondItemView constraint:(YJLayoutRelatedItem *)itemConstraint using:(MASConstraint * (^)(id))relation {
    switch (itemConstraint.constraint.secondItemAttribute) {
        case YJLayoutAttributeSame:         relation(secondItemView);              break;
        case YJLayoutAttributeTop:          relation(secondItemView.mas_top);      break;
        case YJLayoutAttributeLeading:      relation(secondItemView.mas_leading);  break;
        case YJLayoutAttributeBottom:       relation(secondItemView.mas_bottom);   break;
        case YJLayoutAttributeTrailing:     relation(secondItemView.mas_trailing); break;
        case YJLayoutAttributeCenterX:      relation(secondItemView.mas_centerX);  break;
        case YJLayoutAttributeCenterY:      relation(secondItemView.mas_centerY);  break;
        case YJLayoutAttributeCenter:       relation(secondItemView);              break;
//        case YJLayoutAttributeEdgeInset:    break;
        case YJLayoutAttributeWidth:        relation(secondItemView.mas_width);    break;
        case YJLayoutAttributeHeight:       relation(secondItemView.mas_height);   break;
        default: break;
    }
}

- (void)layoutComponent:(YJComponentType)type forScene:(NSInteger)scene withOffset:(UIOffset)offset {
    if (!((UIView *)self.owner).yj_extra.viewForIdentifier) return;
    __kindof UIView *component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    [component mas_updateConstraints:^(MASConstraintMaker *make) {
        if (offset.horizontal != NSNotFound) make.centerX.offset(offset.horizontal);
        if (offset.vertical != NSNotFound) make.centerY.offset(offset.vertical);
    }];
}
@end

@YJNamespaceInstanceImplementation(UIView, YJLayoutNamespace, yj_layout, YJLayoutAbility)

@end
