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
#import "YJLayoutModels.h"
#import "Masonry.h"

@interface YJLayoutNamespace ()<YJLayoutAbility>
@property (nonatomic) YJLayouter *layouter;
@property (nonatomic) NSMutableDictionary<NSNumber *, YJLayoutItem *> *layoutItems;
@end

@implementation YJLayoutNamespace
- (void (^)(__attribute__((noescape)) void (^ _Nonnull)(id<YJLayouterProtocol> _Nonnull)))layoutComponent {
    return ^(void(^layout)(id<YJLayouterProtocol>)) {
        if (layout) layout(self.layouter);
        [self.layouter didLayout];
    };
}

- (YJLayouter *)layouter {
    if (!_layouter) _layouter = [YJLayouter layouterWithDelegate:(id<YJLayoutDelegate, YJLayoutUpdateDelegate>)self];
    return _layouter;
}

- (NSMutableDictionary<NSNumber *,__kindof YJLayoutItem *> *)layoutItems {
    if (!_layoutItems) _layoutItems = [NSMutableDictionary dictionaryWithCapacity:0];
    return _layoutItems;
}

@end

#import "UIKit+Yuemoj.h"
@interface YJLayoutNamespace (LayoutDelegate)<YJLayoutDelegate, YJLayoutUpdateDelegate>
@end
@implementation YJLayoutNamespace(LayoutDelegate)
- (id)layoutItemForIdentifier:(NSInteger)identifier {
    return self.layoutItems[@(identifier)];
}

- (void)layoutWithItemDescriptions:(NSArray<YJLayoutItemConstraintDescription *> *)descriptions {
    [self processItemDescriptions:descriptions update:NO];
}

- (void)layoutUpdateWithItemDescriptions:(NSArray<YJLayoutItemConstraintDescription *> *)descriptions {
    [self processItemDescriptions:descriptions update:YES];
}

- (void)processItemDescriptions:(NSArray<YJLayoutItemConstraintDescription *> *)descriptions update:(BOOL)shouldUpdate {
    for (YJLayoutItemConstraintDescription *tmpDescription in descriptions) {
        [self recordItem:tmpDescription.firstItem];
        [self addSubviewForConstraintDescription:tmpDescription];
        for (YJLayoutRelatedItem *tmpRelatedItem in tmpDescription.relatedItems) {
            void(^masConstraintMaker)(MASConstraintMaker *) = ^(MASConstraintMaker *make) {
                MASConstraint *constraint = [self getFirstItemConstraintFromMaker:make relatedItem:tmpRelatedItem];
                NSAssert(constraint, @"fatal: invalid constraint!");
                MASConstraint * (^relation)(id) = [self getItemRelationForConstraint:constraint relatedItem:tmpRelatedItem];
                if (relation) [self relationSecondItem:tmpRelatedItem using:relation];
                // maker.edge.equalTo(item).insets(edge) 场景的最终处理
                if (tmpRelatedItem.constraint.relation == YJLayoutRelationInsets)
                    constraint.insets(tmpRelatedItem.constraint.edgeInsets);
                // 有secondItem时, constant默认为0 就不需要额外offset了
                if (fabs(tmpRelatedItem.constraint.constant) > FLT_EPSILON) constraint.offset(tmpRelatedItem.constraint.constant);
                if (tmpRelatedItem.constraint.multiplier > 0.f) constraint.multipliedBy(tmpRelatedItem.constraint.multiplier);
                if (tmpRelatedItem.constraint.priority > 0.f) constraint.priority(tmpRelatedItem.constraint.priority);
            };
            if (shouldUpdate) [tmpDescription.firstItem.view mas_updateConstraints:masConstraintMaker];
            else [tmpDescription.firstItem.view mas_makeConstraints:masConstraintMaker];
        }
    }
    
    if (!shouldUpdate) [self processComponentFetcher];
}

- (void)processComponentFetcher {
    __weak typeof(self) weakself = self;
    ((UIView *)self.owner).yj_extra.viewForIdentifier = ^__kindof UIView * _Nonnull(YJComponentType type, NSInteger scene) {
        if (type == YJComponentTypeContainer) return weakself.owner;
        return weakself.layoutItems[@(yj_componentIdentifier(type, scene))].view;
    };
}

- (void)recordItem:(YJLayoutItem *)item {
    NSInteger key = item.view.yj_extra.jTag;
    if (!self.layoutItems[@(key)]) self.layoutItems[@(key)] = item;
}

- (void)addSubviewForConstraintDescription:(YJLayoutItemConstraintDescription *)description {
    // TODO: container和secondItem不用上层指定顺序, 自动递归处理, 以后再实现吧
    __kindof UIView *component = description.firstItem.view;
    __kindof UIView *containerView = description.containerItem.view ?: self.owner;
    if (component.superview == containerView) return;
    
    if (description.aboveItem) [containerView insertSubview:component aboveSubview:description.aboveItem.view];
    else if (description.belowItem) [containerView insertSubview:component belowSubview:description.belowItem.view];
    else [containerView addSubview:component];
}

/// eg: maker.👉🏻leading👈🏻.equalTo(xx.leading)
- (MASConstraint *)getFirstItemConstraintFromMaker:(MASConstraintMaker *)make relatedItem:(YJLayoutRelatedItem *)itemConstraint {
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
- (MASConstraint * (^)(id))getItemRelationForConstraint:(MASConstraint *)constraint relatedItem:(YJLayoutRelatedItem *)relatedItem {
    if (!relatedItem.secondItem) return nil;
    switch (relatedItem.constraint.relation) {
        case YJLayoutRelationLessThanOrEqualTo:      return constraint.lessThanOrEqualTo;
        case YJLayoutRelationEqualTo:                return constraint.equalTo;
        case YJLayoutRelationGreaterThanOrEqualTo:   return constraint.greaterThanOrEqualTo;
        case YJLayoutRelationInsets:                 return constraint.equalTo;
        default: return nil;
    }
}

/// eg: maker.leading.equalTo(👉🏻item👈🏻)  or  maker.leading.equalTo(👉🏻item.leading👈🏻)

- (void)relationSecondItem:(YJLayoutRelatedItem *)relatedItem using:(MASConstraint * (^)(id))relation {
//- (void)relationSecondItemView:(__kindof UIView *)secondItemView relatedItem:(YJLayoutRelatedItem *)relatedItem using:(MASConstraint * (^)(id))relation {
    UIView *secondItemView = relatedItem.secondItem.view;
    switch (relatedItem.constraint.secondItemAttribute) {
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
//- (void)layoutComponent:(YJComponentType)type forScene:(NSInteger)scene withOffset:(UIOffset)offset {
//    if (!((UIView *)self.owner).yj_extra.viewForIdentifier) return;
//    __kindof UIView *component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
//    [component mas_updateConstraints:^(MASConstraintMaker *make) {
//        if (offset.horizontal != NSNotFound) make.centerX.offset(offset.horizontal);
//        if (offset.vertical != NSNotFound) make.centerY.offset(offset.vertical);
//    }];
//}
@end

@YJNamespaceInstanceImplementation(UIView, YJLayoutNamespace, yj_layout, YJLayoutAbility)

@end
