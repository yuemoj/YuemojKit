//
//  YJMaskViewScenes.h
//  NetworkSalesController
//
//  Created by HYT200841559 on 2023/5/1.
//

#ifndef YJMaskViewScenes_h
#define YJMaskViewScenes_h

#import "YuemojCoreTypes.h"

/// @brief 文本均有默认的字体和颜色, 不需要时再设置即可
typedef NS_ENUM(int, YJMaskTopScene) {
    YJMaskTopSceneClose,
    YJMaskTopSceneTitle,
    YJMaskTopSceneRightBarButton,
    
    
//    MaskViewSceneClose,         // 有默认图标
//    MaskViewSceneTitle,
//    MaskViewSceneRightBarBtn,   // 有默认文本
//    
//    MaskViewSceneSelectedText,  // 有默认文本
//    MaskViewSceneSelectedCount, //
//    
//    MaskViewSceneOperateStyle1,
//    MaskViewSceneOperateStyle1Background, // 默认红色
//    
//    MaskViewSceneOperateStyle2Left,
//    MaskViewSceneOperateStyle2Right,
//    
//    MaskViewSceneEnd            // 禁止直接使用
};
static inline YJComponentType yj_componentTypeForTopMaskScene(YJMaskTopScene scene) {
    return scene == YJMaskTopSceneTitle ? YJComponentTypeLabel : YJComponentTypeButton;
}

typedef NS_ENUM(int, YJMaskBottomSingleScene) {
    YJMaskBottomSingleSceneLine = YJMaskTopSceneRightBarButton + 1,
    YJMaskBottomSingleSceneHint,
    YJMaskBottomSingleSceneCount,
    YJMaskBottomSingleSceneOperation,
};
static inline YJComponentType yj_componentTypeForSingleBottomMaskScene(YJMaskBottomSingleScene scene) {
    if (scene == YJMaskBottomSingleSceneLine) return YJComponentTypeView;
    return scene == YJMaskBottomSingleSceneOperation ? YJComponentTypeButton : YJComponentTypeLabel;
}

typedef NS_ENUM(int, YJMaskBottomDualScene) {
    YJMaskBottomDualSceneLine = YJMaskBottomSingleSceneOperation + 1,
    YJMaskBottomDualSceneLeftOperation,
    YJMaskBottomDualSceneRightOperation,
};
static inline YJComponentType yj_componentTypeForDualBottomMaskScene(YJMaskBottomDualScene scene) {
    return scene == YJMaskBottomDualSceneLine ? YJComponentTypeView : YJComponentTypeButton;
}


#endif /* YJMaskViewScenes_h */
