//
//  ViewController.m
//  YuemojKitDemo
//
//  Create by Yuemoj on 2024/5/21.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "TableViewCell.h"
#import "YJTabView.h"
#import "YJTabLayoutViewModel.h"

#import "Masonry.h"
#import "UIKit+Yuemoj.h"
#import "YJLayouterProtocol.h"
#import "YJDataFillerProtocol.h"
#import "YJEventBuilderProtocol.h"

@interface ViewController ()<UITableViewDelegate>
@property (nonatomic) ViewModel *viewModel;
@property (nonatomic) UIView *headerView;
@property (nonatomic) YJTabView *underlineTabView;
@property (nonatomic) YJTabView *backgroundTabView;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *stateLabel;
@property (nonatomic) UILabel *idLabel;

@property (nonatomic) UITableView *tableView;

@property (nonatomic) BOOL shouldLinkage;
@end

static NSString * const DemoLayoutCellIdentifier    = @"com.yuemoj.demo.cell.layout";
static NSString * const DemoUserCellIdentifier      = @"com.yuemoj.demo.cell.user";
static NSString * const DemoHeaderIdentifier        = @"com.yuemoj.demo.view.section";
@implementation ViewController

#pragma mark- ** Lifecycle **
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    
    [self privateLayout];
    [self privateRegister];
    
    [self privateInitialData];
    
    [self privateFiller];
}

#pragma mark- ** User Operations **
- (void)onEdit:(UIButton *)sender {
    
}

#pragma mark- ** Protocols **
#pragma mark UITableViewDelegate
- (void)fillCell:(__kindof UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
//    cell.contentView.backgroundColor = UIColor.clearColor; [UIColor colorWithWhite:1.f alpha:0.f];
    cell.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.f];
    if (!indexPath.section) {
        cell.contentView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
            layouter.layoutAtIndexPath(self.viewModel, indexPath, ^__kindof UIView * _Nonnull(NSInteger scene) {
                switch (scene) {
                        // 可预先设置各控件的固定样式
                    case CellComponentBackgroundImage:
                    case CellComponentHeadImage:
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
    view.contentView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layoutInSection(self.viewModel, section, ^__kindof UIView * _Nonnull(NSInteger scene) {
            return UILabel.new;
        });
    });
    
    view.contentView.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
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

static CGFloat const kHorizontalMargin = 16.f, kVerticalMargin = 16.f;
static CGFloat const kHorizontalSpace = 10.f, kVerticalSpace = 10.f;
- (void)layoutHeaderView {
    _headerView = [UIView new];
//    _headerView.backgroundColor = [UIColor colorWithWhite:.8f alpha:1.f];
    [self.view addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.leading.trailing.offset(0.f);
    }];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(onEdit:) forControlEvents:UIControlEventPrimaryActionTriggered];
    [_headerView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kVerticalMargin);
        make.trailing.offset(-kHorizontalMargin);
    }];
    
    _nameLabel = [UILabel new];
    __weak typeof(_nameLabel) weakNameLabel = _nameLabel;
    _nameLabel.yj_extra.viewForIdentifier = ^__kindof UIView * _Nonnull(YJComponentType type, NSInteger scene) {
        return weakNameLabel;
    };
    _nameLabel.textColor = UIColor.whiteColor;
    _nameLabel.font = [UIFont systemFontOfSize:24.f];
    _nameLabel.numberOfLines = 0;
    _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [_headerView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(16.f);
        make.leading.offset(24.f);
        make.trailing.lessThanOrEqualTo(editBtn.mas_leading).offset(-kHorizontalSpace);
    }];
    
    _underlineTabView = YJTabView.new;
    [_headerView addSubview:_underlineTabView];
    [_underlineTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(kVerticalSpace);
        make.leading.offset(kHorizontalMargin);
    }];
    
    _backgroundTabView = YJTabView.new;
    [_headerView addSubview:_backgroundTabView];
    [_backgroundTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_underlineTabView.mas_bottom).offset(kVerticalSpace);
        make.leading.offset(kHorizontalMargin);
        make.bottom.offset(-kVerticalMargin);
    }];
    
    [self initialTableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(kVerticalSpace);
        make.leading.bottom.trailing.offset(0.f);
    }];
}

- (void)privateFiller {
    self.nameLabel.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
        filler.fillText(self.viewModel, YJTextPurposeText, nil)
        .fillFont(self.viewModel, nil)
        .fillColor(self.viewModel, YJColorPurposeText, nil);
    });
    
    [self loadUnderlineTabView];
    [self loadBackgroundTabView];
}

- (void)loadUnderlineTabView {
    YJTabLayoutViewModel *tabLayoutViewModel = YJTabLayoutViewModel.new;
    tabLayoutViewModel.shouldSplit = YES;
    tabLayoutViewModel.indicatorStyle = YJTabViewIndicatorStyleUnderline;
    tabLayoutViewModel.tabCount = 3;
    // TabView 布局
    self.underlineTabView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layout(tabLayoutViewModel, ^__kindof UIView * _Nonnull(NSInteger scene) {
            if (scene == YJTabSceneIndicator) {
                UIView *indicatorView = UIView.new;
                indicatorView.backgroundColor = UIColor.cyanColor;
                return indicatorView;
            } else if (scene >= YJTabSceneFirstSplit && scene < YJTabSceneFirstTabBtn) {
                UIView *splitView = UIView.new;
                splitView.backgroundColor = UIColor.lightGrayColor;
                return splitView;
            } else {
                UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
                return tabButton;
            }
        });
    });
    // 数据
    self.underlineTabView.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
        filler.fillTextForState(self.viewModel.tabTitleDataSource, YJTextPurposeText, UIControlStateNormal, @(YJTabSceneFirstTabBtn), @(YJTabSceneFirstTabBtn+1), @(YJTabSceneFirstTabBtn+2), nil)
        .fillColorForState(self.viewModel.tabTitleDataSource, YJColorPurposeText, UIControlStateNormal, @(YJTabSceneFirstTabBtn), @(YJTabSceneFirstTabBtn+1), @(YJTabSceneFirstTabBtn+2), nil)
        .fillColorForState(self.viewModel.tabTitleDataSource, YJColorPurposeText, UIControlStateSelected, @(YJTabSceneFirstTabBtn), @(YJTabSceneFirstTabBtn+1), @(YJTabSceneFirstTabBtn+2), nil);
    });
    
    // Tab button 事件响应注册
    __weak typeof(self) weakself = self;
    self.underlineTabView.yj_eventBuild.buildEvent(^(id<YJEventBuilderProtocol>  _Nonnull builder) {
        builder.addActionForControlEvents(self.viewModel.tabTitleDataSource, UIControlEventPrimaryActionTriggered, ^BOOL(id owner, __kindof UIControl *sender, NSInteger scene) {
            if (sender.selected) return NO;
            [weakself.viewModel onTabChoose:(YJTabScene)scene];
            weakself.underlineTabView.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
                filler.fillPoN(weakself.viewModel.tabTitleDataSource, YJPoNPurposeSelected, @(YJTabSceneFirstTabBtn), @(YJTabSceneFirstTabBtn+1), @(YJTabSceneFirstTabBtn+2), nil);
            });
            do {
                weakself.shouldLinkage = !weakself.shouldLinkage;
                if (!weakself.shouldLinkage) break;
                weakself.backgroundTabView.yj_eventBuild.eventTrigger(YJComponentTypeButton, scene);
            } while (0);
            return YES;
        }, @(YJTabSceneFirstTabBtn), @(YJTabSceneFirstTabBtn+1), @(YJTabSceneFirstTabBtn+2), nil);
    });
    // 查看all
    self.underlineTabView.yj_eventBuild.eventTrigger(YJComponentTypeButton, YJTabSceneFirstTabBtn);
}

- (void)loadBackgroundTabView {
    YJTabLayoutViewModel *tabLayoutViewModel = YJTabLayoutViewModel.new;
    tabLayoutViewModel.indicatorStyle = YJTabViewIndicatorStyleBackground;
    tabLayoutViewModel.tabCount = 3;
    // TabView 布局
    self.backgroundTabView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layout(tabLayoutViewModel, ^__kindof UIView * _Nonnull(NSInteger scene) {
            if (scene == YJTabSceneIndicator) {
                UIView *indicatorView = UIView.new;
                indicatorView.backgroundColor = [UIColor colorWithWhite:.2f alpha:1.f];;
                indicatorView.layer.cornerRadius = 10.f;
                return indicatorView;
            } else if (scene >= YJTabSceneFirstSplit && scene < YJTabSceneFirstTabBtn) {
                UIView *splitView = UIView.new;
                splitView.backgroundColor = UIColor.lightGrayColor;
                return splitView;
            } else {
                UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
                return tabButton;
            }
        });
    });
    // 数据
    self.backgroundTabView.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
        filler.fillTextForState(self.viewModel.tabTitleDataSource, YJTextPurposeText, UIControlStateNormal, @(YJTabSceneFirstTabBtn), @(YJTabSceneFirstTabBtn+1), @(YJTabSceneFirstTabBtn+2), nil)
        .fillColorForState(self.viewModel.tabTitleDataSource, YJColorPurposeText, UIControlStateNormal, @(YJTabSceneFirstTabBtn), @(YJTabSceneFirstTabBtn+1), @(YJTabSceneFirstTabBtn+2), nil)
        .fillColorForState(self.viewModel.tabTitleDataSource, YJColorPurposeText, UIControlStateSelected, @(YJTabSceneFirstTabBtn), @(YJTabSceneFirstTabBtn+1), @(YJTabSceneFirstTabBtn+2), nil);
    });
    
    // Tab button 事件响应注册
    __weak typeof(self) weakself = self;
    self.backgroundTabView.yj_eventBuild.buildEvent(^(id<YJEventBuilderProtocol>  _Nonnull builder) {
        builder.addActionForControlEvents(self.viewModel.tabTitleDataSource, UIControlEventPrimaryActionTriggered, ^BOOL(id owner, __kindof UIControl *sender, NSInteger scene) {
            if (sender.selected) return NO;
            [weakself.viewModel onTabChoose:(YJTabScene)scene];
            weakself.backgroundTabView.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
                filler.fillPoN(weakself.viewModel.tabTitleDataSource, YJPoNPurposeSelected, @(YJTabSceneFirstTabBtn), @(YJTabSceneFirstTabBtn+1), @(YJTabSceneFirstTabBtn+2), nil);
            });
            do {
                weakself.shouldLinkage = !weakself.shouldLinkage;
                if (!weakself.shouldLinkage) break;
                weakself.underlineTabView.yj_eventBuild.eventTrigger(YJComponentTypeButton, scene);
            } while (0);
            return YES;
        }, @(YJTabSceneFirstTabBtn), @(YJTabSceneFirstTabBtn+1), @(YJTabSceneFirstTabBtn+2), nil);
    });
    // 查看all
    self.backgroundTabView.yj_eventBuild.eventTrigger(YJComponentTypeButton, YJTabSceneFirstTabBtn);
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
