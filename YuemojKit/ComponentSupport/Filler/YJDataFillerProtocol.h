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
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillText)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSNumber * _Nullable firstScene, ...);
/// MARK: fillTextInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextInSection)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSInteger, NSNumber * _Nullable firstScene, ...);
/// MARK: fillTextAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAtIndexPath)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSIndexPath *, NSNumber * _Nullable firstScene, ...);

/// MARK: fillTextForState
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextForState)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, UIControlState, NSNumber * _Nullable firstScene, ...);
/// MARK: fillTextForStateInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextForStateInSection)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSInteger, UIControlState, NSNumber * _Nullable firstScene, ...);
/// MARK: fillTextForStateAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextForStateAtIndexPath)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSIndexPath *, UIControlState, NSNumber * _Nullable firstScene, ...);
/// MARK: fillTextAsync
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAsync)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSNumber * _Nullable firstScene, ...);

/// MARK: fillTextAttribute
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAttribute)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSNumber * _Nullable firstScene, ...);
/// MARK: fillTextAttributeInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAttributeInSection)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSInteger, NSNumber * _Nullable firstScene, ...);
/// MARK: fillTextAttributeAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAttributeAtIndexPath)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSIndexPath *, NSNumber * _Nullable firstScene, ...);

/// MARK: fillTextAttributeForState
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAttributeForState)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, UIControlState, NSNumber * _Nullable firstScene, ...);
/// MARK: fillTextAttributeForStateInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAttributeForStateInSection)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSInteger, UIControlState, NSNumber * _Nullable firstScene, ...);
/// MARK: fillTextAttributeForStateAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillTextAttributeForStateAtIndexPath)(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose, NSIndexPath *, UIControlState, NSNumber * _Nullable firstScene, ...);

#pragma mark- Font
/// MARK: fillFont
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillFont)(id<YJDataFillFontDataSource, YJComponentDataSource> dataSource, NSNumber * _Nullable firstScene, ...);
/// MARK: fillFontInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillFontInSection)(id<YJDataFillFontDataSource, YJComponentDataSource> dataSource, NSInteger, NSNumber * _Nullable firstScene, ...);
/// MARK: fillFontAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillFontAtIndexPath)(id<YJDataFillFontDataSource, YJComponentDataSource> dataSource, NSIndexPath *, NSNumber * _Nullable firstScene, ...);

#pragma mark- Color
/// MARK: fillColor
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillColor)(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, NSNumber * _Nullable firstScene, ...);
/// MARK: fillColorInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillColorInSection)(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, NSInteger, NSNumber * _Nullable firstScene, ...);
/// MARK: fillColorAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillColorAtIndexPath)(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, NSIndexPath *, NSNumber * _Nullable firstScene, ...);
/// color for state
/// MARK: fillColorForState
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillColorForState)(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, UIControlState, NSNumber * _Nullable firstScene, ...);
/// MARK: fillColorForStateInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillColorForStateInSection)(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, UIControlState, NSInteger, NSNumber * _Nullable firstScene, ...);
/// MARK: fillColorForStateAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillColorForStateAtIndexPath)(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, UIControlState, NSIndexPath *, NSNumber * _Nullable firstScene, ...);

#pragma mark- Image
/// MARK: fillImageName
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageName)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, NSNumber * _Nullable firstScene, ...);
/// MARK: fillImageNameInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageNameInSection)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, NSInteger, NSNumber * _Nullable firstScene, ...);
/// MARK: fillImageNameAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageNameAtIndexPath)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, NSIndexPath *, NSNumber * _Nullable firstScene, ...);

/// MARK: fillImageNameForState
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageNameForState)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, UIControlState, NSNumber * _Nullable firstScene, ...);
/// MARK: fillImageNameForStateInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageNameForStateInSection)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, UIControlState, NSInteger, NSNumber * _Nullable firstScene, ...);
/// MARK: fillImageNameForStateAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageNameForStateAtIndexPath)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, UIControlState, NSIndexPath *, NSNumber * _Nullable firstScene, ...);

/// MARK: fillImage
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImage)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, NSNumber * _Nullable firstScene, ...);
/// MARK: fillImageInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageInSection)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, NSInteger, NSNumber * _Nullable firstScene, ...);
/// MARK: fillImageAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageAtIndexPath)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, NSIndexPath *, NSNumber * _Nullable firstScene, ...);

/// MARK: fillImageForState
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageForState)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, UIControlState, NSNumber * _Nullable firstScene, ...);
/// MARK: fillImageForStateInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageForStateInSection)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, UIControlState, NSInteger, NSNumber * _Nullable firstScene, ...);
/// MARK: fillImageForStateAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillImageForStateAtIndexPath)(id<YJDataFillImageDataSource, YJComponentDataSource> dataSource, YJImagePurpose purpose, UIControlState, NSIndexPath *, NSNumber * _Nullable firstScene, ...);

#pragma mark PoN
/// MARK: fillPoN
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillPoN)(id<YJDataFillPoNDataSource, YJComponentDataSource>, YJPoNPurpose, NSNumber * _Nullable firstScene, ...);
/// MARK: fillPoNInSection
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillPoNInSection)(id<YJDataFillPoNDataSource, YJComponentDataSource>, YJPoNPurpose, NSInteger, NSNumber * _Nullable firstScene, ...);
/// MARK: fillPoNAtIndexPath
@property (nonatomic, readonly, copy) id<YJDataFillerProtocol>(^fillPoNAtIndexPath)(id<YJDataFillPoNDataSource, YJComponentDataSource>, YJPoNPurpose, NSIndexPath *, NSNumber * _Nullable firstScene, ...);

@end

@protocol YJDataFillAbility <NSObject>
@property (nonatomic, copy, readonly) void(^fillComponent)(void(NS_NOESCAPE^)(id<YJDataFillerProtocol> filler));
@end

@YJNamespaceInstanceDeclaration(UIView, NSObject, yj_dataFill, YJDataFillAbility)
@end

NS_ASSUME_NONNULL_END
