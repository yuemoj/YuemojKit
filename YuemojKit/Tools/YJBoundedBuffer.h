//
//  YJBoundedBuffer.h
//  Mcptt
//
//  Created by Yuemoj on 2022/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJBoundedBuffer : NSObject

/// @param ms 处理频率, 间隔时间单位ms
/// @param count 一次性处理的任务数
/// @param enumerator 对传入对象的操作, 每次操作会使consumer semaphore的值 -1
/// @param completion 按批次处理完成后的回调
- (instancetype)initWithConsumeHandleInterval:(useconds_t)ms limit:(NSUInteger)count consumeEnumerator:(void(^)(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop))enumerator completion:(void(^)(void))completion NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

/// 将传入的对象放入消费者队列中等待处理, 并在处理完成后执行指定的操作
/// @param anObject 需要处理的对象
- (void)startWorkWithObject:(id)anObject;
//- (void)restoreConsumerOnce;
@end

NS_ASSUME_NONNULL_END
