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
        if (tmpDescription.aboveItem) [containerView insertSubview:component aboveSubview:tmpDescription.aboveItem.view];
        else if (tmpDescription.belowItem) [containerView insertSubview:component belowSubview:tmpDescription.belowItem.view];
        else [containerView addSubview:component];
        for (YJLayoutRelatedItem *tmpItemConstraint in tmpDescription.relatedItems) {
            [component mas_makeConstraints:^(MASConstraintMaker *make) {
                MASConstraint *constraint = [self getFirstItemConstraintFromMaker:make itemConstraint:tmpItemConstraint];
                NSAssert(constraint, @"fatal: invalid constraint!");
                MASConstraint * (^relation)(id) = [self getItemRelationForConstraint:constraint itemConstraint:tmpItemConstraint];
                do {
                    if (!relation) break;
                    [self relationSecondItemView:tmpItemConstraint.secondItem.view constraint:tmpItemConstraint using:relation];
                    // maker.edge.equalTo(item).insets(edge) 场景的最终处理
                    if (tmpItemConstraint.constraint.relation == YJLayoutRelationInsets)
                        constraint.insets(tmpItemConstraint.constraint.edgeInsets);
                    // 有secondItem时, constant默认为0 就不需要额外offset了
                    if (fabs(tmpItemConstraint.constraint.constant) > FLT_EPSILON) constraint.offset(tmpItemConstraint.constraint.constant);
                    if (tmpItemConstraint.constraint.multiplier > 0.f) constraint.multipliedBy(tmpItemConstraint.constraint.multiplier);
                } while (0);
                if (tmpItemConstraint.constraint.priority > 0.f) constraint.priority(tmpItemConstraint.constraint.priority);
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

/// eg: maker.👉🏻leading👈🏻.equalTo(xx.leading)
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

/// eg: 1. maker.edge.👉🏻inset(edge)👈🏻 or maker.yj_offset.👉🏻(10.f)👈🏻 类似场景 secondItem == nil;
/// 2. maker.leading.👉🏻equalTo👈🏻(item.leading)
/// 有一个特殊情况, 在设置edge的时候, 如果是和同级View做约束: maker.edge.equalTo(item).insets(edge), relation会在构建的时候被设为为insets, 这里的关系需要处理成返回equalTo, 在最后处理实际的edgeInsets
- (MASConstraint * (^)(id))getItemRelationForConstraint:(MASConstraint *)constraint itemConstraint:(YJLayoutRelatedItem *)itemConstraint {
    do {
        if (!itemConstraint.secondItem) {
            if (itemConstraint.constraint.relation == YJLayoutRelationInsets) {
                constraint.insets(itemConstraint.constraint.edgeInsets);
            } else {
                // 设置实际值时不需要secondItem, secondItem为父容器时可忽略不写.
                constraint.offset(itemConstraint.constraint.constant);
            }
            break;
        }
        switch (itemConstraint.constraint.relation) {
            case YJLayoutRelationLessThanOrEqualTo:      return constraint.lessThanOrEqualTo;
            case YJLayoutRelationEqualTo:                return constraint.equalTo;
            case YJLayoutRelationGreaterThanOrEqualTo:   return constraint.greaterThanOrEqualTo;
            case YJLayoutRelationInsets:                 return constraint.equalTo;
            default: break;
        }
    } while (0);
    return nil;
}

/// eg: maker.leading.equalTo(👉🏻item👈🏻)  or  maker.leading.equalTo(👉🏻item.leading👈🏻)
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
        case YJLayoutAttributeWidth:        relation(secondItemView.mas_width);    break;
        case YJLayoutAttributeHeight:       relation(secondItemView.mas_height);   break;
        default: break;
    }
}

#pragma mark - layout offset
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
