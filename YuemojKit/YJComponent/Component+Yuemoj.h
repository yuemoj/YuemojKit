//
//  Component+Yuemoj.h
//  YuemojKit
//
//  Created by Yuemoj on 2024/5/17.
//

#import "YuemojMacros.h"
#import "YJDataFillerProtocol.h"
#import "YJLayouterProtocol.h"
#import "YJEventBuilderProtocol.h"
//#import "YJComponentDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@YJNamespaceInstanceDeclaration(UIView, NSObject, yj_dataFill, YJDataFillAbility)
@end
@YJNamespaceInstanceDeclaration(UIView, NSObject, yj_layout, YJLayoutAbility)
@end
@YJNamespaceInstanceDeclaration(UIView, NSObject, yj_eventBuild, YJEventBuildAbility)
@end

NS_ASSUME_NONNULL_END
