//
//  YJHyperlinkNamespace.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/16.
//

#import "YJUIKitNamespace.h"
#import "UIKit+Yuemoj.h"

@interface YJHyperlinkNamespace ()<YuemojHyperlinkAbility>
@property (nonatomic) NSLayoutManager *layoutManager;
@property (nonatomic) NSTextContainer *textContainer;
@property (nonatomic) NSTextStorage *textStorage;
@property (nonatomic, copy) void(^callback)(UIGestureRecognizer * _Nonnull, NSInteger);
@end

@implementation YJHyperlinkNamespace
- (void)initialTextConfig {
    //textStorage(最小)<layoutManager<textContainer
    self.textContainer = [NSTextContainer new];
    self.textContainer.lineBreakMode = self.label.lineBreakMode;
    self.textContainer.lineFragmentPadding = 0.f;
    self.textContainer.maximumNumberOfLines = self.label.numberOfLines;
    self.layoutManager = [NSLayoutManager new];
    [self.layoutManager addTextContainer:self.textContainer];
    self.textStorage = [[NSTextStorage alloc] initWithAttributedString:self.label.attributedText];
    [self.textStorage addLayoutManager:self.layoutManager];
}

- (void)relayout {
    self.textContainer.size = self.label.yj_frame.size;
}

- (void(^)(void (^)(UIGestureRecognizer * _Nonnull, NSInteger)))hyperlink {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ownerDidTouchUpInside:)];
    self.label.userInteractionEnabled = YES;
    [self.label addGestureRecognizer:tap];
    return ^(void(^callback)(UIGestureRecognizer * _Nonnull, NSInteger)) {
        self.callback = callback;
    };
}

- (void)ownerDidTouchUpInside:(UITapGestureRecognizer *)sender {
    CGPoint locationOfTouchInLabel = [sender locationInView:sender.view];
    CGSize labelSize = sender.view.frame.size;
    self.textContainer.size = labelSize;
    CGRect textBoundingBox = [self.layoutManager usedRectForTextContainer:self.textContainer];
    CGPoint textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * .5f - textBoundingBox.origin.x, (labelSize.height - textBoundingBox.size.height) * .5f - textBoundingBox.origin.y);
    CGPoint locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x, locationOfTouchInLabel.y - textContainerOffset.y);
    NSInteger indexOfCharacter = [self.layoutManager characterIndexForPoint:locationOfTouchInTextContainer inTextContainer:self.textContainer fractionOfDistanceBetweenInsertionPoints:nil];
    !self.callback ?: self.callback(sender, indexOfCharacter);
}

- (UILabel *)label {
    return self.owner;
}
@end
