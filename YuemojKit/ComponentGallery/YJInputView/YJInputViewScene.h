//
//  YJInputViewScene.h
//  YuemojKit
//
//  Created by Yuemoj on 2023/4/26.
//

#ifndef YJInputViewScene_h
#define YJInputViewScene_h

typedef NS_ENUM(int, YJInputViewScene) {
    YJInputViewSceneTextField,
    YJInputViewSceneRightView
};

static inline YJComponentType yj_componentTypeForInputViewScene(YJInputViewScene scene) {
    return scene == YJInputViewSceneTextField ? YJComponentTypeTextField : YJComponentTypeView;
}
#endif /* YJInputViewScene_h */
