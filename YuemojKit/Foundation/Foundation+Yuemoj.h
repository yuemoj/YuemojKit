//
//  Foundation+Yuemoj.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/16.
//

#import "Yuemoj.h"
#import "YuemojMacros.h"
#import "YuemojFoundationAbilities.h"

NS_ASSUME_NONNULL_BEGIN
@YJNamespaceInstanceDeclaration(NSString, NSObject, yj_string, YuemojStringCharacterAbility, YuemojPinyinAbility, YuemojUrlEncodingAbility, YuemojIPPortAbility, YuemojStringEncryptAbility, YuemojSubStringAbility, YuemojJSONAbility)
@end

@interface NSString (WhiteSpace)
- (BOOL)yj_isValid;
@end

@YJNamespaceInstanceDeclaration(NSArray, NSObject, yj_filter, YuemojFilterAbility)
@end

NS_ASSUME_NONNULL_END
