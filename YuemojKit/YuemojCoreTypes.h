//
//  YuemojCoreTypes.h
//  YuemojKit
//
//  Created by Yuemoj on 2023/5/5.
//

#ifndef YuemojCoreTypes_h
#define YuemojCoreTypes_h

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



#endif /* YuemojCoreTypes_h */

