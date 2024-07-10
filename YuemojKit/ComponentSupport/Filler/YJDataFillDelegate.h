//
//  YJDataFillDelegate.h
//  YuemojKit
//
//  Created by Yuemoj on 2021/12/13.
//

#import <Foundation/Foundation.h>
#import "YuemojCoreTypes.h"
#import "YJDataFillTypes.h"

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
@property (nonatomic, getter=isOn) BOOL on;
@property (nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;

@end
NS_ASSUME_NONNULL_END
