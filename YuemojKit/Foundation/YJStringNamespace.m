//
//  YJStringNamespace.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/16.
//

#import "YJFoundationNamespace.h"
#import <CommonCrypto/CommonHMAC.h>
#import "YuemojFoundationAbilities.h"
#import "Foundation+Yuemoj.h"

#import "PinYin4Objc.h"

@implementation YJStringNamespace

- (BOOL)isValid {
    if ([self.owner isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if (self.owner == NULL) {
        return NO;
    }
    if (![self.owner isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([self.owner isEqualToString:@"null"]) {
        return NO;
    }
    if ([self.owner isEqualToString:@"(null)"]) {
        return NO;
    }
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [self.owner stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return NO;
    }
    return YES;
}

#pragma mark- private
/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    return [strM copy];
}

@end
//NSString * const kIPKey = @"ip";
//NSString * const kPortKey = @"port";

@interface YJStringNamespace (Character)<YuemojStringCharacterAbility>
@end
@implementation YJStringNamespace (Character)

- (NSString *)ownerString {
    if (!self.isValid) return nil;
    return self.owner;
}

- (BOOL(^)(NSInteger))reachLimitBytes {
    return ^BOOL(NSInteger bytes) {
        size_t contentLength = strlen([self.owner UTF8String]);
        return contentLength > bytes;
    };
}

- (NSString  * _Nullable (^)(NSInteger))substringToByteIndex {
    return ^NSString *(NSInteger targetByteLength) {
        if (!self.owner) return nil;
        if (!self.reachLimitBytes(targetByteLength)) return self.owner;
        NSInteger low = floor(targetByteLength / 3); // 尽量从靠近的字符的index开始计算, 一个中文字符在UTF-8编码里长度为3, 其他字符更少
        NSString *lowString = [self substringOfComposedCharacterSequenceAtIndex:low]; // TODO: string category???
        size_t lowByteLength = strlen(lowString.UTF8String);
        if (lowByteLength == targetByteLength) return lowString;
        // lowByteLength不可能大于index 这种情况就不做判断了, lowByteLength + 剩下的字符数 == index的场景在上面第二个if已经判断了
        // 取剩下的有效字符长度, 存在的情况:1.low之后的字符串长度比还需要的字节长度长,最差的情况就是剩下的字符都是单字节, high就取剩下的字节长度 + low; 2.low之后的字符串长度比还需要的字节长度短, 代表里面至少有一个非单字节字符, high就取length
        NSInteger high = low + MIN(targetByteLength - lowByteLength, self.ownerString.length - low);
        NSString *highString = [self substringOfComposedCharacterSequenceAtIndex:high];
        if (strlen(highString.UTF8String) == targetByteLength) return highString;
        return [self dichotomizingFrom:low to:high targetByteLength:targetByteLength];
    };
}

- (NSString *)dichotomizingFrom:(NSInteger)from to:(NSInteger)to targetByteLength:(NSInteger)targetByteLength {
    if (to - from == 1) {
        // 初始调用之前的处理中,to的字节数肯定是大于目标字节数的, 如果是相邻的, 取from的string返回即可
        return [self substringOfComposedCharacterSequenceAtIndex:from];
    }
    NSInteger mid = floor((from + to) * .5f);
    NSString *midString = [self substringOfComposedCharacterSequenceAtIndex:mid];
    size_t midByteLength = strlen(midString.UTF8String);
    if (midByteLength > targetByteLength) return [self dichotomizingFrom:from to:mid targetByteLength:targetByteLength];
    if (midByteLength < targetByteLength) return [self dichotomizingFrom:mid to:to targetByteLength:targetByteLength];
    return midString;
}

- (NSString *)substringOfComposedCharacterSequenceAtIndex:(NSInteger)index {
    // 避免表情字符截断, 取到前一个字符
    NSRange rangeIndex = [self.ownerString rangeOfComposedCharacterSequenceAtIndex:index];
    return [self.ownerString substringToIndex:rangeIndex.location];
}

static NSString * const emojRegular = @"[\\u0000-\\u001F\\u0022\\u0026\\u0027\\u002C-\\u002F\\u003A-\\u003F\\u005B-\\u005D\\u0060\\u007B-\\u007D\\u0080-\\u00FF\\u0250-\\u036F\\u1D00-\\u1DFF\\u2000-\\u2BFF\\u2E00-\\u2E7F\\u3000-\\u303F\\u3200-\\u33FF\\u4DC0-\\u4DFF\\uA700-\\uA71F\\uFB50-\uFE2F\uFE49\uFF00-\uFFFF]+";
- (BOOL)containEmoji {
    if (!self.ownerString) return NO;
    return [self.ownerString rangeOfString:emojRegular options:NSRegularExpressionSearch].location != NSNotFound;
}

static NSString * const specialCharacterRegular = @"[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\ud83e\\udc00-\\ud83e\\udfff]|[\\u2100-\\u32ff]|[\\u0030-\\u007f][\\u20d0-\\u20ff]|[\\u0080-\\u00ff]";
- (BOOL)containSpecialCharacter {
    if (!self.ownerString) return NO;
    return [self.ownerString rangeOfString:specialCharacterRegular options:NSRegularExpressionSearch].location != NSNotFound;
}

- (NSString *)removeSpecialCharacter {
    return [self removeStringWithPattern:specialCharacterRegular];
}

- (NSString *)removeEmoji {
    return [self removeStringWithPattern:emojRegular];
}

- (NSString *)removeStringWithPattern:(NSString *)pattern {
    if (!self.ownerString) return nil;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    return [regularExpression stringByReplacingMatchesInString:self.ownerString options:0 range:(NSRange){0, self.ownerString.length} withTemplate:@""];
}
@end

@interface YJStringNamespace (SubString)<YuemojSubStringAbility>
@end
@implementation YJStringNamespace (SubString)
- (NSString * _Nullable (^)(NSString * _Nonnull))subBefore {
    return ^NSString *(NSString *seperator) {
        if (!self.ownerString.yj_isValid) return self.ownerString;
        if (!seperator.yj_isValid) return self.ownerString;
        NSString *beforeRegular = [NSString stringWithFormat:@"[a-zA-Z\\d]+(?=%@)", seperator];
        NSRange range = [self.ownerString rangeOfString:beforeRegular options:NSRegularExpressionSearch];
        if (range.location == NSNotFound) return self.ownerString;
        return [self.ownerString substringWithRange:range];
    };
}
@end

@interface YJStringNamespace (Pinyin)<YuemojPinyinAbility>
@end
@implementation YJStringNamespace (Pinyin)
- (NSString *)pinyin {
    if (!self.isValid) {
        return nil;
    }
    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    return [PinyinHelper toHanyuPinyinStringWithNSString:self.owner withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];
}
@end

@interface YJStringNamespace (UrlEncoding)<YuemojUrlEncodingAbility>
@end
@implementation YJStringNamespace (UrlEncoding)
- (NSDictionary *)extractUrlParams {
    NSString *paramsStr = self.owner;
    if ([self.owner containsString:@"?"]){
        NSArray *array = [self.owner componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            paramsStr = array.lastObject;
        }
    }
    
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
    for (NSString *param in paramArray) {
        if (param && param.length) {
            NSArray *parArr = [param componentsSeparatedByString:@"="];
            if (parArr.count == 2) {
                [paramsDict setObject:[parArr.lastObject urlDecode] forKey:parArr.firstObject];
            }
        }
    }
    return paramsDict;
}

- (NSString *)urlEncode {
    return [self.owner stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*’”();:@&=+$,/?%#[]%\\"]];
//    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}

//- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
//    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self.owner, NULL, (__bridge_retained CFStringRef)@"!*’”();:@&=+$,/?%#[]%\\", CFStringConvertNSStringEncodingToEncoding(encoding));
//}

- (NSString *)urlDecode {
    return [self.owner stringByRemovingPercentEncoding];
//    return [self urlDecodeUsingEncoding:NSUTF8StringEncoding];
}

//- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding {
//    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
//            (__bridge CFStringRef)self.owner,
//            CFSTR(""),
//            CFStringConvertNSStringEncodingToEncoding(encoding));
//}
@end

@interface YJStringNamespace (IPPort)<YuemojIPPortAbility>
@end
@implementation YJStringNamespace (IPPort)
- (void)seperateToIP:(NSString **)ip port:(NSString **)port {
    // ipv4
    if (![self.owner containsString:@":"]) {
        *ip = self.owner;
        return;
    }
    NSArray *components = [self.owner componentsSeparatedByString:@":"];
    *ip = components.firstObject;
    *port = components.lastObject;
    
    // ipv6
}

- (void (^)(NSString * _Nullable __autoreleasing *, NSString * _Nullable __autoreleasing *))ipSeperate {
    return ^(NSString **ip, NSString **port) {
        // ipv4
        if (![self.owner containsString:@":"]) {
            *ip = self.owner;
        }
        NSArray *components = [self.owner componentsSeparatedByString:@":"];
        *ip = components.firstObject;
        *port = components.lastObject;
        
        // ipv6
    };
}
@end

@interface YJStringNamespace (Encrypt)<YuemojStringEncryptAbility>
@end
@implementation YJStringNamespace (Encrypt)
- (NSString *)base64 {
    if (!self.isValid) {
        return nil;
    }
    return [[self.owner dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
}

- (NSString *)md5 {
    if (!self.isValid) {
        return nil;
    }
    const char *str = [self.owner UTF8String];
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sha1 {
    if (!self.isValid) {
        return nil;
    }
    const char *str = [self.owner UTF8String];
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(str, (CC_LONG)strlen(str), buffer);
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString * _Nullable (^)(NSString * _Nonnull))hmacSHA256WithKey {
    if (!self.isValid) {
        return nil;
    }
    return ^(NSString *key) {
        const char *keyData = key.UTF8String;
        const char *strData = [self.owner UTF8String];
        uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
        CCHmac(kCCHmacAlgSHA256, keyData, strlen(keyData), strData, strlen(strData), buffer);
        return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
    };
}

- (NSString * _Nullable (^)(NSString * _Nonnull))hmacSHA256 {
    return ^NSString *_Nullable (NSString *secretKey) {
        return self.hmacSHA256WithKey(secretKey);
    };
}

- (NSString * _Nullable (^)(NSString * _Nonnull))hmacSHA256_base64 {
    return ^NSString *_Nullable (NSString *secretKey) {
        return self.hmacSHA256(secretKey).yj_string.base64;
    };
}

- (nullable NSString *)signiture {
    NSInteger flag1 = 0x1, flag2 = 0xffff;
    NSInteger s = self.subBefore(@"@").integerValue;
    NSString *s1 = [NSString stringWithFormat:@"%08lx", (flag1 << 31) | (s << 1)];
    NSString *s2 = [NSString stringWithFormat:@"%08lx", (flag2 << 16)];
    NSString *s4 = [NSString stringWithFormat:@"%08lx", (flag1 << 31) + s];
    return [NSString stringWithFormat:@"%@%@%@%@", s1, s2, s2, s4];
}
@end


@interface YJStringNamespace (JSON)<YuemojJSONAbility>
@end
@implementation YJStringNamespace (JSON)
- (NSDictionary *)json2Dictionary {
    if (!self.isValid) return nil;
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:[self.ownerString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
    if (error || !result || ![result isKindOfClass:NSDictionary.class]) return nil;
    return result;
}
@end
