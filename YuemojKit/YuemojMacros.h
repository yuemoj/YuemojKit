//
//  YuemojMacros.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/4/28.
//

#ifndef YuemojMacros_h
#define YuemojMacros_h

#import "YuemojMetamacros.h"
#import <objc/runtime.h>

/// class + instance declaration
#define YJNamespaceDeclarationCI(OwnerClass, OwnerConformProtocol, NamespaceObj, YJClassProtocol, YJInstanceProtocol)\
YJNamespaceClassDeclaration(OwnerClass, NamespaceObj, YJClassProtocol) @end\
@YJNamespaceInstanceDeclaration(OwnerClass, OwnerConformProtocol, NamespaceObj, YJInstanceProtocol)

/// class + instance implementation
#define YJNamespaceImplementationCI(OwnerClass, NamespaceClass, NamespaceObj, YJClassProtocol, YJInstanceProtocol)\
YJNamespaceClassImplementation(OwnerClass, NamespaceClass, NamespaceObj, YJClassProtocol) @end\
@YJNamespaceInstanceImplementation(OwnerClass, NamespaceClass, NamespaceObj, YJInstanceProtocol)

/// class declaration
#define YJNamespaceClassDeclaration(OwnerClass, NamespaceObj, ...)\
YJNamespaceClassDeclarationA(OwnerClass, NamespaceObj, metamacro_foreach_concat(Yuemoj,_,__VA_ARGS__), __VA_ARGS__)

#define YJNamespaceClassDeclarationA(OwnerClass, NamespaceObj, CatagoryName, YJProtocol...)\
interface OwnerClass (CatagoryName) \
@property (nonatomic, readonly, class) id<YJProtocol> NamespaceObj;

/// class implementation
#define YJNamespaceClassImplementation(OwnerClass, NamespaceClass, NamespaceObj, ...)\
YJNamespaceClassImplementationA(OwnerClass, NamespaceClass, NamespaceObj, metamacro_foreach_concat(Yuemoj,_,__VA_ARGS__), __VA_ARGS__)

#define YJNamespaceClassImplementationA(OwnerClass, NamespaceClass, NamespaceObj, CatagoryName, YJProtocol...)\
implementation OwnerClass (CatagoryName)\
+ (id<YJProtocol>)NamespaceObj {\
    void *kYJNamespaceKey = metamacro_stringify(CatagoryName);\
    NamespaceClass<YJProtocol> *obj = objc_getAssociatedObject(self, kYJNamespaceKey);\
    if (!obj) {\
        obj = [NamespaceClass<YJProtocol> new];\
        objc_setAssociatedObject(self, kYJNamespaceKey, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
    }\
    return obj;\
}

/// instance declaration
#define YJNamespaceInstanceDeclaration(OwnerClass, OwnerConformProtocol, NamespaceObj, ...)\
YJNamespaceInstanceDeclarationA(OwnerClass, OwnerConformProtocol, NamespaceObj, metamacro_foreach_concat_j(,,__VA_ARGS__), __VA_ARGS__)

#define YJNamespaceInstanceDeclarationA(OwnerClass, OwnerConformProtocol, NamespaceObj, CatagoryName, YJProtocol...)\
interface OwnerClass (CatagoryName)<OwnerConformProtocol> \
@property (nonatomic, readonly) id<YJProtocol> NamespaceObj;

/// instance implementation
#define YJNamespaceInstanceImplementation(OwnerClass, NamespaceClass, NamespaceObj, ...)\
YJNamespaceInstanceImplementationA(OwnerClass, NamespaceClass, NamespaceObj, metamacro_foreach_concat_j(,,__VA_ARGS__), __VA_ARGS__)

#define YJNamespaceInstanceImplementationA(OwnerClass, NamespaceClass, NamespaceObj, CatagoryName, YJProtocol...)\
implementation OwnerClass (CatagoryName)\
- (id<YJProtocol>)NamespaceObj {\
    void *kYJNamespaceKey = metamacro_stringify(CatagoryName);\
    NamespaceClass<YJProtocol> *obj = objc_getAssociatedObject(self, kYJNamespaceKey);\
    if (!obj) {\
        obj = [NamespaceClass<YJProtocol> yjWithOwner:self];\
        objc_setAssociatedObject(self, kYJNamespaceKey, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
    }\
    return obj;\
}

#endif /* YuemojMacros_h */


#ifndef YJLog
#define YJLog(format, ...) NSLog(@"%@", [NSString stringWithFormat:@"<%@ %s:(%d)>\n\t%@\n", NSThread.currentThread, __FUNCTION__, __LINE__ , [NSString stringWithFormat:(format), ##__VA_ARGS__]]);
#endif

#ifndef YJProtocolAssert
#define YJProtocolAssert(object, protocol) NSAssert([object conformsToProtocol:protocol], @"%@ should conforms to protocol '%@'", [object class], NSStringFromProtocol(protocol))
#endif

#ifndef YJSelectorAssert
#define YJSelectorAssert(object, aSelector) NSAssert([object respondsToSelector:aSelector], @"%@ should responds to selector '%@'", [object class], NSStringFromSelector(aSelector))
#endif
