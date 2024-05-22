//
//  Foundation+Yuemoj.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/16.
//

#import "Foundation+Yuemoj.h"
#import "YJFoundationNamespace.h"

@YJNamespaceInstanceImplementation(NSString, YJStringNamespace, yj_string, YuemojStringCharacterAbility, YuemojPinyinAbility, YuemojUrlEncodingAbility, YuemojIPPortAbility, YuemojStringEncryptAbility, YuemojSubStringAbility, YuemojJSONAbility)

@end
@implementation NSString (WhiteSpace)
- (BOOL)yj_isValid {
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if (self == NULL) {
        return NO;
    }
    if (![self isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([self isEqualToString:@"null"]) {
        return NO;
    }
    if ([self isEqualToString:@"(null)"]) {
        return NO;
    }
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [self stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return NO;
    }
    return YES;
}

@end

@YJNamespaceInstanceImplementation(NSArray, YJArrayNamespace, yj_filter, YuemojFilterAbility)
@end
