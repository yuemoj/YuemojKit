//
//  YJActionViewScenes.h
//  Pods
//
//  Created by Yuemoj on 2024/6/25.
//

#ifndef YJActionViewScenes_h
#define YJActionViewScenes_h

typedef NS_ENUM(int, YJActionTabScene) {
    YJActionTabSceneDrag,
    YJActionTabSceneFirstBtn,
    // ...
    YJActionTabScenePlaceholder = 10
};

static inline YJComponentType yj_componentTypeForActionTabScene(YJActionTabScene scene) {
    if (scene == YJActionTabSceneDrag) return YJComponentTypeImage;
    if (scene >= YJActionTabScenePlaceholder) return YJComponentTypeView;
    return YJComponentTypeButton;
}



typedef NS_ENUM(int, YJActionSheetScene) {
    YJActionSheetSceneDrag,
    YJActionSheetSceneFirstSplit,
    // ...
    YJActionSheetSceneFirstBtn = 10,
    // ...
};

static inline YJComponentType yj_componentTypeForActionSheetScene(YJActionSheetScene scene) {
    if (scene == YJActionSheetSceneDrag) return YJComponentTypeImage;
    if (scene >= YJActionSheetSceneFirstSplit) return YJComponentTypeView;
    return YJComponentTypeButton;
}
#endif /* YJActionViewScenes_h */
