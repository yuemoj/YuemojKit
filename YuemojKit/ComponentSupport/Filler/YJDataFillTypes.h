//
//  YJDataFillTypes.h
//  YuemojKitDemo
//
//  Created by Yuemoj on 2024/5/23.
//

#ifndef YJDataFillTypes_h
#define YJDataFillTypes_h

typedef NS_ENUM(int, YJTextPurpose) {
    YJTextPurposeText,
    YJTextPurposePlaceholder,
};

typedef NS_ENUM(int, YJColorPurpose) {
    YJColorPurposeText,
    YJColorPurposeBackground,
};

typedef NS_ENUM(int, YJImagePurpose) {
    YJImagePurposeForeground,
    YJImagePurposeBackground,
    YJImagePurposeThumbnail,
};

typedef NS_ENUM(int, YJPoNPurpose) {
    YJPoNPurposeDisplay,     // 可见状态
    YJPoNPurposeSelected,    // 选中状态
    YJPoNPurposeEnabled,     // 可用状态
    YJPoNPurposeSecure
};

#endif /* YJDataFillTypes_h */
