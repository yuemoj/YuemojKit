//
//  YJFrameNamespace.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/15.
//

#import "YJUIKitNamespace.h"
#import "YuemojUIAbilities.h"

@interface YJFrameNamespace ()<YuemojFrameAbility>

@end
@implementation YJFrameNamespace

- (void)setFrame:(CGRect)frame {
    [self.owner setFrame:frame];
}

- (CGRect)frame {
    return [self.owner frame];
}

- (void)setCenter:(CGPoint)center {
    [self.owner setCenter:center];
}

- (CGPoint)center {
    return [self.owner center];
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size =size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrign:(CGPoint)orign {
    CGRect frame = self.frame;
    frame.origin = orign;
    self.frame = frame;
}

- (CGPoint)orign {
     return self.frame.origin;
}

- (CGFloat)top {
    return self.y;
}

- (CGFloat)bottom {
    return self.top + self.height;
}

- (CGFloat)left {
    return self.x;
}

- (CGFloat)right {
    return self.left + self.width;
}
@end
