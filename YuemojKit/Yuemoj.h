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

//static void * _Nonnull kYuemojNamespaceKey = &kYuemojNamespaceKey;

NS_ASSUME_NONNULL_END

//#import <objc/runtime.h>
//NS_ASSUME_NONNULL_BEGIN
//#define YJClassInterfaceCategory(ClassName)\
//FOUNDATION_EXTERN @interface ClassName (Yuemoj) \
//@property (nonatomic, readonly) Yuemoj *yj; \
//@end
//
//#define YJClassImplementationCategory(ClassName)\
//implementation ClassName (Yuemoj)\
//- (Yuemoj *)yj {\
//    Yuemoj *obj = objc_getAssociatedObject(self, kYuemojNamespaceKey);\
//    if (!obj) {\
//        obj = [Yuemoj yjWithOwner:self];\
//        objc_setAssociatedObject(self, kYuemojNamespaceKey, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
//    }\
//    return obj;\
//}\
//@end
//
//NS_ASSUME_NONNULL_END

#ifndef YJLog
#define YJLog(format, ...) NSLog(@"%@", [NSString stringWithFormat:@"<%@ %s:(%d)>\n\t%@\n", NSThread.currentThread, __FUNCTION__, __LINE__ , [NSString stringWithFormat:(format), ##__VA_ARGS__]]);
#endif
