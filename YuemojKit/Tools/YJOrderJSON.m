//
//  YJSON.m
//  YuemojKit
//
//  Created by Yuemoj on 2023/3/30.
//

#import "YJOrderJSON.h"

@interface YJOrderJSON ()
@property (nonatomic) NSMutableString *jsonString;
@end

@implementation YJOrderJSON
+ (NSString *)dicMake:(void(NS_NOESCAPE^)(YJOrderJSON *maker))aBlock {
    YJOrderJSON *json = [YJOrderJSON new];
    return [json dicMake:aBlock];
}

+ (NSString *)arrMake:(void (NS_NOESCAPE^)(YJOrderJSON * _Nonnull))aBlock {
    YJOrderJSON *json = [YJOrderJSON new];
    return [json arrMake:aBlock];
}

- (NSString *)dicMake:(void(NS_NOESCAPE^)(YJOrderJSON *maker))aBlock {
    [self.jsonString appendString:@"{"];
    !aBlock ?: aBlock(self);
    [self.jsonString appendString:@"}"];
    return self.jsonString;
}

- (NSString *)arrMake:(void (NS_NOESCAPE^)(YJOrderJSON * _Nonnull))aBlock {
    [self.jsonString appendString:@"["];
    !aBlock ?: aBlock(self);
    [self.jsonString appendString:@"]"];
    return self.jsonString;
}

NSString *const kStringKeyValueFormat = @"\"%@\":\"%@\"";
NSString *const kNormalKeyValueFormat = @"\"%@\":%@";
NSString *const kStringValueFormat = @"\"%@\"";
NSString *const kNormalValueFormat = @"%@";
- (YJOrderJSON * _Nonnull (^)(NSString * _Nonnull, id _Nonnull))addKeyValue {
    return ^(NSString *key, id value) {
        [self.jsonString appendFormat:[value isKindOfClass:[NSString class]] ? kStringKeyValueFormat : kNormalKeyValueFormat, key, value];
        return self;
    };
}

- (YJOrderJSON * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))addKeyJSONValue {
    return ^(NSString *key, NSString *JSONValue) {
        [self.jsonString appendFormat:kNormalKeyValueFormat, key, JSONValue];
        return self;
    };
}

- (YJOrderJSON * _Nonnull (^)(id _Nonnull))addValue {
    return ^(id value) {
        [self.jsonString appendFormat:[value isKindOfClass:[NSString class]] ? kStringValueFormat : kNormalValueFormat, value];
        return self;
    };
}

- (YJOrderJSON * _Nonnull (^)(NSString * _Nonnull))addJSONValue {
    return ^(id value) {
        [self.jsonString appendFormat:kNormalValueFormat, value];
        return self;
    };
}

- (YJOrderJSON * _Nonnull (^)(NSArray * _Nonnull))addArr {
    return ^(NSArray *arr) {
        BOOL firstObjDued = NO;
        for (id tmp in arr) {
            if ([tmp isKindOfClass:[NSDictionary class]]) {
                return self;
            }
            if (!firstObjDued) {
                [self.jsonString appendString:@"["];
                firstObjDued = YES;
            }
            self.addValue(tmp);
            if (tmp == arr.lastObject) {
                [self.jsonString appendString:@"]"];
            } else {
                [self addComma];
            }
        }
        return self;
    };
}

- (YJOrderJSON *)addComma {
    [self.jsonString appendString:@","];
    return self;
}

+ (NSString *)yjsonWithParams:(NSDictionary *)params orders:(NSArray<YJOrderJSONItem *> *)orders {
    YJOrderJSON *yj = [YJOrderJSON new];
    return [yj jsonWithParams:params orders:orders];
}

- (NSString *)jsonWithParams:(NSDictionary *)params orders:(NSArray<YJOrderJSONItem *> *)orders {
    [self dicMake:^(YJOrderJSON *maker) {
        for (YJOrderJSONItem *tmpItem in orders) {
            id value = params[tmpItem.key];
            if ([value isKindOfClass:[NSDictionary class]]) {
                // 如果value是嵌套的字典, 从order中取其字段顺序
                maker.addKeyJSONValue(tmpItem.key, [maker jsonWithParams:value orders:tmpItem.items]);
            } else if([value isKindOfClass:[NSArray class]]) {
                maker.addKeyJSONValue(tmpItem.key, [YJOrderJSON arrMake:^(YJOrderJSON * _Nonnull arrMaker) {
                    // 如果value是嵌套的数组, 则遍历数组的每一项, 从order中取其字段顺序
                    // arrmaker整个数组全部反序列化完成后再加到key后, 所以需要重新起一个maker
                    for (id arrItem in value) {
                        // 如果arrItem只是单纯的值??
                        if (![arrItem isKindOfClass:[NSDictionary class]] && ![arrItem isKindOfClass:[NSArray class]]) {
                            arrMaker.addKeyValue(tmpItem.key, arrItem);
                        } else {
                            [arrMaker jsonWithParams:arrItem orders:tmpItem.items];
                        }
                        if (arrItem != [value lastObject]) {
                            [arrMaker addComma];
                        }
                    }
                }]);
            } else {
                maker.addKeyValue(tmpItem.key, value);
            }
            if (tmpItem != orders.lastObject) {
                [maker addComma];
            }
        }
    }];
    return self.jsonString;
}

- (NSMutableString *)jsonString {
    if (!_jsonString) {
        _jsonString = [NSMutableString stringWithCapacity:0];
    }
    return _jsonString;
}
@end

@implementation YJOrderJSONItem @end

@interface YJOrderJSONGenerator ()
@property (nonatomic) NSMutableArray<YJOrderJSONItem *> *itemArray;
@end
@implementation YJOrderJSONGenerator
+ (YJOrderJSONGenerator * _Nonnull (^)(NSString * _Nonnull))addSimpleItem {
    return ^(NSString *key) {
        return self.addItem(key, nil);
    };
}

- (YJOrderJSONGenerator * _Nonnull (^)(NSString * _Nonnull))addSimpleItem {
    return ^(NSString *key) {
        return self.addItem(key, nil);
    };
}

+ (YJOrderJSONGenerator * _Nonnull (^)(NSString * _Nonnull, NSArray<YJOrderJSONItem *> * _Nullable))addItem {
    YJOrderJSONGenerator *generator = [YJOrderJSONGenerator new];
    return ^(NSString *key, NSArray *items) {
        return generator.addItem(key, items);
    };
}

- (YJOrderJSONGenerator * _Nonnull (^)(NSString * _Nonnull, NSArray<YJOrderJSONItem *> * _Nullable))addItem {
    return ^(NSString *key, NSArray *items) {
        YJOrderJSONItem *item = [YJOrderJSONItem new];
        item.key = key;
        item.items = items;
        [self.itemArray addObject:item];
        return self;
    };
}

- (NSString * _Nonnull (^)(NSDictionary * _Nonnull))generate {
    return ^(NSDictionary *params) {
        return [YJOrderJSON yjsonWithParams:params orders:self.items];
    };
}

- (NSArray<YJOrderJSONItem *> *)items {
    return self.itemArray;
}

- (NSMutableArray<YJOrderJSONItem *> *)itemArray {
    if (!_itemArray) {
        _itemArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _itemArray;
}

@end
