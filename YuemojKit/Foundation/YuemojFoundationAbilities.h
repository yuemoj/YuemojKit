//
//  YuemojFoundationAbilities.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YuemojStringCharacterAbility <NSObject>
@property (nonatomic, readonly, nullable) NSString *ownerString;
//- (BOOL)isValid;
@property (nonatomic, readonly) BOOL(^reachLimitBytes)(NSInteger);
@property (nonatomic, readonly) NSString * _Nullable (^substringToByteIndex)(NSInteger);
@property (nonatomic, readonly) BOOL containEmoji;
@property (nonatomic, readonly) BOOL containSpecialCharacter;
@property (nonatomic, readonly, nullable) NSString *removeSpecialCharacter;
@property (nonatomic, readonly, nullable) NSString *removeEmoji;
@end

@protocol YuemojPinyinAbility <NSObject>
@property (nonatomic, readonly, nullable) NSString *pinyin;
@end;

@protocol YuemojUrlEncodingAbility
/// 提取URL中的参数-值
@property (nonatomic, readonly, nullable) NSDictionary *extractUrlParams;
@property (nonatomic, readonly, nullable) NSString *urlEncode;
@property (nonatomic, readonly, nullable) NSString *urlDecode;
@end

@protocol YuemojIPPortAbility <NSObject>
/// 地址拆分 ip+port (ipv4和ipv6)
@property (nonatomic, readonly) void(^ipSeperate)(NSString * _Nullable * _Nullable ip, NSString * _Nullable * _Nullable port);
@end

@protocol YuemojStringEncryptAbility <NSObject>
@property (nonatomic, readonly, nullable) NSString *base64;
/// MD5
@property (nonatomic, readonly, nullable) NSString *md5;
/// sha1
@property (nonatomic, readonly, nullable) NSString *sha1;
@property (nonatomic, readonly) NSString * _Nullable(^hmacSHA256)(NSString *);
@property (nonatomic, readonly) NSString * _Nullable(^hmacSHA256_base64)(NSString *);
/// HMAC-SHA256
//- (nullable NSString *)hmacSHA256WithKey:(NSString *)key;
@property (nonatomic, readonly, nullable) NSString * _Nullable (^hmacSHA256WithKey)(NSString *);

/// test
@property (nonatomic, readonly, nullable) NSString *signiture;
@end

@protocol YuemojSubStringAbility <NSObject>
@property (nonatomic, readonly) NSString * _Nullable (^subBefore)(NSString *seperator);
@end

@protocol YuemojJSONAbility <NSObject>
@property (nonatomic, readonly, nullable) NSDictionary *json2Dictionary;
@end

#pragma mark- Array
typedef NSArray *_Nullable(^YJFilter)(id value);
@protocol YuemojFilterAbility <NSObject>
@property (nonatomic, readonly) NSArray *_Nullable(^filter)(id value);
/// 指定keypath和value筛选, TODO:其他类型的值
@property (nonatomic, readonly) NSArray  * _Nullable (^filterKeyValue)(NSString *keypath, NSString *);
/// block返回一个指定了keypath的筛选器block, 再次执行传入value即可筛选, 用于筛选多个不同的value
@property (nonatomic, readonly) YJFilter(^filterKeypath)(NSString *keypath);
@property (nonatomic, readonly) YJFilter(^filterKeypathIgnoreCase)(NSString *keypath, BOOL ignoreCase);
@property (nonatomic, readonly) YJFilter(^filterIgnoreCase)(BOOL);
@end

NS_ASSUME_NONNULL_END
