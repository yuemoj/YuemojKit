//
//  YJComponentWrapper.m
//  YuemojKit
//
//  Created by Yuemoj on 2023/9/14.
//

#import "YJComponentWrapper.h"

@implementation YJComponentWrapper

+ (void)componentDidLoaded:(BOOL)isLoaded forScene:(NSNumber *)scene args:(va_list)args shouldUpdate:(BOOL(NS_NOESCAPE ^_Nullable)(int))update action:(void (^)(int nextScene))action {
    NSMutableArray *scenes = [NSMutableArray arrayWithObject:scene];
    NSNumber *nextScene;
    while ((nextScene = va_arg(args, NSNumber *)) && nextScene) {
        [scenes addObject:nextScene];
    }
    va_end(args);
    for (NSNumber *tmpScene in scenes) {
        [self componentDidLoaded:isLoaded forScene:tmpScene.intValue shouldUpdate:update action:action];
    }
}

+ (void)componentDidLoaded:(BOOL)isLoaded forScene:(int)scene shouldUpdate:(BOOL(NS_NOESCAPE ^_Nullable)(int))update action:(void (^)(int nextScene))action {
    // 处理控件的filler/eventBuilder/layouter时, 未加载过的直接加载, 已加载过的判断是否可以更新
    do {
        if (!isLoaded) break;
        BOOL shouldUpdate = !update ?: update(scene);
        if (!shouldUpdate) return;
    } while (0);
    !action ?: action(scene);
}

@end

