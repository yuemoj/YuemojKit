//
//  YJTabEnums.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/31.
//

#ifndef YJTabTitleEnums_h
#define YJTabTitleEnums_h

#import "YuemojCoreTypes.h"

typedef NS_ENUM (int, YJTabScene) {
    YJTabSceneIndicator,
    YJTabSceneFirstSplit,
    // ...
    YJTabSceneFirstTabBtn = 10, 
    // ...
};

static inline YJComponentType yj_componentTypeForTabScene(YJTabScene scene) {
    return scene >= YJTabSceneFirstTabBtn ? YJComponentTypeButton : YJComponentTypeView;
}

#endif /* YJTabTitleEnums_h */
