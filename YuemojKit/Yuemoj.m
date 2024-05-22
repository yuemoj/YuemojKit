//
//  Yuemoj.m
//  YuemojKit
//
//  Created by Yuemoj on 2023/2/1.
//

#import "Yuemoj.h"
@class UIView;
@implementation Yuemoj
+ (instancetype)yjWithOwner:(id)owner {
    return [[self alloc] initWithOwner:owner];
}

- (instancetype)initWithOwner:(id)owner {
    if (self = [super init]) {
        _owner = owner;
    }
    return self;
}

@end


