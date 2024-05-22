//
//  YJComponentEnum.h
//  YuemojKit
//
//  Created by Yuemoj on 2023/5/5.
//

#ifndef YJComponentEnum_h
#define YJComponentEnum_h

/**通用 可配合component scene来指定某个控件 或全部控件 的不同状态下的表现 */
/// will deprecated
typedef NS_ENUM(int, OverallMode) {
    OverallModeDisplay,     // 可见状态
    OverallModeSelected,    // 选中状态
    OverallModeEnabled,     // 可用状态
};

typedef NS_ENUM(int, OverallScene) {
    OverallSceneTint,       // 前景
    OverallSceneBackground, // 背景
    OverallSceneAccessory,
    OverallSceneSeperator
};
static NSInteger const kSceneSuper = -1;
static NSInteger const kYJDefaultPlaceHolderScene = 0;

typedef NS_OPTIONS(int, YJComponentType) {
    YJComponentTypeView     = 0x0,
    YJComponentTypeCustom   = 0x1 << 0,
    YJComponentTypeText     = 0x1 << 1,
    YJComponentTypeFont     = 0x1 << 2,
    YJComponentTypeImage    = 0x1 << 3,
};
static YJComponentType const YJComponentTypeButton      = YJComponentTypeText | YJComponentTypeFont | YJComponentTypeImage;
static YJComponentType const YJComponentTypeLabel       = YJComponentTypeText | YJComponentTypeFont;
static YJComponentType const YJComponentTypeTextField   = YJComponentTypeLabel;
static YJComponentType const YJComponentTypeTextView    = YJComponentTypeLabel;

static NSInteger const kYJComponentSceneTag = 7758;
static inline NSInteger yj_componentIdentifier(YJComponentType type, NSInteger scene) {
    return kYJComponentSceneTag + type * 100 + scene % 100;
}

static inline NSInteger yj_componentScene(NSInteger identifier) {
    return (identifier - kYJComponentSceneTag) % 100;
}


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
};


#endif /* YJComponentEnum_h */

#ifndef YJProtocolAssert
#define YJProtocolAssert(object, protocol) NSAssert([object conformsToProtocol:protocol], @"%@ should conforms to protocol '%@'", [object class], NSStringFromProtocol(protocol))
#endif

#ifndef YJSelectorAssert
#define YJSelectorAssert(object, aSelector) NSAssert([object respondsToSelector:aSelector], @"%@ should responds to selector '%@'", [object class], NSStringFromSelector(aSelector))
#endif
