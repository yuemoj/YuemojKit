//
//  YJInputView.m
//  YuemojKit
//
//  Created by Yuemoj on 2023/4/14.
//

#import "YJInputView.h"
#import "Foundation+Yuemoj.h"

@interface YJInputView ()<UITextFieldDelegate>
@end

@implementation YJInputView

- (instancetype)init {
    if (self = [super init]) {
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)setInputTextField:(UITextField *)inputTextField {
    _inputTextField = inputTextField;
    _inputTextField.delegate = self;
}

- (NSString *)text {
    return self.inputTextField.text;
}

#pragma mark TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (!self.shouldBeginEditing) return YES;
    return self.shouldBeginEditing();
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (!self.shouldEndEditing) return YES;
    return self.shouldEndEditing();
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.markedTextRange) {
        // 中文输入完成才处理
        return YES;
    }
    if (string.length && ![string stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet].length) {
        // 过滤空格
        return NO;
    }
    NSString *result = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (self.bytesLimit > 0 && result.yj_string.reachLimitBytes(self.bytesLimit)) {
        // TODO: 这里有可能是粘贴来的一个字符串, 将多余的长度截掉. -- 有空再实现
        return NO;
    }
    if (!self.shouldChange) return YES;
    return self.shouldChange(result);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.markedTextRange) return YES;  // 中文输入完成才处理
    if (!self.shouldReturn) return YES;
    return self.shouldReturn(textField.text);
}

- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *textField = notification.object;
    if (textField != self.inputTextField) return;
    
    // 中文输入完成才处理
    if (textField.markedTextRange) return;
    !self.didChange ?: self.didChange(textField.text);
//    self.text = textField.text;
}

#pragma mark layout
+ (UITextField *)generalCommonTextField:(BOOL)isSecureEntry replaceClearBtn:(UIImage *)clearImage {
    UITextField *inputTextField = [UITextField new];
    inputTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputTextField.secureTextEntry = isSecureEntry;
    
    [inputTextField setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [inputTextField setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    if (clearImage) {
        UIButton *clearBtn = [inputTextField valueForKey:@"_clearButton"];
        [clearBtn setImage:clearImage forState:UIControlStateNormal];
    }
    return inputTextField;
}

@end
