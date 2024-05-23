//
//  YJDataFillDataSource
//  YuemojKit
//
//  Created by Yuemoj on 2021/12/13.
//  Copyright © 2021 hytera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIControl.h>
#import "YJDataFillTypes.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YJDataFillTextDataSource <NSObject>
@optional
- (nullable NSString *)textForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose;
- (nullable NSString *)textForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose inSection:(NSInteger)section;
- (nullable NSString *)textForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose indexPath:(NSIndexPath *)indexPath;

- (nullable NSString *)textForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose state:(UIControlState)state;
- (nullable NSString *)textForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose state:(UIControlState)state inSection:(NSInteger)section;
- (nullable NSString *)textForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose state:(UIControlState)state indexPath:(NSIndexPath *)indexPath;

- (nullable NSAttributedString *)attributeTextForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose;
- (nullable NSAttributedString *)attributeTextForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose inSection:(NSInteger)section;
- (nullable NSAttributedString *)attributeTextForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose indexPath:(NSIndexPath *)indexPath;

- (nullable NSAttributedString *)attributeTextForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose state:(UIControlState)state;
- (nullable NSAttributedString *)attributeTextForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose state:(UIControlState)state inSection:(NSInteger)section;
- (nullable NSAttributedString *)attributeTextForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose state:(UIControlState)state indexPath:(NSIndexPath *)indexPath;

/// TODO:待补充实现image 和 attribute在 section 和indexPath下的方法
- (void)textForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose async:(void(^)(NSString * _Nullable))async;
@end

@protocol YJDataFillFontDataSource <NSObject>
@optional
- (nullable UIFont *)fontForScene:(NSInteger)scene;
- (nullable UIFont *)fontForScene:(NSInteger)scene inSection:(NSInteger)section;
- (nullable UIFont *)fontForScene:(NSInteger)scene indexPath:(NSIndexPath *)indexPath;
@end

@protocol YJDataFillColorDataSource <NSObject>
@optional
- (nullable UIColor *)colorForScene:(NSInteger)scene purpose:(YJColorPurpose)purpose;
- (nullable UIColor *)colorForScene:(NSInteger)scene purpose:(YJColorPurpose)purpose inSection:(NSInteger)section;
- (nullable UIColor *)colorForScene:(NSInteger)scene purpose:(YJColorPurpose)purpose indexPath:(NSIndexPath *)indexPath;

- (nullable UIColor *)colorForScene:(NSInteger)scene purpose:(YJColorPurpose)purpose state:(UIControlState)state;
- (nullable UIColor *)colorForScene:(NSInteger)scene purpose:(YJColorPurpose)purpose state:(UIControlState)state inSection:(NSInteger)section;
- (nullable UIColor *)colorForScene:(NSInteger)scene purpose:(YJColorPurpose)purpose state:(UIControlState)state indexPath:(NSIndexPath *)indexPath;
@end

@protocol YJDataFillImageDataSource <NSObject>
@optional

- (nullable NSString *)imageNameForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose;
- (nullable NSString *)imageNameForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose inSection:(NSInteger)section;
- (nullable NSString *)imageNameForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose indexPath:(NSIndexPath *)indexPath;

- (nullable NSString *)imageNameForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose state:(UIControlState)state;
- (nullable NSString *)imageNameForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose state:(UIControlState)state inSection:(NSInteger)section;
- (nullable NSString *)imageNameForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose state:(UIControlState)state indexPath:(NSIndexPath *)indexPath;

- (nullable UIImage *)imageForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose;
- (nullable UIImage *)imageForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose inSection:(NSInteger)section;
- (nullable UIImage *)imageForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose indexPath:(NSIndexPath *)indexPath;

- (nullable UIImage *)imageForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose state:(UIControlState)state;
- (nullable UIImage *)imageForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose state:(UIControlState)state inSection:(NSInteger)section;
- (nullable UIImage *)imageForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose state:(UIControlState)state indexPath:(NSIndexPath *)indexPath;
@end

@protocol YJDataFillPoNDataSource <NSObject>
@optional
- (BOOL)ponForScene:(NSInteger)scene purpose:(YJPoNPurpose)purpose;
- (BOOL)ponForScene:(NSInteger)scene purpose:(YJPoNPurpose)purpose inSection:(NSInteger)section;
- (BOOL)ponForScene:(NSInteger)scene purpose:(YJPoNPurpose)purpose indexPath:(NSIndexPath *)indexPath;
@end

@protocol YJDataFillShouldUpdateDataSource <NSObject>
@optional
/** NOTE: cell复用的时候, 可能会有图像或者颜色不需要刷新的, 避免fill的时候 每次都要在fetcher中生成无效的image或color对象;
 *  默认文本可变, 字体不可变.
 */
- (BOOL)shouldUpdateTextForScene:(NSInteger)scene;  // 如不实现, 默认YES
- (BOOL)shouldUpdateTextForScene:(NSInteger)scene inSection:(NSInteger)section;  // 如不实现, 默认YES
- (BOOL)shouldUpdateTextForScene:(NSInteger)scene indexPath:(NSIndexPath *)indexPath;  // 如不实现, 默认YES

- (BOOL)shouldUpdateAttributeForScene:(NSInteger)scene; // 如不实现, 默认YES
- (BOOL)shouldUpdateAttributeForScene:(NSInteger)scene inSection:(NSInteger)section; // 如不实现, 默认YES
- (BOOL)shouldUpdateAttributeForScene:(NSInteger)scene indexPath:(NSIndexPath *)indexPath; // 如不实现, 默认YES

- (BOOL)shouldUpdateFontForScene:(NSInteger)scene;  // 如不实现, 默认 NO
- (BOOL)shouldUpdateFontForScene:(NSInteger)scene inSection:(NSInteger)section;  // 如不实现, 默认 NO
- (BOOL)shouldUpdateFontForScene:(NSInteger)scene indexPath:(NSIndexPath *)indexPath;  // 如不实现, 默认 NO

- (BOOL)shouldUpdateColorForScene:(NSInteger)scene; // 如不实现, 默认 NO
- (BOOL)shouldUpdateColorForScene:(NSInteger)scene inSection:(NSInteger)section; // 如不实现, 默认 NO
- (BOOL)shouldUpdateColorForScene:(NSInteger)scene indexPath:(NSIndexPath *)indexPath; // 如不实现, 默认 NO

- (BOOL)shouldUpdateImageForScene:(NSInteger)scene; // 如不实现, 默认 NO
- (BOOL)shouldUpdateImageForScene:(NSInteger)scene inSection:(NSInteger)section; // 如不实现, 默认 NO
- (BOOL)shouldUpdateImageForScene:(NSInteger)scene indexPath:(NSIndexPath *)indexPath; // 如不实现, 默认 NO

- (BOOL)shouldUpdatePon:(NSInteger)pon forScene:(NSInteger)scene; // 如不实现, 默认 YES
- (BOOL)shouldUpdatePon:(NSInteger)pon forScene:(NSInteger)scene inSection:(NSInteger)section; // 如不实现, 默认 YES
- (BOOL)shouldUpdatePon:(NSInteger)pon forScene:(NSInteger)scene indexPath:(NSIndexPath *)indexPath; // 如不实现, 默认 YES
@end

NS_ASSUME_NONNULL_END

