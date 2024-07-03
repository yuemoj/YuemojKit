//
//  YJComponentFiller.m
//  YuemojKit
//
//  Created by Yuemoj on 2021/12/13.
//

#import "YJDataFiller.h"
#import "YJDataFillDelegate.h"
#import "YJDataFillDataSource.h"
#import "YJComponentDataSource.h"
#import "YJComponentWrapper.h"

@interface YJDataFiller ()
@property (nonatomic, weak) id<YJDataFillDelegate> delegate;
@property (nonatomic, getter=isFilled) BOOL filled; // 记录是否已经加载过
@end

@implementation YJDataFiller
+ (instancetype)fillerWithDelegate:(id<YJDataFillDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

- (instancetype)initWithDelegate:(id<YJDataFillDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
}

- (void)didFill {
    self.filled = YES;
}

#pragma mark- Text Filler
- (id<YJDataFillerProtocol>  _Nonnull (^)(id<YJDataFillTextDataSource,YJComponentDataSource> _Nonnull, YJTextPurpose, NSNumber * _Nullable, ...))fillText {
    return ^(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose purpose, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(textForScene:purpose:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withText:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateTextForScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateTextForScene:nextScene];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            NSString *text = [dataSource textForScene:nextScene purpose:purpose];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate fillComponent:type scene:nextScene withText:text forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol>  _Nonnull (^)(id<YJDataFillTextDataSource,YJComponentDataSource> _Nonnull, YJTextPurpose purpose, NSInteger, NSNumber * _Nullable, ...))fillTextInSection {
    return ^(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose purpose, NSInteger section, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(textForScene:purpose:inSection:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withText:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateTextForScene:inSection:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateTextForScene:nextScene inSection:section];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            NSString *text = [dataSource textForScene:nextScene purpose:purpose inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene inSection:section];
            [self.delegate fillComponent:type scene:nextScene withText:text forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol>  _Nonnull (^)(id<YJDataFillTextDataSource,YJComponentDataSource> _Nonnull, YJTextPurpose purpose, NSIndexPath * _Nonnull, NSNumber * _Nullable, ...))fillTextAtIndexPath {
    return ^(id<YJDataFillTextDataSource,YJComponentDataSource> dataSource, YJTextPurpose purpose, NSIndexPath *indexPath, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(textForScene:purpose:indexPath:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withText:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateTextForScene:indexPath:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateTextForScene:nextScene indexPath:indexPath];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            NSString *text = [dataSource textForScene:nextScene purpose:purpose indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene indexPath:indexPath];
            [self.delegate fillComponent:type scene:nextScene withText:text forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillTextDataSource, YJComponentDataSource>, YJTextPurpose purpose, UIControlState, NSNumber * _Nullable, ...))fillTextForState {
    return ^(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose purpose, UIControlState state, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(textForScene:purpose:state:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withText:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateTextForScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateTextForScene:nextScene];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            NSString *text = [dataSource textForScene:nextScene purpose:purpose state:state];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate fillComponent:type scene:nextScene withText:text forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillTextDataSource, YJComponentDataSource> _Nonnull, YJTextPurpose purpose, NSInteger, UIControlState, NSNumber * _Nullable, ...))fillTextForStateInSection {
    return ^(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose purpose, NSInteger section, UIControlState state, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(textForScene:purpose:state:inSection:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withText:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateTextForScene:inSection:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateTextForScene:nextScene inSection:section];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            NSString *text = [dataSource textForScene:nextScene purpose:purpose state:state inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene inSection:section];
            if (type == YJComponentTypeCustom) {
                return;
            }
            [self.delegate fillComponent:type scene:nextScene withText:text forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillTextDataSource, YJComponentDataSource> _Nonnull, YJTextPurpose purpose, NSIndexPath * _Nonnull, UIControlState, NSNumber * _Nullable, ...))fillTextForStateAtIndexPath {
    return ^(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose purpose, NSIndexPath *indexPath, UIControlState state, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(textForScene:purpose:state:indexPath:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withText:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateTextForScene:indexPath:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateTextForScene:nextScene indexPath:indexPath];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            NSString *text = [dataSource textForScene:nextScene purpose:purpose state:state indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene indexPath:indexPath];
            [self.delegate fillComponent:type scene:nextScene withText:text forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}
/// MARK: attribute
- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillTextDataSource, YJComponentDataSource>, YJTextPurpose purpose, NSNumber * _Nullable, ...))fillTextAttribute {
    return ^(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose purpose, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(attributeTextForScene:purpose:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withAttributedText:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateAttributeForScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateAttributeForScene:nextScene];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            NSAttributedString *attributeString = [dataSource attributeTextForScene:nextScene purpose:purpose];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate fillComponent:type scene:nextScene withAttributedText:attributeString forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillTextDataSource, YJComponentDataSource> _Nonnull, YJTextPurpose purpose, NSInteger, NSNumber * _Nullable, ...))fillTextAttributeInSection {
    return ^(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose purpose, NSInteger section, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(attributeTextForScene:purpose:inSection:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withAttributedText:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateAttributeForScene:inSection:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateAttributeForScene:nextScene inSection:section];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            NSAttributedString *attributeString = [dataSource attributeTextForScene:nextScene purpose:purpose inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene inSection:section];
            [self.delegate fillComponent:type scene:nextScene withAttributedText:attributeString forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillTextDataSource, YJComponentDataSource> _Nonnull, YJTextPurpose purpose, NSIndexPath * _Nonnull, NSNumber * _Nullable, ...))fillTextAttributeAtIndexPath {
    return ^(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose purpose, NSIndexPath *indexPath, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(attributeTextForScene:purpose:indexPath:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withAttributedText:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateAttributeForScene:indexPath:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateAttributeForScene:nextScene indexPath:indexPath];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            NSAttributedString *attributeString = [dataSource attributeTextForScene:nextScene purpose:purpose indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene indexPath:indexPath];
            [self.delegate fillComponent:type scene:nextScene withAttributedText:attributeString forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillTextDataSource, YJComponentDataSource>, YJTextPurpose purpose, UIControlState, NSNumber * _Nullable, ...))fillTextAttributeForState {
    return ^(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose purpose, UIControlState state, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(attributeTextForScene:purpose:state:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withAttributeText:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateAttributeForScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateAttributeForScene:nextScene];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            NSAttributedString *attributeString = [dataSource attributeTextForScene:nextScene purpose:purpose state:state];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate fillComponent:type scene:nextScene withAttributeText:attributeString forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillTextDataSource, YJComponentDataSource> _Nonnull, YJTextPurpose,  NSInteger, UIControlState, NSNumber * _Nullable, ...))fillTextAttributeForStateInSection {
    return ^(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose purpose, NSInteger section, UIControlState state, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(attributeTextForScene:purpose:state:inSection:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withAttributeText:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateAttributeForScene:inSection:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateAttributeForScene:nextScene inSection:section];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            NSAttributedString *attributeString = [dataSource attributeTextForScene:nextScene purpose:purpose state:state inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene inSection:section];
            [self.delegate fillComponent:type scene:nextScene withAttributeText:attributeString forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillTextDataSource, YJComponentDataSource> _Nonnull, YJTextPurpose, NSIndexPath * _Nonnull, UIControlState, NSNumber * _Nullable, ...))fillTextAttributeForStateAtIndexPath {
    return ^(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose purpose, NSIndexPath *indexPath, UIControlState state, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(attributeTextForScene:purpose:state:indexPath:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withAttributeText:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateAttributeForScene:indexPath:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateAttributeForScene:nextScene indexPath:indexPath];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            NSAttributedString *attributeString = [dataSource attributeTextForScene:nextScene purpose:purpose state:state indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene indexPath:indexPath];
            [self.delegate fillComponent:type scene:nextScene withAttributeText:attributeString forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

/// MARK: text async
- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillTextDataSource, YJComponentDataSource> _Nonnull, YJTextPurpose, NSNumber * _Nullable, ...))fillTextAsync {
    return ^(id<YJDataFillTextDataSource, YJComponentDataSource> dataSource, YJTextPurpose purpose, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillTextDataSource));
        YJSelectorAssert(dataSource, @selector(textForScene:purpose:async:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillTextDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withText:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateTextForScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateTextForScene:nextScene];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            [dataSource textForScene:nextScene purpose:purpose async:^(NSString * _Nonnull text) {
                YJComponentType type = [dataSource componentTypeForScene:nextScene];
                if (type == YJComponentTypeCustom) return;
                [self.delegate fillComponent:type scene:nextScene withText:text forPurpose:purpose];
            }];
        };
        
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

#pragma mark - Font Filler
- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillFontDataSource, YJComponentDataSource>, NSNumber * _Nullable, ...))fillFont {
    return ^(id<YJDataFillFontDataSource, YJComponentDataSource> dataSource, NSNumber * _Nullable firstScene, ...) {
        // 不遵循协议 或者不实现dataSource的方法 --> 使用component初始化的默认值
        if (![dataSource conformsToProtocol:@protocol(YJDataFillFontDataSource)] || ![dataSource respondsToSelector:@selector(fontForScene:)])
            return self;
        YJProtocolAssert(dataSource, @protocol(YJDataFillFontDataSource));
        YJSelectorAssert(dataSource, @selector(fontForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillFontDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withFont:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateFontForScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateFontForScene:nextScene];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            UIFont *font = [dataSource fontForScene:nextScene];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate fillComponent:type scene:nextScene withFont:font];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillFontDataSource, YJComponentDataSource> _Nonnull, NSInteger, NSNumber * _Nullable, ...))fillFontInSection {
    return ^(id<YJDataFillFontDataSource, YJComponentDataSource> dataSource, NSInteger section, NSNumber * _Nullable firstScene, ...) {
        // 不遵循协议 或者不实现dataSource的方法 --> 使用component初始化的默认值
        if (![dataSource conformsToProtocol:@protocol(YJDataFillFontDataSource)] || ![dataSource respondsToSelector:@selector(fontForScene:inSection:)])
            return self;
        YJProtocolAssert(dataSource, @protocol(YJDataFillFontDataSource));
        YJSelectorAssert(dataSource, @selector(fontForScene:inSection:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillFontDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withFont:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateFontForScene:inSection:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateFontForScene:nextScene inSection:section];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            UIFont *font = [dataSource fontForScene:nextScene inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene inSection:section];
            [self.delegate fillComponent:type scene:nextScene withFont:font];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillFontDataSource, YJComponentDataSource> _Nonnull, NSIndexPath * _Nonnull, NSNumber * _Nullable, ...))fillFontAtIndexPath {
    return ^(id<YJDataFillFontDataSource, YJComponentDataSource> dataSource, NSIndexPath *indexPath, NSNumber * _Nullable firstScene, ...) {
        // 不遵循协议 或者不实现dataSource的方法 --> 使用component初始化的默认值
        if (![dataSource conformsToProtocol:@protocol(YJDataFillFontDataSource)] || ![dataSource respondsToSelector:@selector(fontForScene:indexPath:)])
            return self;
        YJProtocolAssert(dataSource, @protocol(YJDataFillFontDataSource));
        YJSelectorAssert(dataSource, @selector(fontForScene:indexPath:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillFontDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withFont:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateFontForScene:indexPath:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateFontForScene:nextScene indexPath:indexPath];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            UIFont *font = [dataSource fontForScene:nextScene indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene indexPath:indexPath];
            [self.delegate fillComponent:type scene:nextScene withFont:font];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

#pragma mark - Color Filler
- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillColorDataSource, YJComponentDataSource>, YJColorPurpose, NSNumber * _Nullable, ...))fillColor {
    return ^(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, NSNumber * _Nullable firstScene, ...) {
        if (![dataSource conformsToProtocol:@protocol(YJDataFillColorDataSource)] || ![dataSource respondsToSelector:@selector(colorForScene:purpose:)]) return self;
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillColorDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withColor:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateColorForScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateColorForScene:nextScene];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            UIColor *color = [dataSource colorForScene:nextScene purpose:purpose];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate fillComponent:type scene:nextScene withColor:color forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillColorDataSource, YJComponentDataSource> _Nonnull, YJColorPurpose, NSInteger, NSNumber * _Nullable, ...))fillColorInSection {
    return ^(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, NSInteger section, NSNumber * _Nullable firstScene, ...) {
        // 不遵循协议 或者不实现dataSource的方法 --> 使用component初始化的默认值
        if (![dataSource conformsToProtocol:@protocol(YJDataFillColorDataSource)] || ![dataSource respondsToSelector:@selector(colorForScene:purpose:inSection:)]) return self;
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillColorDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withColor:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateColorForScene:inSection:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateColorForScene:nextScene inSection:section];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            UIColor *color = [dataSource colorForScene:nextScene purpose:purpose inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene inSection:section];
            [self.delegate fillComponent:type scene:nextScene withColor:color forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillColorDataSource, YJComponentDataSource> _Nonnull, YJColorPurpose, NSIndexPath * _Nonnull, NSNumber * _Nullable, ...))fillColorAtIndexPath {
    return ^(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, NSIndexPath *indexPath, NSNumber * _Nullable firstScene, ...) {
        if (![dataSource conformsToProtocol:@protocol(YJDataFillColorDataSource)] || ![dataSource respondsToSelector:@selector(colorForScene:purpose:indexPath:)]) return self;
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillColorDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withColor:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateColorForScene:indexPath:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateColorForScene:nextScene indexPath:indexPath];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            UIColor *color = [dataSource colorForScene:nextScene purpose:purpose indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene indexPath:indexPath];
            [self.delegate fillComponent:type scene:nextScene withColor:color forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillColorDataSource, YJComponentDataSource>, YJColorPurpose, UIControlState, NSNumber * _Nullable, ...))fillColorForState {
    return ^(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, UIControlState state, NSNumber * _Nullable firstScene, ...) {
        if (![dataSource conformsToProtocol:@protocol(YJDataFillColorDataSource)] || ![dataSource respondsToSelector:@selector(colorForScene:purpose:state:)]) return self;
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillColorDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withColor:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateColorForScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateColorForScene:nextScene];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            UIColor *color = [dataSource colorForScene:nextScene purpose:purpose state:state];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate fillComponent:type scene:nextScene withColor:color forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillColorDataSource, YJComponentDataSource> _Nonnull, YJColorPurpose, UIControlState, NSInteger, NSNumber * _Nullable, ...))fillColorForStateInSection {
    return ^(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, UIControlState state, NSInteger section, NSNumber * _Nullable firstScene, ...) {
        if (![dataSource conformsToProtocol:@protocol(YJDataFillColorDataSource)] || ![dataSource respondsToSelector:@selector(colorForScene:purpose:state:inSection:)]) return self;
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillColorDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withColor:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateColorForScene:inSection:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateColorForScene:nextScene inSection:section];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            UIColor *color = [dataSource colorForScene:nextScene purpose:purpose inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene inSection:section];
            [self.delegate fillComponent:type scene:nextScene withColor:color forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillColorDataSource, YJComponentDataSource> _Nonnull, YJColorPurpose, UIControlState, NSIndexPath * _Nonnull, NSNumber * _Nullable, ...))fillColorForStateAtIndexPath {
    return ^(id<YJDataFillColorDataSource, YJComponentDataSource> dataSource, YJColorPurpose purpose, UIControlState state, NSIndexPath *indexPath, NSNumber * _Nullable firstScene, ...) {
        if (![dataSource conformsToProtocol:@protocol(YJDataFillColorDataSource)] || ![dataSource respondsToSelector:@selector(colorForScene:purpose:state:indexPath:)]) return self;
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillColorDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withColor:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateColorForScene:indexPath:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateColorForScene:nextScene indexPath:indexPath];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            UIColor *color = [dataSource colorForScene:nextScene purpose:purpose state:state indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene indexPath:indexPath];
            [self.delegate fillComponent:type scene:nextScene withColor:color forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

#pragma mark - Image Filler
- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull, YJImagePurpose, NSNumber * _Nullable, ...))fillImageName {
    return ^(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull dataSource, YJImagePurpose purpose, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillImageDataSource));
        YJSelectorAssert(dataSource, @selector(imageNameForScene:purpose:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillImageDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withImageName:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateImageForScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateImageForScene:nextScene];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            NSString *imageName = [dataSource imageNameForScene:nextScene purpose:purpose];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate fillComponent:type scene:nextScene withImageName:imageName forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull, YJImagePurpose, NSInteger, NSNumber * _Nullable, ...))fillImageNameInSection {
    return ^(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull dataSource, YJImagePurpose purpose, NSInteger section, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillImageDataSource));
        YJSelectorAssert(dataSource, @selector(imageNameForScene:purpose:inSection:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillImageDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withImageName:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateImageForScene:inSection:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateImageForScene:nextScene inSection:section];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            NSString *imageName = [dataSource imageNameForScene:nextScene purpose:purpose inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene inSection:section];
            [self.delegate fillComponent:type scene:nextScene withImageName:imageName forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull, YJImagePurpose, NSIndexPath * _Nonnull, NSNumber * _Nullable, ...))fillImageNameAtIndexPath {
    return ^(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull dataSource, YJImagePurpose purpose, NSIndexPath * _Nonnull indexPath, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillImageDataSource));
        YJSelectorAssert(dataSource, @selector(imageNameForScene:purpose:indexPath:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillImageDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withImageName:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateImageForScene:indexPath:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateImageForScene:nextScene indexPath:indexPath];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            NSString *imageName = [dataSource imageNameForScene:nextScene purpose:purpose indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene indexPath:indexPath];
            [self.delegate fillComponent:type scene:nextScene withImageName:imageName forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull, YJImagePurpose, UIControlState, NSNumber * _Nullable, ...))fillImageNameForState {
    return ^(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull dataSource, YJImagePurpose purpose, UIControlState state, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillImageDataSource));
        YJSelectorAssert(dataSource, @selector(imageNameForScene:purpose:state:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillImageDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withImageName:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateImageForScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateImageForScene:nextScene];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            NSString *imageName = [dataSource imageNameForScene:nextScene purpose:purpose state:state];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate fillComponent:type scene:nextScene withImageName:imageName forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull, YJImagePurpose, UIControlState, NSInteger, NSNumber * _Nullable, ...))fillImageNameForStateInSection {
    return ^(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull dataSource, YJImagePurpose purpose, UIControlState state, NSInteger section, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillImageDataSource));
        YJSelectorAssert(dataSource, @selector(imageNameForScene:purpose:state:inSection:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillImageDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withImageName:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateImageForScene:inSection:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateImageForScene:nextScene inSection:section];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            NSString *imageName = [dataSource imageNameForScene:nextScene purpose:purpose state:state inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene inSection:section];
            [self.delegate fillComponent:type scene:nextScene withImageName:imageName forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull, YJImagePurpose, UIControlState, NSIndexPath * _Nonnull, NSNumber * _Nullable, ...))fillImageNameForStateAtIndexPath {
    return ^(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull dataSource, YJImagePurpose purpose, UIControlState state, NSIndexPath *indexPath, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillImageDataSource));
        YJSelectorAssert(dataSource, @selector(imageNameForScene:purpose:state:indexPath:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillImageDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withImageName:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateImageForScene:indexPath:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateImageForScene:nextScene indexPath:indexPath];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            NSString *imageName = [dataSource imageNameForScene:nextScene purpose:purpose state:state indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene indexPath:indexPath];
            [self.delegate fillComponent:type scene:nextScene withImageName:imageName forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull, YJImagePurpose, NSNumber * _Nullable, ...))fillImage {
    return ^(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull dataSource, YJImagePurpose purpose, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillImageDataSource));
        YJSelectorAssert(dataSource, @selector(imageForScene:purpose:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillImageDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withImage:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateImageForScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateImageForScene:nextScene];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            UIImage *image = [dataSource imageForScene:nextScene purpose:purpose];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate fillComponent:type scene:nextScene withImage:image forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull, YJImagePurpose, NSInteger, NSNumber * _Nullable, ...))fillImageInSection {
    return ^(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull dataSource, YJImagePurpose purpose, NSInteger section, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillImageDataSource));
        YJSelectorAssert(dataSource, @selector(imageForScene:purpose:inSection:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillImageDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withColor:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateImageForScene:inSection:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateImageForScene:nextScene inSection:section];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            UIImage *image = [dataSource imageForScene:nextScene purpose:purpose inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene inSection:section];
            [self.delegate fillComponent:type scene:nextScene withImage:image forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull, YJImagePurpose, NSIndexPath * _Nonnull, NSNumber * _Nullable, ...))fillImageAtIndexPath {
    return ^(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull dataSource, YJImagePurpose purpose, NSIndexPath * _Nonnull indexPath, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillImageDataSource));
        YJSelectorAssert(dataSource, @selector(imageForScene:purpose:indexPath:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillImageDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withImage:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateImageForScene:indexPath:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateImageForScene:nextScene indexPath:indexPath];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            UIImage *image = [dataSource imageForScene:nextScene purpose:purpose indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene indexPath:indexPath];
            [self.delegate fillComponent:type scene:nextScene withImage:image forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull, YJImagePurpose, UIControlState, NSNumber * _Nullable, ...))fillImageForState {
    return ^(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull dataSource, YJImagePurpose purpose, UIControlState state, NSNumber * _Nullable firstScene, ...) {
        YJSelectorAssert(dataSource, @selector(imageForScene:purpose:state:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillImageDelegate));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withImage:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateImageForScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateImageForScene:nextScene];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            UIImage *image = [dataSource imageForScene:nextScene purpose:purpose state:state];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [(id<YJDataFillImageDelegate>)self.delegate fillComponent:type scene:nextScene withImage:image forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull, YJImagePurpose, UIControlState, NSInteger, NSNumber * _Nullable, ...))fillImageForStateInSection {
    return ^(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull dataSource, YJImagePurpose purpose, UIControlState state, NSInteger section, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillImageDataSource));
        YJSelectorAssert(dataSource, @selector(imageForScene:purpose:state:inSection:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillImageDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withColor:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateImageForScene:inSection:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateImageForScene:nextScene inSection:section];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            UIImage *image = [dataSource imageForScene:nextScene purpose:purpose state:state inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene inSection:section];
            [self.delegate fillComponent:type scene:nextScene withImage:image forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull, YJImagePurpose, UIControlState, NSIndexPath * _Nonnull, NSNumber * _Nullable, ...))fillImageForStateAtIndexPath {
    return ^(id<YJDataFillImageDataSource, YJComponentDataSource> _Nonnull dataSource, YJImagePurpose purpose, UIControlState state, NSIndexPath *indexPath, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillImageDataSource));
        YJSelectorAssert(dataSource, @selector(imageForScene:purpose:state:indexPath:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillImageDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withImage:forPurpose:state:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdateImageForScene:indexPath:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdateImageForScene:nextScene indexPath:indexPath];
            }
            return NO;
        };
        void(^action)(int) = ^(int nextScene) {
            UIImage *image = [dataSource imageForScene:nextScene purpose:purpose state:state indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene indexPath:indexPath];
            [self.delegate fillComponent:type scene:nextScene withImage:image forPurpose:purpose state:state];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

#pragma mark PoN
- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillPoNDataSource, YJComponentDataSource> _Nonnull, YJPoNPurpose, NSNumber * _Nullable, ...))fillPoN {
    return ^(id<YJDataFillPoNDataSource, YJComponentDataSource> _Nonnull dataSource, YJPoNPurpose purpose, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillPoNDataSource));
        YJSelectorAssert(dataSource, @selector(ponForScene:purpose:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillPoNDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withPoN:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdatePon:forScene:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdatePon:purpose forScene:nextScene];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            BOOL pon = [dataSource ponForScene:nextScene purpose:purpose];
            YJComponentType type = [dataSource componentTypeForScene:nextScene];
            [self.delegate fillComponent:type scene:nextScene withPoN:pon forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillPoNDataSource, YJComponentDataSource> _Nonnull, YJPoNPurpose, NSInteger, NSNumber * _Nullable, ...))fillPoNInSection {
    return ^(id<YJDataFillPoNDataSource, YJComponentDataSource> _Nonnull dataSource, YJPoNPurpose purpose, NSInteger section, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillPoNDataSource));
        YJSelectorAssert(dataSource, @selector(ponForScene:purpose:inSection:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillPoNDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withPoN:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdatePon:forScene:inSection:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdatePon:purpose forScene:nextScene inSection:section];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            BOOL pon = [dataSource ponForScene:nextScene purpose:purpose inSection:section];
            YJComponentType type = [dataSource componentTypeForScene:nextScene inSection:section];
            [self.delegate fillComponent:type scene:nextScene withPoN:pon forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

- (id<YJDataFillerProtocol> _Nonnull (^)(id<YJDataFillPoNDataSource, YJComponentDataSource> _Nonnull, YJPoNPurpose, NSIndexPath * _Nonnull, NSNumber * _Nullable, ...))fillPoNAtIndexPath {
    return ^(id<YJDataFillPoNDataSource, YJComponentDataSource> _Nonnull dataSource, YJPoNPurpose purpose, NSIndexPath * _Nonnull indexPath, NSNumber * _Nullable firstScene, ...) {
        YJProtocolAssert(dataSource, @protocol(YJDataFillPoNDataSource));
        YJSelectorAssert(dataSource, @selector(ponForScene:purpose:indexPath:));
        YJProtocolAssert(dataSource, @protocol(YJComponentDataSource));
        YJSelectorAssert(dataSource, @selector(componentTypeForScene:));
        YJProtocolAssert(self.delegate, @protocol(YJDataFillPoNDelegate));
        YJSelectorAssert(self.delegate, @selector(fillComponent:scene:withPoN:forPurpose:));
        BOOL(^update)(int) = ^BOOL(int nextScene) {
            if ([dataSource conformsToProtocol:@protocol(YJDataFillShouldUpdateDataSource)] && [dataSource respondsToSelector:@selector(shouldUpdatePon:forScene:indexPath:)]) {
                return [(id<YJDataFillShouldUpdateDataSource>)dataSource shouldUpdatePon:purpose forScene:nextScene indexPath:indexPath];
            }
            return YES;
        };
        void(^action)(int) = ^(int nextScene) {
            BOOL pon = [dataSource ponForScene:nextScene purpose:purpose indexPath:indexPath];
            YJComponentType type = [dataSource componentTypeForScene:nextScene indexPath:indexPath];
            [self.delegate fillComponent:type scene:nextScene withPoN:pon forPurpose:purpose];
        };
        if (firstScene == nil) {
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:YJDefaultComponentScene shouldUpdate:update action:action];
        } else {
            va_list args;
            va_start(args, firstScene);
            [YJComponentWrapper componentDidLoaded:self.isFilled forScene:firstScene args:args shouldUpdate:update action:action];
        }
        return self;
    };
}

@end

