//
//  Yuemoj.h
//  YuemojKit
//
//  Created by Yuemoj on 2023/2/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Yuemoj<ObjectType> : NSObject
@property (nonatomic, weak) ObjectType owner;

+ (instancetype)yjWithOwner:(ObjectType)owner;
- (instancetype)initWithOwner:(ObjectType)owner;

@end

NS_ASSUME_NONNULL_END

