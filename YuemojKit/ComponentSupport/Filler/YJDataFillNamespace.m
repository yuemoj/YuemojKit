//
//  YJDataFillNamespace.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/6.
//

#import "YJDataFillNamespace.h"
#import "YJDataFiller.h"
#import "YJDataFillDelegate.h"

@interface YJDataFillNamespace ()<YJDataFillAbility>
@property (nonatomic) YJDataFiller *filler;
@end
@implementation YJDataFillNamespace
- (void (^)(__attribute__((noescape)) void (^ _Nonnull)(id<YJDataFillerProtocol> _Nonnull)))fillComponent {
    return ^(void(^fill)(id<YJDataFillerProtocol> filler)) {
        if (fill) fill(self.filler);
        [self.filler didFill];
    };
}

- (YJDataFiller *)filler {
    if (!_filler) _filler = [YJDataFiller fillerWithDelegate:(id<YJDataFillDelegate>)self];
    return _filler;
}

@end

#import "YJDataFillDelegate.h"
#import "UIKit+Yuemoj.h"
@import UIKit.UIImage;
@interface YJDataFillNamespace (DataFillDelegate)<YJDataFillDelegate>
@end
@implementation YJDataFillNamespace (DataFillDelegate)
/// Label text/attribute
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withText:(NSString *)aString forPurpose:(YJTextPurpose)purpose {
    if (!((UIView *)self.owner).yj_extra.viewForIdentifier) return;
    id<YJDataFillTextAssignment> component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    switch (purpose) {
        case YJTextPurposeText: {
            if ([component respondsToSelector:@selector(setText:)]) {
                component.text = aString;
            } else if ([component respondsToSelector:@selector(setTitle:)]) {
                component.title = aString;
            }
        } break;
        case YJTextPurposePlaceholder: {
            if ([component respondsToSelector:@selector(setPlaceholder:)]) {
                component.placeholder = aString;
            }
        } break;
        default: break;
    }
}

- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withAttributedText:(NSAttributedString *)anAttributedString forPurpose:(YJTextPurpose)purpose {
    if (!((UIView *)self.owner).yj_extra.viewForIdentifier) return;
    id<YJDataFillTextAssignment> component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    switch (purpose) {
        case YJTextPurposeText: {
            if ([component respondsToSelector:@selector(setAttributedText:)]) {
                component.attributedText = anAttributedString;
            }
        } break;
        case YJTextPurposePlaceholder: {
            if ([component respondsToSelector:@selector(setAttributedPlaceholder:)]) {
                component.attributedPlaceholder = anAttributedString;
            }
        } break;
        default: break;
    }
}

/// Button text/attribute
- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withText:(NSString *)aString forPurpose:(YJTextPurpose)purpose state:(UIControlState)state {
    if (!((UIView *)self.owner).yj_extra.viewForIdentifier) return;
    id<YJDataFillTextAssignment> component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    switch (purpose) {
        case YJTextPurposeText: {
            if ([component respondsToSelector:@selector(setTitle:forState:)]) {
                [component setTitle:aString forState:state];
            }
        } break;
        default: break;
    }
}

- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withAttributeText:(NSAttributedString *)anAttributeString forPurpose:(YJTextPurpose)purpose state:(UIControlState)state {
    if (!((UIView *)self.owner).yj_extra.viewForIdentifier) return;
    id<YJDataFillTextAssignment> component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    switch (purpose) {
        case YJTextPurposeText: {
            if ([component respondsToSelector:@selector(setAttributedTitle:forState:)]) {
                [component setAttributedTitle:anAttributeString forState:state];
            }
        } break;
        default: break;
    }
}

- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withFont:(UIFont *)font {
    if (!((UIView *)self.owner).yj_extra.viewForIdentifier) return;
    id<YJDataFillFontAssignment> component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    if ([component respondsToSelector:@selector(setFont:)]) {
        component.font = font;
    }
}

- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withColor:(UIColor *)aColor forPurpose:(YJColorPurpose)purpose {
    if (!((UIView *)self.owner).yj_extra.viewForIdentifier) return;
    id<YJDataFillColorAssignment> component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    switch (purpose) {
        case YJColorPurposeText: {
            if ([component respondsToSelector:@selector(setTextColor:)]) {
                component.textColor = aColor;
            }
        } break;
        case YJColorPurposeBackground: {
            if ([component respondsToSelector:@selector(setBackgroundColor:)]) {
                component.backgroundColor = aColor;
            }
        } break;
        default: break;
    }
}

- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withColor:(UIColor *)aColor forPurpose:(YJColorPurpose)purpose state:(UIControlState)state {
    if (!((UIView *)self.owner).yj_extra.viewForIdentifier) return;
    id<YJDataFillColorAssignment> component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    switch (purpose) {
        case YJColorPurposeText: {
            if ([component respondsToSelector:@selector(setTitleColor:forState:)]) {
                [component setTitleColor:aColor forState:state];
            }
        } break;
        case YJColorPurposeBackground: {
            if ([component respondsToSelector:@selector(setBackgroundColor:)]) {
                component.backgroundColor = aColor;
            }
        } break;
        default: break;
    }
}

- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withImageName:(NSString *)anImageName forPurpose:(YJImagePurpose)purpose {
    [self fillComponent:type scene:scene withImage:[UIImage imageNamed:anImageName] forPurpose:purpose];
}

- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withImageName:(NSString *)anImageName forPurpose:(YJImagePurpose)purpose state:(UIControlState)state {
    [self fillComponent:type scene:scene withImage:[UIImage imageNamed:anImageName] forPurpose:purpose state:state];
}

- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withImage:(UIImage *)anImage forPurpose:(YJImagePurpose)purpose {
    if (!((UIView *)self.owner).yj_extra.viewForIdentifier) return;
    id<YJDataFillImageAssignment> component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    switch (purpose) {
        case YJImagePurposeForeground: {
            if ([component respondsToSelector:@selector(setImage:)]) {
                component.image = anImage;
            }
        } break;
        case YJImagePurposeBackground: {
            if (([component respondsToSelector:@selector(setBackgroundImage:)])) {
                component.backgroundImage = anImage;
            }
        } break;
        default: break;
    }
}

- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withImage:(UIImage *)anImage forPurpose:(YJImagePurpose)purpose state:(UIControlState)state {
    if (!((UIView *)self.owner).yj_extra.viewForIdentifier) return;
    id<YJDataFillImageAssignment> component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    switch (purpose) {
        case YJImagePurposeForeground: {
            if ([component respondsToSelector:@selector(setImage:forState:)]) {
                [component setImage:anImage forState:state];
            }
        } break;
        case YJImagePurposeBackground: {
            if (([component respondsToSelector:@selector(setBackgroundImage:forState:)])) {
                [component setBackgroundImage:anImage forState:state];
            }
        } break;
        default: break;
    }
}

- (void)fillComponent:(YJComponentType)type scene:(NSInteger)scene withPoN:(BOOL)pon forPurpose:(YJPoNPurpose)purpose {
    if (!((UIView *)self.owner).yj_extra.viewForIdentifier) return;
    id<YJDataFillPoNAssignment> component = ((UIView *)self.owner).yj_extra.viewForIdentifier(type, scene);
    switch (purpose) {
        case YJPoNPurposeDisplay: {
            if ([component respondsToSelector:@selector(setHidden:)]) {
                component.hidden = !pon;
            }
            // other
        } break;
        case YJPoNPurposeEnabled: {
            if ([component respondsToSelector:@selector(setEnabled:)]) {
                component.enabled = pon;
            }
            // other
        } break;
        case YJPoNPurposeSelected: {
            if ([component respondsToSelector:@selector(setSelected:)]) {
                component.selected = pon;
            }
            // other
        } break;
        case YJPoNPurposeSecure: {
            if ([component respondsToSelector:@selector(setSecureTextEntry:)]) {
                component.secureTextEntry = pon;
            }
        } break;
        default: break;
    }
}

@end

@YJNamespaceInstanceImplementation(UIView, YJDataFillNamespace, yj_dataFill, YJDataFillAbility)

@end
