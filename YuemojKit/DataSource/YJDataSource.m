//
//  YJDataSource.m
//  YuemojKit
//
//  Created by Yuemoj on 2021/4/8.
//

#import "YJDataSource.h"

@interface YJDataSource ()

@property (nonatomic, copy) NSArray *records;
//@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, copy) NSString *(^fetcher)(NSIndexPath *);

@end

@implementation YJDataSource
+ (instancetype)dataSourceWithIdentifierFetcher:(NSString * _Nonnull (^)(NSIndexPath * _Nonnull))fetcher {
    return [[self alloc] initWithIdentifierFetcher:fetcher];
}

- (instancetype)initWithIdentifierFetcher:(NSString * _Nonnull (^)(NSIndexPath * _Nonnull))fetcher {
    if (self = [super init]) {
        self.fetcher = fetcher;
    }
    return self;
}

#pragma mark CollectionView
- (void)loadDatas:(NSArray *)datas {
    self.records = datas;
}

- (void)clearAllDatas {
    self.records = nil;
}

#pragma mark- ** Delegate **
#pragma mark -TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.fetcher(indexPath)];
    !self.tableViewCellFiller ?: self.tableViewCellFiller(cell, indexPath);
    !self.tableViewAndCellFiller ?: self.tableViewAndCellFiller(tableView, cell, indexPath);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.permission) {
        return self.permission(indexPath);
    }
    return YES;
}

#pragma mark -CollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.records.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.fetcher(indexPath) forIndexPath:indexPath];
    !self.collectionViewCellFiller ?: self.collectionViewCellFiller(cell, indexPath);
    !self.collectionViewAndCellFiller ?: self.collectionViewAndCellFiller(collectionView, cell, indexPath);
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.permission) {
        return self.permission(indexPath);
    }
    return YES;
}

#pragma mark -CommonDataSourceProtocol
- (NSUInteger)countOfRecords {
    return self.records.count;
}

- (id)dataAtIndex:(NSUInteger)index {
    if (index >= self.records.count) {
        return nil;
    }
    return self.records[index];
}

@end
