//
//  YJArrayNamespace.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/17.
//

#import "YuemojFoundationAbilities.h"
#import "YJFoundationNamespace.h"

@interface YJArrayNamespace ()<YuemojFilterAbility>
@end
@implementation YJArrayNamespace

- (NSArray * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))filterKeyValue {
    return ^NSArray *(NSString *keyPath, NSString *value) {
        return self.filterKeypath(keyPath)(value);
    };
}

- (YJFilter  _Nonnull (^)(NSString * _Nonnull))filterKeypath {
    return ^YJFilter(NSString *keypath) {
        return self.filterKeypathIgnoreCase(keypath, YES);
    };
}

- (YJFilter  _Nonnull (^)(NSString * _Nonnull, BOOL))filterKeypathIgnoreCase {
    return ^YJFilter(NSString *keypath, BOOL ignore) {
        return [self filterWithKeypath:keypath ignoreCase:ignore];
    };
}

- (NSArray * _Nullable (^)(id _Nonnull))filter {
    return self.filterIgnoreCase(YES);
}
//- (YJFilter  _Nonnull (^)(void))filter {
//    return ^YJFilter(void) {
//        return self.filterIgnoreCase(YES);
//    };
//}

- (YJFilter  _Nonnull (^)(BOOL))filterIgnoreCase {
    return ^YJFilter(BOOL ignore) {
        return [self filterIgnoreCase:ignore];
    };
}

#pragma mark-
//- (YJFilter)filterWithKeypath:(NSString *)keypath {
//    return [self filterWithKeypath:keypath ignoreCase:YES];
//}

- (YJFilter)filterWithKeypath:(NSString *)keypath ignoreCase:(BOOL)ignore {
    NSString *format = [NSString stringWithFormat:@"SELF.%@ ==%@ $value", keypath, ignore ? @" [cd]" : @""];
    NSPredicate *matchPredicate = [NSPredicate predicateWithFormat:format];
    return ^NSArray *(id value) {
        if ([self.owner count]) {
            return [self.owner filteredArrayUsingPredicate:[matchPredicate predicateWithSubstitutionVariables:@{@"value": value}]];
        }
        return nil;
    };
}

//- (YJFilter)filterValue {
//    return [self filterIgnoreCase:YES];
//}

- (YJFilter)filterIgnoreCase:(BOOL)ignore {
    NSString *format = [NSString stringWithFormat:@"SELF == %@$value", ignore ? @"[cd] " : @""];
    NSPredicate *matchPredicate = [NSPredicate predicateWithFormat:format];
    return ^NSArray *(id value) {
        if ([self.owner count]) {
            return [self.owner filteredArrayUsingPredicate:[matchPredicate predicateWithSubstitutionVariables:@{@"value": value}]];
        }
        return nil;
    };
}

@end
