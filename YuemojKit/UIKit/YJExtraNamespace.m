//
//  YJExtraNamespace.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/16.
//

#import "YJUIKitNamespace.h"

@interface YJExtraNamespace ()<YuemojExtraAbility>
@property (nonatomic) NSInteger jTag;
@end
@implementation YJExtraNamespace
@synthesize viewForIdentifier;
- (void (^)(YJComponentType, NSInteger))setJTag {
    return ^(YJComponentType type, NSInteger scene) {
        self.jTag = yj_componentIdentifier(type, scene);
    };
}
@end
