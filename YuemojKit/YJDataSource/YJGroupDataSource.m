//
//  YJGroupDataSource.m
//  YuemojKit
//
//  Created by Yuemoj on 2021/9/24.
//  Copyright © 2021 hytera. All rights reserved.
//

#import "YJDataSource.h"

@interface YJGroupDataSource ()<UITableViewDataSource>
@property (nonatomic, copy) NSArray<id<YJGroupModelProtocol>> *dataSource;
@property (nonatomic, copy) NSString *(^fetcher)(NSIndexPath *);
/// 索引
@property (nonatomic) BOOL shouldShowSectionIndex;
@property (nonatomic, copy) NSArray<NSString *> * (^indexsFetcher)(NSArray<id<YJGroupModelProtocol>> *);
@property (nonatomic, copy) NSInteger (^sectionMatcher)(NSInteger);
@end

@implementation YJGroupDataSource
- (void)addSectionIndexs:(NSArray<NSString *> * _Nonnull (^)(NSArray<id<YJGroupModelProtocol>> *))indexsFetcher matcher:(NSInteger (^)(NSInteger))matcher {
    self.shouldShowSectionIndex = YES;
    self.indexsFetcher = indexsFetcher;
    self.sectionMatcher = matcher;
}

- (void)loadDatas:(NSArray<id<YJGroupModelProtocol>> *)dataSource {
    self.dataSource = dataSource;
}

//- (void)clearAllDatas {
//    self.dataSource = nil;
//}
- (NSArray *)records {
    return self.dataSource;
}
#pragma mark- ** DataSource **
#pragma mark -TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

// delegate的协议方法
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (!self.sectionHeaderFetcher) return nil;
//    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.sectionHeaderFetcher(section)];
//    !self.tableViewSectionHeaderFiller ?: self.tableViewSectionHeaderFiller(tableView, view, section);
//    return view;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (self.tableViewSectionHeaderFiller) {
//        return nil;
//    }
//    return self.dataSource[section].groupName;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<YJGroupModelProtocol> groupData = [self groupDataAtSection:section];
    if (!groupData) {
        return 0;
    }
    BOOL isFolded = NO;
    if ([groupData respondsToSelector:@selector(isFolded)]) {
        isFolded = groupData.isFolded;
    }
    return isFolded ? 0 : groupData.groupRecords.count;
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

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!self.shouldShowSectionIndex || !self.indexsFetcher) {
        return nil;
    }
    return self.indexsFetcher(self.dataSource);
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (!self.sectionMatcher) return 0;
    return self.sectionMatcher(index);
}
#pragma mark -CommonDataSourceProtocol
- (void)groupFold:(BOOL)fold willChangeAtSection:(NSUInteger)section {
    id<YJGroupModelProtocol> groupData = [self groupDataAtSection:section];
    if (!groupData) {
        return;
    }
    if ([groupData respondsToSelector:@selector(setFold:)]) {
        [self groupDataAtSection:section].fold = fold;
    }
}

- (BOOL)isGroupFoldAtSection:(NSUInteger)section {
    id<YJGroupModelProtocol> groupData = [self groupDataAtSection:section];
    if (!groupData) {
        return NO;
    }
    if ([groupData respondsToSelector:@selector(isFolded)]) {
        return [self groupDataAtSection:section].isFolded;
    }
    return NO;
}

- (id)dataAtIndexPath:(NSIndexPath *)indexPath {
    id<YJGroupModelProtocol> groupData = [self groupDataAtSection:indexPath.section];
    if (groupData.groupRecords.count <= indexPath.row) { return nil; }
    return groupData.groupRecords[indexPath.row];
}

- (id<YJGroupModelProtocol>)groupDataAtSection:(NSUInteger)section {
    if (section >= self.dataSource.count) { return nil; }
    return self.dataSource[section];
}

@end
