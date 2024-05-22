//
//  YJDataFillDelegate.h
//  YuemojKit
//
//  Created by Yuemoj on 2021/12/13.
//  Copyright © 2021 hytera. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// @abstract
/// 用于view中根据scene填充控件内容时所用
@protocol YJDataFillTextDelegate <NSObject>
@optional
/// Label text/attribute
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withText:(NSString *)aString forPurpose:(YJTextPurpose)purpose;
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withAttributedText:(NSAttributedString *)anAttributeString forPurpose:(YJTextPurpose)purpose;
/// Button text/attribute
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withText:(NSString *)aString forPurpose:(YJTextPurpose)purpose state:(UIControlState)state;
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withAttributeText:(NSAttributedString *)anAttributeString forPurpose:(YJTextPurpose)purpose state:(UIControlState)state;
@end

@protocol YJDataFillFontDelegate <NSObject>
@optional
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withFont:(UIFont *)font;
@end

@protocol YJDataFillColorDelegate <NSObject>
@optional
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withColor:(UIColor *)aColor forPurpose:(YJColorPurpose)purpose;

- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withColor:(UIColor *)aColor forPurpose:(YJColorPurpose)purpose state:(UIControlState)state ;
@end

@protocol YJDataFillImageDelegate <NSObject>
@optional
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withImageName:(NSString *)anImageName forPurpose:(YJImagePurpose)purpose;
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withImageName:(NSString *)anImageName forPurpose:(YJImagePurpose)purpose state:(UIControlState)state;
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withImage:(UIImage *)anImage forPurpose:(YJImagePurpose)purpose;
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withImage:(UIImage *)anImage forPurpose:(YJImagePurpose)purpose state:(UIControlState)state;
@end

@protocol YJDataFillPoNDelegate <NSObject>
@optional
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withPoN:(BOOL)pon forPurpose:(YJPoNPurpose)purpose;
@end

@protocol YJDataFillDelegate<YJDataFillTextDelegate, YJDataFillFontDelegate, YJDataFillColorDelegate, YJDataFillImageDelegate, YJDataFillPoNDelegate>
@end

#pragma mark- SubDelegate
/// 用于自定义控件的数据填充, 递归?
//@protocol YJDataFillTextSubDelegate <NSObject>
//@optional
///// Label text/attribute
//- (void)fillWithTextDataSource:(id<YJDataFillTextDataSource>)dataSource forPurpose:(YJTextPurpose)purpose;
//- (void)fillWithAttributeTextDataSource:(id<YJDataFillTextDataSource>)dataSource forPurpose:(YJTextPurpose)purpose;
///// Button text/attribute
//- (void)fillWithTextDataSource:(id<YJDataFillTextDataSource>)dataSource forPurpose:(YJTextPurpose)purpose state:(UIControlState)state;
//- (void)fillWithAttributeTextDataSource:(id<YJDataFillTextDataSource>)dataSource forPurpose:(YJTextPurpose)purpose state:(UIControlState)state;
//@end
//
//@protocol YJDataFillFontSubDelegate <NSObject>
//@optional
//- (void)fillWithFontDataSource:(id<YJDataFillFontDataSource>)dataSource;
//@end
//
//@protocol YJDataFillColorSubDelegate <NSObject>
//@optional
//- (void)fillWithColorDataSource:(id<YJDataFillColorDataSource>)dataSource forPurpose:(YJColorPurpose)purpose;
//
//- (void)fillWithColorDataSource:(id<YJDataFillColorDataSource>)dataSource forPurpose:(YJColorPurpose)purpose state:(UIControlState)state ;
//@end
//
//@protocol YJDataFillImageSubDelegate <NSObject>
//@optional
//- (void)fillWithImageNameDataSource:(id<YJDataFillImageDataSource>)dataSource forPurpose:(YJImagePurpose)purpose;
//- (void)fillWithImageNameDataSource:(id<YJDataFillImageDataSource>)dataSource forPurpose:(YJImagePurpose)purpose state:(UIControlState)state;
//- (void)fillWithImageDataSource:(id<YJDataFillImageDataSource>)dataSource forPurpose:(YJImagePurpose)purpose;
//- (void)fillWithImageDataSource:(id<YJDataFillImageDataSource>)dataSource forPurpose:(YJImagePurpose)purpose state:(UIControlState)state;
//@end
//
//@protocol YJDataFillPoNSubDelegate <NSObject>
//@optional
//- (void)fillWithPoNDataSource:(id<YJDataFillImageDataSource>)dataSource forPurpose:(YJPoNPurpose)purpose;
//@end

#pragma mark- Assginment
@protocol YJDataFillTextAssignment <NSObject>
@optional
@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *placeholder;

@property (nullable, nonatomic, copy) NSAttributedString *attributedText;
@property (nullable, nonatomic, copy) NSAttributedString *attributedPlaceholder;

- (void)setTitle:(nullable NSString *)title forState:(UIControlState)state;
- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(UIControlState)state;

@end

@protocol YJDataFillFontAssignment <NSObject>
@optional
@property (nonatomic) UIFont *font;

@end

@protocol YJDataFillColorAssignment <NSObject>
@optional
@property (nonatomic) UIColor *textColor;
@property (nonatomic) UIColor *backgroundColor;
- (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state;
@end

@protocol YJDataFillImageAssignment <NSObject>
@optional
@property (nonatomic) UIImage *image;
@property (nonatomic) UIImage *backgroundImage;

- (void)setImage:(nullable UIImage *)image forState:(UIControlState)state;  
- (void)setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state;
@end

@protocol YJDataFillPoNAssignment <NSObject>
@optional
@property (nonatomic, getter=isHidden) BOOL hidden;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic, getter=isSelected) BOOL selected;

@end
NS_ASSUME_NONNULL_END
