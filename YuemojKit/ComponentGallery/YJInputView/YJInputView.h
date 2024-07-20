//
//  YJInputView.h
//  YuemojKit
//
//  Created by Yuemoj on 2023/4/14.
//

#import <UIKit/UIKit.h>
//#import "YJInputScene.h"

NS_ASSUME_NONNULL_BEGIN

//@protocol YJInputViewDelegate;//, YJComponentFillerDelegate, YJComponentEventBuilderDelegate;
@interface YJInputView : UIView<UITextFieldDelegate>
//@property (nullable, nonatomic, readonly) id<YJComponentFillerDelegate, YJComponentEventBuilderDelegate>accessoryFiller;
//+ (instancetype)inputWithAccessory:(id<YJInputViewDelegate>)accessory;
//- (void)switchTextSecure;
//- (nullable NSString *)text;
@property (nonatomic, copy, nullable, readonly) NSString *text;
@property (nonatomic) UITextField *inputTextField;
//@property (nonatomic, nullable, readonly) __kindof UIView *rightView;
//@property (nonatomic) NSInteger inputTextFieldScene;
//@property (nonatomic) NSInteger rightViewScene;
@property (nonatomic) NSInteger bytesLimit;

@property (nonatomic, copy, nullable) BOOL(^shouldBeginEditing)(void);
@property (nonatomic, copy, nullable) BOOL(^shouldEndEditing)(void);
@property (nonatomic, copy, nullable) BOOL(^shouldReturn)(NSString *);
@property (nonatomic, copy, nullable) BOOL(^shouldChange)(NSString *);
@property (nonatomic, copy, nullable) void(^didChange)(NSString *);

//+ (UITextField *)generalCommonTextField:(BOOL)isScureEntry replaceClearBtn:(nullable UIImage *)clearImage;
//- (BOOL)becomeFirstResponder;
@end

//@protocol YJInputViewDelegate <NSObject>
//@optional
//@property (nonatomic, readonly) NSInteger characterCountLimit;
//@property (nonatomic, readonly) BOOL supportsSecureInput;
//@property (nonatomic, readonly) BOOL shouldDisplayClearButton;
//@property (nonatomic, readonly) UIKeyboardType keyboardType;
//@property (nonatomic, readonly) UIReturnKeyType returnKeyType;
//@property (nonatomic, readonly, nullable) __kindof UIView *leftView;
//@property (nonatomic, readonly, nullable) __kindof UIView *rightView;
//@property (nonatomic, readonly, nullable) UIImage *backgroundImage;
//@property (nonatomic, readonly, nullable) UIColor *backgroundColor;
//@property (nonatomic, readonly) CGFloat cornerRadius;
//@property (nonatomic, readonly) UIEdgeInsets inputEdges;
//@end
NS_ASSUME_NONNULL_END

//#import "YJComponentFiller.h"
//#import "YJComponentFillerAbilities.h"
//NS_ASSUME_NONNULL_BEGIN
//@interface YJInputView ()
//@property (nonatomic) YJComponentFiller *dataFiller;
//@end
//@interface YJInputView (Filler)<YJComponentFillerDelegate, YJComponentFillerTextAbility>
//@end
//NS_ASSUME_NONNULL_END

