//
//  YuemojKit.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/4/28.
//

#import <Foundation/Foundation.h>

#ifndef __YuemojKit__
#define __YuemojKit__
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
#import <YuemojKit/UIKit+Yuemoj.h>
#import <YuemojKit/YuemojUIAbilities.h>
#import <YuemojKit/YJDataFillDataSource.h>
#import <YuemojKit/YJDataFillerProtocol.h>
#import <YuemojKit/YJDataFillTypes.h>
#import <YuemojKit/YJEventBuilderProtocol.h>
#import <YuemojKit/YJLayouterProtocol.h>
#import <YuemojKit/YJLayoutModels.h>
#import <YuemojKit/YJDataSource.h>
#import <YuemojKit/YJGroupModel.h>
#import <YuemojKit/YJOrderJSON.h>
#import <YuemojKit/YJBoundedBuffer.h>

#else

#import "Yuemoj.h"
#import "YuemojCoreTypes.h"
#import "YuemojMacros.h"
#import "Foundation+Yuemoj.h"
#import "YuemojFoundationAbilities.h"
#import "UIKit+Yuemoj.h"
#import "YuemojUIAbilities.h"
#import "YJDataFillDataSource.h"
#import "YJDataFillerProtocol.h"
#import "YJDataFillTypes.h"
#import "YJEventBuilderProtocol.h"
#import "YJLayouterProtocol.h"
#import "YJLayoutModels.h"
#import "YJDataSource.h"
#import "YJGroupModel.h"
#import "YJOrderJSON.h"
#import "YJBoundedBuffer.h"

#endif __has_include
#endif __YuemojKit__
