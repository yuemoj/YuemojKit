//
//  YJActionTabLayoutViewModel.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/6/21.
//

#import <Foundation/Foundation.h>
#import "YJComponentDataSource.h"
#import "YJLayoutDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJActionTabLayoutViewModel : NSObject<YJComponentDataSource, YJLayoutDataSource>
@property (nonatomic) UIEdgeInsets padding;
@property (nonatomic) NSInteger actionCount;
@property (nonatomic) CGFloat actionTopMargin;
@property (nonatomic) CGSize actionSize;
@end

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

NS_ASSUME_NONNULL_END
