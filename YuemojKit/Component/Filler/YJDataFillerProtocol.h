//
//  YJDataFillerProtocol.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIControl.h>
//#import "YuemojCoreTypes.h"
#import "YuemojMacros.h"
#import "YJDataFillTypes.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YJDataFillTextDataSource, YJDataFillFontDataSource, YJDataFillColorDataSource, YJDataFillImageDataSource, YJDataFillPoNDataSource, YJComponentDataSource;
@protocol YJDataFillerProtocol <NSObject>
#pragma mark- Text
/// MARK: fillText
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillText)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSNumber * _Nullable scene, ...);
/// MARK: fillTextInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextInSection)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSInteger, NSNumber * _Nullable scene, ...);
/// MARK: fillTextAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAtIndexPath)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSIndexPath *, NSNumber * _Nullable scene, ...);

/// MARK: fillTextForState
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextForState)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, UIControlState, NSNumber * _Nullable scene, ...);
/// MARK: fillTextForStateInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextForStateInSection)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSInteger, UIControlState, NSNumber * _Nullable scene, ...);
/// MARK: fillTextForStateAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextForStateAtIndexPath)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSIndexPath *, UIControlState, NSNumber * _Nullable scene, ...);
/// MARK: fillTextAsync
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAsync)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSNumber * _Nullable scene, ...);

/// MARK: fillTextAttribute
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAttribute)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSNumber * _Nullable scene, ...);
/// MARK: fillTextAttributeInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAttributeInSection)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSInteger, NSNumber * _Nullable scene, ...);
/// MARK: fillTextAttributeAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAttributeAtIndexPath)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSIndexPath *, NSNumber * _Nullable scene, ...);

/// MARK: fillTextAttributeForState
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAttributeForState)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, UIControlState, NSNumber * _Nullable scene, ...);
/// MARK: fillTextAttributeForStateInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAttributeForStateInSection)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSInteger, UIControlState, NSNumber * _Nullable scene, ...);
/// MARK: fillTextAttributeForStateAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAttributeForStateAtIndexPath)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSIndexPath *, UIControlState, NSNumber * _Nullable scene, ...);

#pragma mark- Font
/// MARK: fillFont
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillFont)(id<YJDataFillFontDataSource, YJComponentDataSource> dataSource, NSNumber * _Nullable scene, ...);
/// MARK: fillFontInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillFontInSection)(id<YJDataFillFontDataSource, YJComponentDataSource> dataSource, NSInteger, NSNumber * _Nullable scene, ...);
/// MARK: fillFontAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillFontAtIndexPath)(id<YJDataFillFontDataSource, YJComponentDataSource> dataSource, NSIndexPath *, NSNumber * _Nullable scene, ...);

#pragma mark- Color
/// MARK: fillColor
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillColor)(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, NSNumber * _Nullable scene, ...);
/// MARK: fillColorInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillColorInSection)(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, NSInteger, NSNumber * _Nullable scene, ...);
/// MARK: fillColorAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillColorAtIndexPath)(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, NSIndexPath *, NSNumber * _Nullable scene, ...);
/// color for state
/// MARK: fillColorForState
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillColorForState)(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, UIControlState, NSNumber * _Nullable scene, ...);
/// MARK: fillColorForStateInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillColorForStateInSection)(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, UIControlState, NSInteger, NSNumber * _Nullable scene, ...);
/// MARK: fillColorForStateAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillColorForStateAtIndexPath)(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, UIControlState, NSIndexPath *, NSNumber * _Nullable scene, ...);

#pragma mark- Image
/// MARK: fillImageName
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageName)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, NSNumber * _Nullable scene, ...);
/// MARK: fillImageNameInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageNameInSection)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, NSInteger, NSNumber * _Nullable scene, ...);
/// MARK: fillImageNameAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageNameAtIndexPath)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, NSIndexPath *, NSNumber * _Nullable scene, ...);

/// MARK: fillImageNameForState
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageNameForState)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, UIControlState, NSNumber * _Nullable scene, ...);
/// MARK: fillImageNameForStateInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageNameForStateInSection)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, UIControlState, NSInteger, NSNumber * _Nullable scene, ...);
/// MARK: fillImageNameForStateAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageNameForStateAtIndexPath)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, UIControlState, NSIndexPath *, NSNumber * _Nullable scene, ...);

/// MARK: fillImage
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImage)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, NSNumber * _Nullable scene, ...);
/// MARK: fillImageInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageInSection)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, NSInteger, NSNumber * _Nullable scene, ...);
/// MARK: fillImageAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageAtIndexPath)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, NSIndexPath *, NSNumber * _Nullable scene, ...);

/// MARK: fillImageForState
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageForState)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, UIControlState, NSNumber * _Nullable scene, ...);
/// MARK: fillImageForStateInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageForStateInSection)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, UIControlState, NSInteger, NSNumber * _Nullable scene, ...);
/// MARK: fillImageForStateAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageForStateAtIndexPath)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, UIControlState, NSIndexPath *, NSNumber * _Nullable scene, ...);

#pragma mark PoN
/// MARK: fillPoN
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillPoN)(id<YJDataFillPoNDataSource, YJComponentDataSource>, YJPoNPurpose, NSNumber * _Nullable scene, ...);
/// MARK: fillPoNInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillPoNInSection)(id<YJDataFillPoNDataSource, YJComponentDataSource>, YJPoNPurpose, NSInteger, NSNumber * _Nullable scene, ...);
/// MARK: fillPoNAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillPoNAtIndexPath)(id<YJDataFillPoNDataSource, YJComponentDataSource>, NSIndexPath *, YJPoNPurpose, NSNumber * _Nullable scene, ...);

@end

@protocol YJDataFillAbility <NSObject>
@property (nonatomic, copy, readonly) void(^fillComponent)(void(NS_NOESCAPE^)(id<YJDataFillerProtocol> filler));
@end

@YJNamespaceInstanceDeclaration(UIView, NSObject, yj_dataFill, YJDataFillAbility)
@end

NS_ASSUME_NONNULL_END
