//
//  YJLayoutModels.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/1/30.
//

#import "YJLayoutModels.h"

@implementation YJLayoutAnchor
+ (instancetype)anchorWithAttribute:(YJLayoutAttribute)anchor owner:(id)owner {
    return [[self alloc] initWithAttribute:anchor owner:owner];
}

- (instancetype)initWithAttribute:(YJLayoutAttribute)anchor owner:(id)owner {
    if (self = [super init]) {
        self.layoutAttribute = anchor;
        self.owner = owner;
    }
    return self;
}
@end

@interface YJLayoutAnchor (Handler)<YJLayoutAnchorProtocol> @end

@interface YJLayoutConstraintMaker : NSObject<YJLayoutConstraintAttributeDelegate>
@property (nonatomic) id<YJLayoutAnchorProtocol> top;
@property (nonatomic) id<YJLayoutAnchorProtocol> bottom;
@property (nonatomic) id<YJLayoutAnchorProtocol> leading;
@property (nonatomic) id<YJLayoutAnchorProtocol> trailing;
@property (nonatomic) id<YJLayoutAnchorProtocol> centerX;
@property (nonatomic) id<YJLayoutAnchorProtocol> centerY;
@property (nonatomic) id<YJLayoutAnchorProtocol> center;
@property (nonatomic) id<YJLayoutAnchorProtocol> edgeInset;
@property (nonatomic) id<YJLayoutAnchorProtocol> width;
@property (nonatomic) id<YJLayoutAnchorProtocol> height;

@property (nonatomic) NSMutableArray<YJLayoutRelatedItem *> *relatedItems;

@end
@implementation YJLayoutConstraintMaker
- (void)addItemConstraintWithAttribute:(YJLayoutAttribute)attribute {
    YJLayoutRelatedItem *itemConstraint = [YJLayoutRelatedItem new];
    itemConstraint.constraint.firstItemAttribute = attribute;
    [self.relatedItems addObject:itemConstraint];
}

- (void)itemConstraintsRelated:(YJLayoutRelation)relation to:(YJLayoutItem *)item attribute:(YJLayoutAttribute)attribute {
    NSAssert([item isKindOfClass:[YJLayoutItem class]], @"Assert Fail: Related item must be a kind of Class YJLayoutItem!");
    for (YJLayoutRelatedItem *tmpConstraint in self.relatedItems) {
        if (tmpConstraint.hasRelated) continue;
        tmpConstraint.secondItem = item;
        tmpConstraint.constraint.relation = relation;
        tmpConstraint.constraint.secondItemAttribute = attribute;
        tmpConstraint.hasRelated = YES;
    }
}

- (void)itemConstraintsRelated:(YJLayoutRelation)relation constant:(CGFloat)constant {
    for (YJLayoutRelatedItem *tmpConstraint in self.relatedItems) {
        if (tmpConstraint.hasRelated) continue;
        tmpConstraint.constraint.relation = relation;
        tmpConstraint.constraint.constant = constant;
        tmpConstraint.hasRelated = YES;
    }
}

- (void)setLayoutMultiplier:(CGFloat)multiplier {
    for (YJLayoutRelatedItem *tmpConstraint in self.relatedItems) {
        if (tmpConstraint.hasRelated) continue;
        tmpConstraint.constraint.multiplier = multiplier;
        tmpConstraint.hasRelated = YES;
    }
    // 懒得判断是不是全部已经设置了hasRelated, 例如equalTo(view.xx).multiplidBy(xx)时, hasRelated就全部为YES, 此时offset只设置最后一个constraint
    self.relatedItems.lastObject.constraint.multiplier = multiplier;
}

- (void)setOffset:(CGFloat)offset {
    for (YJLayoutRelatedItem *tmpConstraint in self.relatedItems) {
        if (tmpConstraint.hasRelated) continue;
        tmpConstraint.constraint.constant = offset;
        tmpConstraint.hasRelated = YES;
    }
    // 懒得判断是不是全部已经设置了hasRelated, 例如equalTo(view.xx).offset(xx)时, hasRelated就全部为YES, 此时offset只设置最后一个constraint
    self.relatedItems.lastObject.constraint.constant = offset;
}

- (void)setPriority:(UILayoutPriority)priority {  
    self.relatedItems.lastObject.constraint.priority = priority;
    self.relatedItems.lastObject.hasRelated = YES;
}

- (void)insets:(UIEdgeInsets)edgeInsets {
    self.relatedItems.lastObject.constraint.relation = YJLayoutRelationInsets;
    self.relatedItems.lastObject.constraint.edgeInsets = edgeInsets;
    self.relatedItems.lastObject.hasRelated = YES;
}

- (NSMutableArray<YJLayoutRelatedItem *> *)relatedItems {
    if (!_relatedItems) _relatedItems = [NSMutableArray arrayWithCapacity:0];
    return _relatedItems;
}

- (id<YJLayoutAnchorProtocol>)top {
    if (!_top) {
        _top = [YJLayoutAnchor<YJLayoutConstraintMaker *> anchorWithAttribute:YJLayoutAttributeTop owner:self];
        [self addItemConstraintWithAttribute:YJLayoutAttributeTop];
    }
    return _top;
}
- (id<YJLayoutAnchorProtocol>)bottom {
    if (!_bottom) {
        _bottom = [YJLayoutAnchor<YJLayoutConstraintMaker *> anchorWithAttribute:YJLayoutAttributeBottom owner:self];
        [self addItemConstraintWithAttribute:YJLayoutAttributeBottom];
    }
    return _bottom;
}
- (id<YJLayoutAnchorProtocol>)leading {
    if (!_leading) {
        _leading = [YJLayoutAnchor<YJLayoutConstraintMaker *> anchorWithAttribute:YJLayoutAttributeLeading owner:self];
        [self addItemConstraintWithAttribute:YJLayoutAttributeLeading];
    }
    return _leading;
}
- (id<YJLayoutAnchorProtocol>)trailing {
    if (!_trailing) {
        _trailing = [YJLayoutAnchor<YJLayoutConstraintMaker *> anchorWithAttribute:YJLayoutAttributeTrailing owner:self];
        [self addItemConstraintWithAttribute:YJLayoutAttributeTrailing];
    }
    return _trailing;
}
- (id<YJLayoutAnchorProtocol>)centerX {
    if (!_centerX) {
        _centerX = [YJLayoutAnchor<YJLayoutConstraintMaker *> anchorWithAttribute:YJLayoutAttributeCenterX owner:self];
        [self addItemConstraintWithAttribute:YJLayoutAttributeCenterX];
    }
    return _centerX;
}
- (id<YJLayoutAnchorProtocol>)centerY {
    if (!_centerY) {
        _centerY = [YJLayoutAnchor<YJLayoutConstraintMaker *> anchorWithAttribute:YJLayoutAttributeCenterY owner:self];
        [self addItemConstraintWithAttribute:YJLayoutAttributeCenterY];
    }
    return _centerY;
}
- (id<YJLayoutAnchorProtocol>)center {
    if (!_center) {
        _center = [YJLayoutAnchor<YJLayoutConstraintMaker *> anchorWithAttribute:YJLayoutAttributeCenter owner:self];
        [self addItemConstraintWithAttribute:YJLayoutAttributeCenter];
    }
    return _center;
}
- (id<YJLayoutAnchorProtocol>)edges {
    if (!_edgeInset) {
        _edgeInset = [YJLayoutAnchor<YJLayoutConstraintMaker *> anchorWithAttribute:YJLayoutAttributeEdgeInset owner:self];
        [self addItemConstraintWithAttribute:YJLayoutAttributeEdgeInset];
    }
    return _edgeInset;
}
- (id<YJLayoutAnchorProtocol>)width {
    if (!_width) {
        _width = [YJLayoutAnchor<YJLayoutConstraintMaker *> anchorWithAttribute:YJLayoutAttributeWidth owner:self];
        [self addItemConstraintWithAttribute:YJLayoutAttributeWidth];
    }
    return _width;
}
- (id<YJLayoutAnchorProtocol>)height {
    if (!_height) {
        _height = [YJLayoutAnchor<YJLayoutConstraintMaker *> anchorWithAttribute:YJLayoutAttributeHeight owner:self];
        [self addItemConstraintWithAttribute:YJLayoutAttributeHeight];
    }
    return _height;
}
@end

@implementation YJLayoutAnchor (Handler)
- (id<YJLayoutAnchorProtocol>(^)(id))lessThanOrEqualTo {
    return ^(id anchor) {
        YJLayoutRelation relation = YJLayoutRelationLessThanOrEqualTo;
        if ([anchor isKindOfClass:[YJLayoutItem class]]) {
            [self.owner itemConstraintsRelated:relation to:anchor attribute:YJLayoutAttributeSame];
        } else if ([anchor isKindOfClass:[YJLayoutAnchor class]]) {
            [self.owner itemConstraintsRelated:relation to:[anchor owner] attribute:[anchor layoutAttribute]];
        } else if ([anchor isKindOfClass:[NSNumber class]]) {
            [self.owner itemConstraintsRelated:relation constant:[anchor floatValue]];
        } else {
            NSAssert(NO, @"Assert Fail: attribute can only be a Number or kind of Class 'YJLayoutItem' or 'YJLayoutAnchor'");
        }
        return self;
    };
}

- (id<YJLayoutAnchorProtocol>(^)(id))equalTo {
    return ^(id anchor) {
        YJLayoutRelation relation = YJLayoutRelationEqualTo;
        if ([anchor isKindOfClass:[YJLayoutItem class]]) {
            [self.owner itemConstraintsRelated:relation to:anchor attribute:YJLayoutAttributeSame];
        } else if ([anchor isKindOfClass:[YJLayoutAnchor class]]) {
            [self.owner itemConstraintsRelated:relation to:[anchor owner] attribute:[anchor layoutAttribute]];
        } else if ([anchor isKindOfClass:[NSNumber class]]) {
            [self.owner itemConstraintsRelated:relation constant:[anchor floatValue]];
        } else {
            NSAssert(NO, @"Assert Fail: attribute can only be a Number or kind of Class 'YJLayoutItem' or 'YJLayoutAnchor'");
        }
        return self;
    };
}

- (id<YJLayoutAnchorProtocol>(^)(id))greaterThanOrEqualTo {
    return ^(id anchor) {
        YJLayoutRelation relation = YJLayoutRelationGreaterThanOrEqualTo;
        if ([anchor isKindOfClass:[YJLayoutItem class]]) {
            [self.owner itemConstraintsRelated:relation to:anchor attribute:YJLayoutAttributeSame];
        } else if ([anchor isKindOfClass:[YJLayoutAnchor class]]) {
            [self.owner itemConstraintsRelated:relation to:[anchor owner] attribute:[anchor layoutAttribute]];
        } else if ([anchor isKindOfClass:[NSNumber class]]) {
            [self.owner itemConstraintsRelated:relation constant:[anchor floatValue]];
        } else {
            NSAssert(NO, @"Assert Fail: param can only be a Number or kind of Class 'YJLayoutItem' or 'YJLayoutAnchor'");
        }
        return self;
    };
}

- (id<YJLayoutAnchorProtocol> _Nonnull (^)(CGFloat))multipliedBy {
    return ^(CGFloat multiplier) {
        [self.owner setLayoutMultiplier:multiplier];
        return self;
    };
}

- (id<YJLayoutAnchorProtocol> _Nonnull (^)(UIEdgeInsets))insets {
    return ^(UIEdgeInsets edgeInsets) {
        [self.owner insets:edgeInsets];
        return self;
    };
}

- (id<YJLayoutAnchorProtocol> _Nonnull (^)(CGFloat))yj_offset {
    return ^(CGFloat offset) {
        [self.owner setOffset:offset];
        return self;
    };
}

- (id<YJLayoutAnchorProtocol>  _Nonnull (^)(UILayoutPriority))priority {
    return ^(UILayoutPriority p) {
        [self.owner setPriority:p];
        return self;
    };
}
@end

#import "UIKit/UIKit.h"
#import "UIKit+Yuemoj.h"
@interface YJLayoutItem ()
@end
@implementation YJLayoutItem
- (void)bindView:(__kindof UIView *)view withType:(YJComponentType)type {
    [self bindView:view withType:type scene:kYJDefaultPlaceHolderScene];
}

- (void)bindView:(__kindof UIView *)view withType:(YJComponentType)type scene:(NSInteger)scene {
    [self bindView:view withType:type scene:scene custom:NO];
}

- (void)bindView:(__kindof UIView *)view withType:(YJComponentType)type scene:(NSInteger)scene custom:(BOOL)isCustom {
    _view = view;
    view.yj_extra.setJTag(type, scene);
}

- (YJLayoutAnchor *)top {
    if (!_top) _top = [YJLayoutAnchor<YJLayoutItem *> anchorWithAttribute:YJLayoutAttributeTop owner:self];
    return _top;
}
- (YJLayoutAnchor *)bottom {
    if (!_bottom) _bottom = [YJLayoutAnchor<YJLayoutItem *> anchorWithAttribute:YJLayoutAttributeBottom owner:self];
    return _bottom;
}
- (YJLayoutAnchor *)leading {
    if (!_leading) _leading = [YJLayoutAnchor<YJLayoutItem *> anchorWithAttribute:YJLayoutAttributeLeading owner:self];
    return _leading;
}
- (YJLayoutAnchor *)trailing {
    if (!_trailing) _trailing = [YJLayoutAnchor<YJLayoutItem *> anchorWithAttribute:YJLayoutAttributeTrailing owner:self];
    return _trailing;
}
- (YJLayoutAnchor *)centerX {
    if (!_centerX) _centerX = [YJLayoutAnchor<YJLayoutItem *> anchorWithAttribute:YJLayoutAttributeCenterX owner:self];
    return _centerX;
}
- (YJLayoutAnchor *)centerY {
    if (!_centerY) _centerY = [YJLayoutAnchor<YJLayoutItem *> anchorWithAttribute:YJLayoutAttributeCenterY owner:self];
    return _centerY;
}
- (YJLayoutAnchor *)center {
    if (!_center) _center = [YJLayoutAnchor<YJLayoutItem *> anchorWithAttribute:YJLayoutAttributeCenter owner:self];
    return _center;
}
- (YJLayoutAnchor *)width {
    if (!_width) _width = [YJLayoutAnchor<YJLayoutItem *> anchorWithAttribute:YJLayoutAttributeWidth owner:self];
    return _width;
}
- (YJLayoutAnchor *)height {
    if (!_height) _height = [YJLayoutAnchor<YJLayoutItem *> anchorWithAttribute:YJLayoutAttributeHeight owner:self];
    return _height;
}

- (YJLayoutItemConstraintDescription *)makeItemDescription:(void (NS_NOESCAPE^)(id<YJLayoutConstraintAttributeDelegate> _Nonnull))make {
    if (!make) return nil;
    YJLayoutConstraintMaker *maker = [YJLayoutConstraintMaker new];
    make(maker);
    YJLayoutItemConstraintDescription *description = [YJLayoutItemConstraintDescription new];
    description.firstItem = self;
    description.relatedItems = maker.relatedItems;
    return description;
}
@end

@implementation YJLayoutItemConstraint
@end

@implementation YJLayoutRelatedItem
- (YJLayoutItemConstraint *)constraint {
    if (!_constraint) _constraint = [YJLayoutItemConstraint new];
    return _constraint;
}
@end

@implementation YJLayoutItemConstraintDescription
@end

