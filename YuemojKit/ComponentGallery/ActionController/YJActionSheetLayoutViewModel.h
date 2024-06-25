//
//  YJActionSheetLayoutViewModel.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/6/21.
//

#import <Foundation/Foundation.h>
#import "YJComponentDataSource.h"
#import "YJLayoutDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJActionSheetLayoutViewModel : NSObject<YJComponentDataSource, YJLayoutDataSource>
@property (nonatomic) UIEdgeInsets padding;
@property (nonatomic) NSInteger actionCount;
@property (nonatomic) CGFloat actionTopMargin;
@property (nonatomic) CGFloat actionHeight;
@property (nonatomic) CGFloat splitHeight;
@end

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
NS_ASSUME_NONNULL_END
