//
//  YJGroupModel.h
//  YuemojKit
//
//  Created by Yuemoj on 2021/11/5.
//  Copyright © 2021 hytera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJDataSource.h"

NS_ASSUME_NONNULL_BEGIN
/// 根据使用场景取各自的type (通用数据模型分类实现协议容易覆盖同名方法)
/// TODO:探索更优雅的方式, 已知有协议默认实现方式, 研究下
typedef NS_ENUM(NSUInteger, ComonHeaderFooterUsingScene) {
    ComonHeaderFooterUsingSceneSearch,      // 查询场景
};
@interface YJGroupModel : NSObject<YJGroupModelProtocol>
//@property (nonatomic) ComonHeaderFooterUsingScene scene;
@property (nonatomic, copy) NSArray *groupRecords;
@property (nonatomic, copy, nullable) NSString *groupName;
@property (nonatomic, getter=isFolded) BOOL fold;
@end


NS_ASSUME_NONNULL_END
