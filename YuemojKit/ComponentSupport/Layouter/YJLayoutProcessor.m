//
//  YJLayoutProcessor.m
//  YuemojKit
//
//  Created by Yuemoj on 2024/7/4.
//

#import "YJLayoutProcessor.h"
#import "YJLayoutProviderDataSource.h"
#import "YJLayouterProtocol.h"
#import "UIKit+Yuemoj.h"

@implementation YJLayoutProcessor
+ (void)layoutComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider {
    [self layoutComponentsOnView:aView provider:provider shouldUpdate:NO];
}

+ (void)layoutComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider inSection:(NSInteger)section {
    [self layoutComponentsOnView:aView provider:provider shouldUpdate:NO inSection:section];
}

+ (void)layoutComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider indexPath:(NSIndexPath *)indexPath {
    [self layoutComponentsOnView:aView provider:provider shouldUpdate:NO indexPath:indexPath];
}

+ (void)layoutAndUpdateComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider {
    [self layoutComponentsOnView:aView provider:provider shouldUpdate:YES];
}

+ (void)layoutAndUpdateComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider inSection:(NSInteger)section {
    [self layoutComponentsOnView:aView provider:provider shouldUpdate:YES inSection:section];
}

+ (void)layoutAndUpdateComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider indexPath:(NSIndexPath *)indexPath {
    [self layoutComponentsOnView:aView provider:provider shouldUpdate:YES indexPath:indexPath];
}

+ (void)layoutComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider shouldUpdate:(BOOL)should {
    aView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layout(provider.yj_layoutDataSource, ^__kindof UIView * _Nonnull(NSInteger scene) {
            return [provider yj_componentForScene:scene];
        });
        if (should) layouter.layoutUpdate(provider.yj_layoutUpdateDataSource);
    });
}

+ (void)layoutComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider shouldUpdate:(BOOL)should inSection:(NSInteger)section {
    aView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layoutInSection(provider.yj_layoutDataSourceInSection, section, ^__kindof UIView * _Nonnull(NSInteger scene) {
            return [provider yj_componentForScene:scene inSection:section];
        });
        if (should) layouter.layoutUpdateInSection(provider.yj_layoutUpdateDataSource, section);
    });
}

+ (void)layoutComponentsOnView:(__kindof UIView *)aView provider:(id<YJLayoutProviderDataSource>)provider shouldUpdate:(BOOL)should indexPath:(NSIndexPath *)indexPath {
    aView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layoutAtIndexPath(provider.yj_layoutDataSourceAtIndexPath, indexPath, ^__kindof UIView * _Nonnull(NSInteger scene) {
            return [provider yj_componentForScene:scene indexPath:indexPath];
        });
        if (should) layouter.layoutUpdateAtIndexPath(provider.yj_layoutUpdateDataSource, indexPath);
    });
}

@end
