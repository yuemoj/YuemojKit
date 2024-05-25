//
//  YJDataSource.h
//  YuemojKit
//
//  Created by Yuemoj on 2021/4/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h>
#import <UIKit/UICollectionView.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YJDataSourceProtocol <NSObject>
@optional
@property (nonatomic, readonly) NSArray *records;
- (NSUInteger)countOfRecords;
- (nullable id)dataAtIndex:(NSUInteger)index; // note:不用indexPath是因为tableView取值.row 而collectionView取值.item, 
@end

FOUNDATION_EXTERN @interface YJDataSource : NSObject<YJDataSourceProtocol, UITableViewDataSource, UICollectionViewDataSource>
/// TODO: 研究block的参数不固定的实现
/// 便利构造器
/// @param fetcher reuse identifier获取block
+ (instancetype)dataSourceWithIdentifierFetcher:(NSString *(^)(NSIndexPath *))fetcher;
- (instancetype)initWithIdentifierFetcher:(NSString *(^)(NSIndexPath * _Nonnull))fetcher NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, nullable) BOOL (^permission)(NSIndexPath *);
#pragma mark TableView
@property (nonatomic, copy, nullable) void (^tableViewCellFiller)(__kindof UITableViewCell *, NSIndexPath *);
@property (nonatomic, copy, nullable) void (^tableViewAndCellFiller)(__kindof UITableView *, __kindof UITableViewCell *, NSIndexPath *);

#pragma mark CollectionView
@property (nonatomic, copy, nullable) void (^collectionViewCellFiller)(__kindof UICollectionViewCell *, NSIndexPath *);
@property (nonatomic, copy, nullable) void (^collectionViewAndCellFiller)(__kindof UICollectionView *, __kindof UICollectionViewCell *, NSIndexPath *);

- (instancetype)init NS_UNAVAILABLE;

- (void)loadDatas:(NSArray *)datas;
- (void)clearAllDatas;

@end

@protocol YJGroupModelProtocol;
@protocol YJGroupDataSourceProtocol <NSObject>
@optional
- (void)groupFold:(BOOL)fold willChangeAtSection:(NSUInteger)section;
- (BOOL)isGroupFoldAtSection:(NSUInteger)section;
- (nullable id)dataAtIndexPath:(NSIndexPath *)indexPath;
- (nullable id<YJGroupModelProtocol>)groupDataAtSection:(NSUInteger)section;
@end
FOUNDATION_EXTERN @interface YJGroupDataSource : YJDataSource<YJGroupDataSourceProtocol>
- (void)addSectionIndexs:(NSArray<NSString *> *(^)(NSArray<id<YJGroupModelProtocol>> *))indexsFetcher matcher:(NSInteger(^)(NSInteger section))matcher;
- (void)loadDatas:(NSArray<id<YJGroupModelProtocol>> *)dataSource;
@end

@protocol YJGroupModelProtocol <NSObject>
@property (nonatomic, copy, readonly) NSArray *groupRecords;
@optional
@property (nonatomic, copy, nullable) NSString *groupName;
@property (nonatomic, getter=isFolded) BOOL fold;
@end

NS_ASSUME_NONNULL_END
