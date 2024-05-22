//
//  ViewController.m
//  YuemojKitDemo
//
//  Create by Yuemoj on 2024/5/21.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "TableViewCell.h"

#import "Masonry.h"
#import "UIKit+Yuemoj.h"
#import "Component+Yuemoj.h"

@interface ViewController ()<UITableViewDelegate>
@property (nonatomic) ViewModel *viewModel;
@property (nonatomic) UIView *headerView;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *stateLabel;
@property (nonatomic) UILabel *idLabel;

@property (nonatomic) UITableView *tableView;
@end

static NSString * const DemoLayoutCellIdentifier    = @"com.yuemoj.demo.cell.layout";
static NSString * const DemoUserCellIdentifier      = @"com.yuemoj.demo.cell.user";
static NSString * const DemoHeaderIdentifier        = @"com.yuemoj.demo.view.section";
@implementation ViewController

#pragma mark- ** Lifecycle **
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self privateLayout];
    [self privateFiller];
    [self privateRegister];
    
    [self privateInitialData];
    
    self.nameLabel.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
        filler.fillText(self.viewModel, YJTextPurposeText, nil)
        .fillFont(self.viewModel, nil)
        .fillColor(self.viewModel, YJColorPurposeText, nil);
    });
}

#pragma mark- ** User Operations **
- (void)onEdit:(UIButton *)sender {
    
}

#pragma mark- ** Protocols **
#pragma mark UITableViewDelegate
- (void)fillCell:(__kindof UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.f];
    if (!indexPath.section) {
        cell.contentView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
            layouter.layoutAtIndexPath(self.viewModel, indexPath, ^__kindof UIView * _Nonnull(NSInteger scene) {
                switch (scene) {
                        // 可预先设置各控件的固定样式
                    case CellComponentBackgroundImage:  return UIImageView.new;
                    case CellComponentHeadImage:        return UIImageView.new;
                    case CellComponentDetailImage:      return UIImageView.new;
                    case CellComponentTitle:            return UILabel.new;
                    case CellComponentMarkBtn:          return [UIButton buttonWithType:UIButtonTypeCustom];
                    default: break;
                }
                return UIView.new;
            });
        });
    }
    
    cell.contentView.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
        filler.fillImageNameAtIndexPath(self.viewModel, YJImagePurposeForeground, indexPath, @(CellComponentHeadImage), @(CellComponentBackgroundImage), @(CellComponentDetailImage), nil)
        .fillImageNameForStateAtIndexPath(self.viewModel, YJImagePurposeForeground, UIControlStateSelected, indexPath, @(CellComponentMarkBtn), nil)
        .fillImageNameForStateAtIndexPath(self.viewModel, YJImagePurposeForeground, UIControlStateNormal, indexPath, @(CellComponentMarkBtn), nil)
        .fillTextAtIndexPath(self.viewModel, YJTextPurposeText, indexPath, @(CellComponentTitle), nil)
        .fillFontAtIndexPath(self.viewModel, indexPath, @(CellComponentTitle), nil)
        .fillColorAtIndexPath(self.viewModel, YJColorPurposeText, indexPath, @(CellComponentTitle), nil)
        .fillPoNAtIndexPath(self.viewModel, indexPath, YJPoNPurposeSelected, @(CellComponentMarkBtn), nil);
    });
    
    cell.contentView.yj_eventBuild.buildEvent(^(id<YJEventBuilderProtocol>  _Nonnull builder) {
        builder.addActionForControlEvents(self.viewModel, UIControlEventPrimaryActionTriggered, ^BOOL(id owner, UIButton *sender, NSInteger scene) {
            sender.selected = !sender.selected;
            return YES;
        }, @(CellComponentMarkBtn), nil);
    });
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:DemoHeaderIdentifier];
    view.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layoutInSection(self.viewModel, section, ^__kindof UIView * _Nonnull(NSInteger scene) {
            return UILabel.new;
        });
    });
    
    view.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
        filler.fillTextInSection(self.viewModel, YJTextPurposeText, section, nil)
        .fillFontInSection(self.viewModel, section, nil)
        .fillColorInSection(self.viewModel, YJColorPurposeText, section, nil);
    });
    return view;
}

#pragma mark -Getters

#pragma mark- ** UI && InitialData **
#pragma mark -Layout
- (void)privateLayout {
    [self layoutHeaderView];
    [self.headerView layoutIfNeeded];
}

static CGFloat const kHeaderHeight = 100.f;
- (void)layoutHeaderView {
    _headerView = [UIView new];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.leading.trailing.offset(0.f);
        make.height.offset(kHeaderHeight);
    }];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(onEdit:) forControlEvents:UIControlEventPrimaryActionTriggered];
    [self.headerView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(16.f);
        make.trailing.offset(-12.f);
    }];
    
    __weak typeof(self) weakself = self;
    _nameLabel = [UILabel new];
    _nameLabel.yj_extra.viewForIdentifier = ^__kindof UIView * _Nonnull(YJComponentType type, NSInteger scene) {
        return weakself.nameLabel;
    };
    _nameLabel.textColor = UIColor.whiteColor;
    _nameLabel.font = [UIFont systemFontOfSize:24.f];
    _nameLabel.numberOfLines = 0;
    _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.headerView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.leading.offset(24.f);
        make.trailing.lessThanOrEqualTo(editBtn.mas_leading).offset(-10.f);
    }];
    
    [self initialTableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(kHeaderHeight);
        make.leading.bottom.trailing.offset(0.f);
    }];
}

- (void)privateFiller {
}

#pragma mark -Initial
- (void)privateInitialData {
    __weak typeof(self) weakself = self;
    _viewModel = [ViewModel viewModelWithDataSourceSetter:^(id<UITableViewDataSource> _Nonnull dataSource) {
        weakself.tableView.dataSource = dataSource;
    } identifierFetcher:^NSString * _Nonnull(NSIndexPath *indexPath) {
        return indexPath.section ? DemoUserCellIdentifier : DemoLayoutCellIdentifier;
    } cellFiller:^(__kindof UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        [weakself fillCell:cell indexPath:indexPath];
    } dataReloader:^{
        [weakself.tableView reloadData];
    } result:^{
        
    }];
}

- (void)initialTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.f];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100.f;
    _tableView.separatorInset = UIEdgeInsetsMake(0, UIScreen.mainScreen.bounds.size.width, 0, 0);
    _tableView.delegate = self;
}
#pragma mark -Register
- (void)privateRegister {
    [self.tableView registerClass:UITableViewHeaderFooterView.class forHeaderFooterViewReuseIdentifier:DemoHeaderIdentifier];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:DemoLayoutCellIdentifier];
    [self.tableView registerClass:TableViewCell.class forCellReuseIdentifier:DemoUserCellIdentifier];
}

#pragma mark- ** Override **


#pragma mark- ** Lazy Loading **


@end
