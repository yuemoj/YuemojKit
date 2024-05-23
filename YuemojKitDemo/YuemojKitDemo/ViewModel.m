//
//  ViewModel.m
//  YuemojKitDemo
//
//  Create by Yuemoj on 2024/5/21.
//

#import "ViewModel.h"
#import "YJGroupModel.h"
#import "YuemojMetamacros.h"
@interface ViewModel ()
@property (nonatomic) YJGroupDataSource *dataSource;
@property (nonatomic, copy) void(^reloader)(void);
@property (nonatomic, copy) void(^result)(void);
@end
@implementation ViewModel
+ (instancetype)viewModelWithDataSourceSetter:(void (NS_NOESCAPE^)(id<UITableViewDataSource> _Nonnull))setter identifierFetcher:(NSString * _Nonnull (^)(NSIndexPath *))fetcher cellFiller:(void (^)(__kindof UITableViewCell * _Nonnull, NSIndexPath * _Nonnull))filler dataReloader:(void (^)(void))reloader result:(void (^)(void))result {
    return [[self alloc] initWithDataSourceSetter:setter identifierFetcher:fetcher cellFiller:filler dataReloader:reloader result:result];
}

- (instancetype)initWithDataSourceSetter:(void (^)(id<UITableViewDataSource> _Nonnull))setter identifierFetcher:(NSString * _Nonnull (^)(NSIndexPath *))fetcher cellFiller:(void (^)(__kindof UITableViewCell * _Nonnull, NSIndexPath * _Nonnull))filler dataReloader:(void (^)(void))reloader result:(void (^)(void))result {
    if (self = [super init]) {
        _dataSource = [YJGroupDataSource dataSourceWithIdentifierFetcher:^NSString * _Nonnull(NSIndexPath * _Nonnull indexPath) {
            return fetcher(indexPath);
        }];
        _dataSource.tableViewCellFiller = filler;
        !setter ?: setter(_dataSource);
        self.reloader = reloader;
        self.result = result;
    }
    [self loadData];
    return self;
}

- (void)loadData {
    NSMutableArray *layouterGroupData = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *cellGroupData = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i <= 3; i++) {
        [layouterGroupData addObject:@{@"name":[NSString stringWithFormat:@"layouter%d", i], @"on":@(i % 2)}];
        [cellGroupData addObject:@{@"name":[NSString stringWithFormat:@"usercell%d", i], @"on":@((i + 1) % 2)}];
    }
    YJGroupModel *layouterGroupModel = [YJGroupModel new];
    layouterGroupModel.groupName = @"layouter生成的cell";
    layouterGroupModel.groupRecords = layouterGroupData;
    
    YJGroupModel *cellGroupModel = [YJGroupModel new];
    cellGroupModel.groupName = @"自定义的cell类";
    cellGroupModel.groupRecords = cellGroupData;
    
    [self.dataSource loadDatas:@[layouterGroupModel, cellGroupModel]];
}

- (void)doSthAtIndexPath:(NSIndexPath *)indexPath callback:(void (NS_NOESCAPE^)(NSString * _Nonnull))callback {
    NSDictionary *data = [self.dataSource dataAtIndexPath:indexPath];
    !callback ?: callback(data[@"name"]);
}
@end

@implementation ViewModel (ComponentType)
- (YJComponentType)componentTypeForScene:(NSInteger)scene {
    return YJComponentTypeLabel;
}

- (YJComponentType)componentTypeForScene:(NSInteger)scene inSection:(NSInteger)section {
    return YJComponentTypeLabel;
}

- (YJComponentType)componentTypeForScene:(NSInteger)scene indexPath:(nonnull NSIndexPath *)indexPath {
    switch (scene) {
        case CellComponentBackgroundImage:
        case CellComponentHeadImage:
        case CellComponentDetailImage:  return YJComponentTypeImage;
        case CellComponentTitle:        return YJComponentTypeLabel;
        case CellComponentMarkBtn:      return YJComponentTypeButton;
        default:                        return YJComponentTypeView;
    }
}

@end
@implementation ViewModel (Layout)
- (NSArray<YJLayoutItemConstraintDescription *> *)layoutDescriptionsInSection:(NSInteger)section provider:(__kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger))provider {
    YJLayoutItem *titleItem = [YJLayoutItem new];
    [titleItem bindView:provider(0) withType:[self componentTypeForScene:0 inSection:section]];
    YJLayoutItemConstraintDescription *titleDescription = [titleItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.edges.insets(UIEdgeInsetsMake(10.f, 16.f, 10.f, 0.f));
    }];
    return @[titleDescription];
}

- (NSArray<YJLayoutItemConstraintDescription *> *)layoutDescriptionsAtIndexPath:(NSIndexPath *)indexPath provider:(nonnull __kindof UIView * _Nonnull (NS_NOESCAPE^)(NSInteger))provider {
    NSMutableArray *descriptions = [NSMutableArray arrayWithCapacity:0];
    // background
    YJLayoutItem *backgroundItem = [YJLayoutItem new];
    [backgroundItem bindView:provider(CellComponentBackgroundImage) withType:[self componentTypeForScene:CellComponentBackgroundImage indexPath:indexPath] scene:CellComponentBackgroundImage];
    YJLayoutItemConstraintDescription *backgroundDescription = [backgroundItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.edges.insets(UIEdgeInsetsZero);
    }];
    [descriptions addObject:backgroundDescription];
    
    // headImage
    YJLayoutItem *headImageItem = [YJLayoutItem new];
    [headImageItem bindView:provider(CellComponentHeadImage) withType:[self componentTypeForScene:CellComponentHeadImage indexPath:indexPath] scene:CellComponentHeadImage];
    YJLayoutItemConstraintDescription *headImageDescription = [headImageItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.leading.yj_offset(32.f);
        maker.centerY.yj_offset(-5.f);
    }];
    [descriptions addObject:headImageDescription];
    
    // title
    YJLayoutItem *titleItem = [YJLayoutItem new];
    [titleItem bindView:provider(CellComponentTitle) withType:[self componentTypeForScene:CellComponentTitle indexPath:indexPath] scene:CellComponentTitle];
    YJLayoutItemConstraintDescription *titleDescription = [titleItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.centerY.equalTo(headImageItem);
        maker.leading.equalTo(headImageItem.trailing).yj_offset(12.f);
    }];
    [descriptions addObject:titleDescription];
    
    // mark btn
    YJLayoutItem *markBtnItem = [YJLayoutItem new];
    [markBtnItem bindView:provider(CellComponentMarkBtn) withType:[self componentTypeForScene:CellComponentMarkBtn indexPath:indexPath] scene:CellComponentMarkBtn];
    YJLayoutItemConstraintDescription *markBtnDescription = [markBtnItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.centerY.equalTo(headImageItem);
        maker.leading.greaterThanOrEqualTo(titleItem.trailing).yj_offset(12.f);
    }];
    [descriptions addObject:markBtnDescription];
    
    // detail btn
    YJLayoutItem *detailImageItem = [YJLayoutItem new];
    [detailImageItem bindView:provider(CellComponentDetailImage) withType:[self componentTypeForScene:CellComponentDetailImage indexPath:indexPath] scene:CellComponentDetailImage];
    YJLayoutItemConstraintDescription *detailImageDescription = [detailImageItem makeItemDescription:^(id<YJLayoutConstraintAttributeDelegate>  _Nonnull maker) {
        maker.centerY.equalTo(headImageItem);
        maker.leading.equalTo(markBtnItem.trailing).yj_offset(5.f);
        maker.trailing.yj_offset(-32.f);
    }];
    [descriptions addObject:detailImageDescription];
    return descriptions;
}

- (UIOffset)offsetForScene:(NSInteger)scene indexPath:(NSIndexPath *)indexPath {
    switch (scene) {
        case CellComponentHeadImage: {
            id<YJGroupModelProtocol> groupModel = [self.dataSource groupDataAtSection:indexPath.section];
            NSInteger countInSection = groupModel.groupRecords.count;
            // 只有1行
            if (countInSection == 1 || indexPath.row == countInSection - 1) return UIOffsetMake(NSNotFound, -5.f);
        } break;
        default: break;
    }
    return UIOffsetMake(NSNotFound, 0.f);
}
@end

@implementation ViewModel (DataFill)
- (NSString *)textForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose {
    return @"Yuemoj";
}

- (nullable UIFont *)fontForScene:(NSInteger)scene {
    return [UIFont systemFontOfSize:48.f];
}

- (nullable UIColor *)colorForScene:(NSInteger)scene purpose:(YJColorPurpose)purpose {
    return UIColor.cyanColor;
}

/// MARK: headerView
- (NSString *)textForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose inSection:(NSInteger)section {
    id<YJGroupModelProtocol> groupModel = [self.dataSource groupDataAtSection:section];
    return groupModel.groupName;
}

- (nullable UIFont *)fontForScene:(NSInteger)scene inSection:(NSInteger)section {
    return [UIFont systemFontOfSize:UIFont.smallSystemFontSize];// weight:UIFontWeightLight];
}

- (UIColor *)colorForScene:(NSInteger)scene purpose:(YJColorPurpose)purpose inSection:(NSInteger)section {
    return UIColor.redColor;
}

/// MARK: cell
- (NSString *)textForScene:(NSInteger)scene purpose:(YJTextPurpose)purpose indexPath:(NSIndexPath *)indexPath {
    NSDictionary *entity = [self.dataSource dataAtIndexPath:indexPath];
    switch (scene) {
        case CellComponentTitle: return entity[@"name"];
        default: return nil;
    }
}

- (nullable UIFont *)fontForScene:(NSInteger)scene indexPath:(NSIndexPath *)indexPath {
    switch (scene) {
        case CellComponentTitle: return [UIFont systemFontOfSize:UIFont.labelFontSize];
        default: return nil;
    }
}

- (UIColor *)colorForScene:(NSInteger)scene purpose:(YJColorPurpose)purpose indexPath:(NSIndexPath *)indexPath {
    switch (scene) {
        case CellComponentTitle: return UIColor.darkTextColor;
        default: return nil;
    }
}

- (NSString *)imageNameForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose indexPath:(nonnull NSIndexPath *)indexPath {
    switch (scene) {
        case CellComponentBackgroundImage: {
            id<YJGroupModelProtocol> groupModel = [self.dataSource groupDataAtSection:indexPath.section];
            NSInteger countInSection = groupModel.groupRecords.count;
            // 只有1行
            if (countInSection == 1) return @"img_bg_cell_list";
            // 第一行
            if (!indexPath.row) return @"img_bg_cell_list_top";
            // 最后一行
            if (indexPath.row == countInSection - 1) return @"img_bg_cell_list_bottom";
            // 中间的行
            return @"img_bg_cell_list_middle";
        }
        case CellComponentHeadImage:       return @"icon_group_39";
        case CellComponentDetailImage:     return @"icon_sharp_right_gray";
        default:break;
    }
    return nil;
}

- (NSString *)imageNameForScene:(NSInteger)scene purpose:(YJImagePurpose)purpose state:(UIControlState)state indexPath:(NSIndexPath *)indexPath {
    switch (state) {
        case UIControlStateNormal:      return @"icon_ear_gray";
        case UIControlStateSelected:    return @"icon_ear_blue";
        default: break;
    }
    return nil;
}

- (YJComponentType)componentTypeForScene:(NSInteger)scene {
    YJComponentType type = YJComponentTypeView;
    switch (scene) {
        case CellComponentHeadImage:
        case CellComponentDetailImage:
        case CellComponentBackgroundImage: type = YJComponentTypeImage; break;
        case CellComponentTitle:           type = YJComponentTypeLabel; break;
        case CellComponentMarkBtn:         type = YJComponentTypeButton; break;
        default: break;
    }
    return type;
}

- (BOOL)ponForScene:(NSInteger)scene purpose:(YJPoNPurpose)purpose indexPath:(NSIndexPath *)indexPath {
    do {
        if (purpose != YJPoNPurposeSelected) break;
        if (scene != CellComponentMarkBtn) break;
        NSDictionary *entity = [self.dataSource dataAtIndexPath:indexPath];
        return [entity[@"on"] boolValue];
    } while (0);
    return NO;
}

/// MARK: update
- (BOOL)shouldUpdateImageForScene:(NSInteger)scene {
    // 背景图是可变的
    switch (scene) {
        case CellComponentBackgroundImage: return YES;
        default: return NO;
    }
}

@end
