//
//  YJBoundedBuffer.m
//  Mcptt
//
//  Created by Yuemoj on 2022/3/14.
//

#import "YJBoundedBuffer.h"
@interface YJBoundedBuffer ()
@property (nonatomic, strong) NSOperationQueue *producerQueue;
@property (nonatomic, strong) NSOperationQueue *consumerQueue;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong) dispatch_semaphore_t producerSemaphore;
@property (nonatomic, strong) dispatch_semaphore_t consumerSemaphore;
@property (nonatomic, copy) void(^consumeEnumerator)(id, NSUInteger, BOOL *);
@property (nonatomic, copy) void(^consumeCompletion)(void);
/// 消费者有等待处理的任务标识
@property (nonatomic, getter=isConsumerNeedProcess) BOOL consumerNeedProcess;
/// TODO: 使用栈结构处理, 否则遍历处理后清除可能会有异常
@property (nonatomic, strong) NSMutableArray *processingCache;

/// 消费者处理的频率 单位:ms
@property (nonatomic) useconds_t consumeHandleInterval;
/// 消费者处理任务限制数
@property (nonatomic) NSUInteger consumeLimitCount;
@end

@implementation YJBoundedBuffer

- (instancetype)initWithConsumeHandleInterval:(useconds_t)ms limit:(NSUInteger)count consumeEnumerator:(nonnull void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))enumerator completion:(nonnull void (^)(void))completion {
    if (self = [super init]) {
        _consumeHandleInterval = ms;
        _consumeLimitCount = count;
        _consumeEnumerator = enumerator;
        _consumeCompletion = completion;
        [self initialOperationQueue];
        [self initialSemephore];
    }
    return self;
}

#pragma mark- Producer & Consumer
- (void)startWorkWithObject:(id)anObject {
    if (!anObject) {
        return;
    }
    [self.producerQueue addOperationWithBlock: ^{
        [self produceWithObject:anObject];
        // 唤醒消息消费者线程
        [self.consumerQueue addOperationWithBlock:^{
            self.consumerNeedProcess = YES;
            [self consume];
        }];
    }];
}

- (void)produceWithObject:(id)anObject{
    dispatch_semaphore_wait(self.producerSemaphore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [self.processingCache addObject:anObject];
    dispatch_semaphore_signal(self.consumerSemaphore);
    dispatch_semaphore_signal(self.semaphore);
}

- (void)consume {
    if (!self.consumeEnumerator || !self.consumeCompletion) {
        return;
    }
    while (self.isConsumerNeedProcess && self.processingCache.count) {
        dispatch_semaphore_wait(self.consumerSemaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        // 取出所有缓存任务处理
        [self.processingCache enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            self.consumeEnumerator(obj, idx, stop);
            // 此处恢复producer的semaphore不会导致新的数据被加入cache 因为semaphore还未恢复
            dispatch_semaphore_signal(self.producerSemaphore);
        }];
        
        self.consumerNeedProcess = NO;
        [self.processingCache removeAllObjects];
        self.consumeCompletion();
        dispatch_semaphore_signal(self.semaphore);
        usleep(self.consumeHandleInterval * 1000);
    }
}

- (void)initialOperationQueue {
    _producerQueue = [NSOperationQueue new];
    _producerQueue.name = @"com.yuemoj.producer.queue";
    _producerQueue.maxConcurrentOperationCount = 2;
    
    _consumerQueue = [NSOperationQueue new];
    _consumerQueue.name = @"com.yuemoj.consumer.queue";
    _consumerQueue.maxConcurrentOperationCount = 1;
}

- (void)initialSemephore {
    _semaphore = dispatch_semaphore_create(1);
    _producerSemaphore = dispatch_semaphore_create(self.consumeLimitCount);
    _consumerSemaphore = dispatch_semaphore_create(0);
}
//
//- (NSOperationQueue *)producerQueue {
//    if (!_producerQueue) {
//        _producerQueue = [NSOperationQueue new];
//        _producerQueue.name = @"JorzProducerQueue";
//        _producerQueue.maxConcurrentOperationCount = 2;
//    }
//    return _producerQueue;
//}
//
//- (NSOperationQueue *)consumerQueue {
//    if (!_consumerQueue) {
//        _consumerQueue = [NSOperationQueue new];
//        _consumerQueue.name = @"JorzConsumerQueue";
//        _consumerQueue.maxConcurrentOperationCount = 1;
//    }
//    return _consumerQueue;
//}
//
//- (dispatch_semaphore_t)semaphore {
//    if (!_semaphore) {
//        _semaphore = dispatch_semaphore_create(1);
//    }
//    return _semaphore;
//}
//
//- (dispatch_semaphore_t)producerSemaphore {
//    if (!_producerSemaphore) {
//        _producerSemaphore = dispatch_semaphore_create(self.consumeLimitCount);
//    }
//    return _producerSemaphore;
//}
//
//- (dispatch_semaphore_t)consumerSemaphore {
//    if (!_consumerSemaphore) {
//        _consumerSemaphore = dispatch_semaphore_create(0);
//    }
//    return _consumerSemaphore;
//}

- (NSMutableArray *)processingCache {
    if (!_processingCache) {
        _processingCache = [NSMutableArray arrayWithCapacity:0];
    }
    return _processingCache;
}
@end
