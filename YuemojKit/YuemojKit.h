//
//  YuemojKit.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/4/28.
//

#import <Foundation/Foundation.h>
#if __has_include(<YuemojKit/YuemojKit.h>)
//! Project version number for YuemojKit.
FOUNDATION_EXPORT double YuemojKitVersionNumber;

//! Project version string for YuemojKit.
FOUNDATION_EXPORT const unsigned char YuemojKitVersionString[];

#import <YuemojKit/Yuemoj.h>
#import <YuemojKit/YuemojCoreTypes.h>
#import <YuemojKit/YuemojMacros.h>
#import <YuemojKit/Foundation+Yuemoj.h>
#import <YuemojKit/YuemojFoundationAbilities.h>
#else
#import "Yuemoj.h"
#import "YuemojCoreTypes.h"
#import "YuemojMacros.h"
#import "Foundation+Yuemoj.h"
#import "YuemojFoundationAbilities.h"

#endif
