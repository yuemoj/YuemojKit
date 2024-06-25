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

#import "YJTopBottomMaskViewManager.h"
#import "YJMaskTopLayoutViewModel.h"
#import "YJMaskBottomSingleOperationLayoutViewModel.h"
#import "YJMaskBottomDualOperationsLayoutViewModel.h"

#import "YJActionViewController.h"

#import "Masonry.h"
#import "UIKit+Yuemoj.h"
#import "YJLayouterProtocol.h"
#import "YJDataFillerProtocol.h"
#import "YJEventBuilderProtocol.h"

#define k_status_height         UIApplication.sharedApplication.windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height

@interface ViewController ()<UITableViewDelegate>
@property (nonatomic) ViewModel *viewModel;
@property (nonatomic) UIView *headerView;
@property (nonatomic) YJTabView *underlineTabView;
@property (nonatomic) YJTabView *backgroundTabView;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *stateLabel;
@property (nonatomic) UILabel *idLabel;

@property (nonatomic) UITableView *tableView;

@property (nonatomic) YJActionViewController *actionTabViewController;
@property (nonatomic) YJActionViewController *actionSheetViewController;
@property (nonatomic) YJActionTabLayoutViewModel *actionTabLayoutViewModel;
@property (nonatomic) YJActionSheetLayoutViewModel *actionSheetLayoutViewModel;

@property (nonatomic) YJTopBottomMaskViewManager *singleMaskViewManager;
@property (nonatomic) YJTopBottomMaskViewManager *dualMaskViewManager;
@property (nonatomic) YJMaskTopLayoutViewModel *topLayoutViewModel;
@property (nonatomic) YJMaskBottomSingleOperationLayoutViewModel *singleBottomMaskLayoutViewModel;
@property (nonatomic) YJMaskBottomDualOperationsLayoutViewModel *dualBottomMaskLayoutViewModel;

@property (nonatomic) MaskSingleViewModel *maskSingleViewModel;
@property (nonatomic) ActionTabViewModel *actionTabViewModel;
@property (nonatomic) ActionSheetViewModel *actionSheetViewModel;

@property (nonatomic) BOOL shouldLinkage;
@end

static NSString * const DemoLayoutCellIdentifier    = @"com.yuemoj.demo.cell.layout";
static NSString * const DemoUserCellIdentifier      = @"com.yuemoj.demo.cell.user";
static NSString * const DemoHeaderIdentifier        = @"com.yuemoj.demo.view.section";
@implementation ViewController

#pragma mark- ** Lifecycle **
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:118.f/255.f green:214.f/255.f blue:1.f alpha:1.f];
    
    UIBarButtonItem *singleItem = [[UIBarButtonItem alloc] initWithTitle:@"SingleMask" style:UIBarButtonItemStylePlain target:self action:@selector(onSingleMask:)];
    UIBarButtonItem *dualItem = [[UIBarButtonItem alloc] initWithTitle:@"DualMask" style:UIBarButtonItemStylePlain target:self action:@selector(onDualMask:)];
    self.navigationItem.rightBarButtonItems = @[singleItem, dualItem];
        
    [self privateLayout];
    [self privateRegister];
    
    [self privateInitialData];
    
    [self privateFiller];
}

#pragma mark- ** User Operations **
static NSString * const tabTitles[] = {
    @"bind", @"unbind", @"group"
};
static NSString * const tabImages[] = {
    @"icon_device_bind", @"icon_device_unbind", @"icon_group_create"
};
static NSString * const sheetTitles[] = {
    @"first action", @"second action"
};

- (void)onTabAction:(UIButton *)sender {
    if (!self.actionTabViewController) [self loadActionTabViewController];
    [self.actionTabViewController presentOnViewController:self];
}

- (void)onSheetAction:(UIButton *)sender {
    if (!self.actionSheetViewController) [self loadActionSheetViewControlelr];
    [self.actionSheetViewController presentOnViewController:self];
}

- (void)onSingleMask:(UIBarButtonItem *)sender {
    if (!self.singleMaskViewManager) [self loadSingleOperationMaskView];
    [self.singleMaskViewManager showOnViewController:self];
    self.singleMaskViewManager.bottomMaskView.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
        filler.fillText(self.maskSingleViewModel, YJTextPurposeText, @(YJMaskBottomSingleSceneCount), nil);
    });
    [self onTableViewTransform:YES];
    [self.viewModel onSelectionChange:YES];
}

- (void)reloadDataOnSingleMaskView {
    if (self.singleMaskViewManager.isDisplayed) {
        self.singleMaskViewManager.topMaskView.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
            filler.fillPoN(self.maskSingleViewModel, YJPoNPurposeSelected, @(YJMaskTopSceneRightBarButton), nil);
        });
        self.singleMaskViewManager.bottomMaskView.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
            filler.fillText(self.maskSingleViewModel, YJTextPurposeText, @(YJMaskBottomSingleSceneCount), nil);
        });
    }
    
    if (self.dualMaskViewManager.isDisplayed) {
        self.dualMaskViewManager.topMaskView.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
            filler.fillPoN(self.maskSingleViewModel, YJPoNPurposeSelected, @(YJMaskTopSceneRightBarButton), nil);
        });
    }
}

- (void)onDualMask:(UIBarButtonItem *)sender {
    if (!self.dualMaskViewManager) [self loadDualOperationMaskView];
    [self.dualMaskViewManager showOnViewController:self];
    [self.viewModel onSelectionChange:YES];
    [self onTableViewTransform:YES];
}

- (void)onTableViewTransform:(BOOL)shouldDisplayMaskView {
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(shouldDisplayMaskView ? -96.f : 0.f);
    }];
    [UIView animateWithDuration:.25f animations:^{
        [self.view layoutIfNeeded];
    }];
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
                    case CellComponentBackgroundImage:
                    case CellComponentSelection:
                    case CellComponentHeadImage:
                    case CellComponentDetailImage:      return UIImageView.new;
                    case CellComponentTitle:            return UILabel.new;
                    case CellComponentMarkBtn:          return [UIButton buttonWithType:UIButtonTypeCustom];
                    default: break;
                }
                return UIView.new;
            }).layoutUpdateAtIndexPath(self.viewModel, indexPath);
        });
    }
    
    // Note: 自定义的Cell CenterY的调整自己需要额外实现, 不能通过layouter.layoutUpdateAtIndexPath()来处理
    cell.contentView.yj_dataFill.fillComponent(^(id<YJDataFillerProtocol>  _Nonnull filler) {
        filler.fillImageNameAtIndexPath(self.viewModel, YJImagePurposeForeground, indexPath, @(CellComponentSelection), @(CellComponentHeadImage), @(CellComponentBackgroundImage), @(CellComponentDetailImage), nil)
        .fillImageNameForStateAtIndexPath(self.viewModel, YJImagePurposeForeground, UIControlStateSelected, indexPath, @(CellComponentMarkBtn), nil)
        .fillImageNameForStateAtIndexPath(self.viewModel, YJImagePurposeForeground, UIControlStateNormal, indexPath, @(CellComponentMarkBtn), nil)
        .fillTextAtIndexPath(self.viewModel, YJTextPurposeText, indexPath, @(CellComponentTitle), nil)
        .fillFontAtIndexPath(self.viewModel, indexPath, @(CellComponentTitle), nil)
        .fillColorAtIndexPath(self.viewModel, YJColorPurposeText, indexPath, @(CellComponentTitle), nil)
        .fillPoNAtIndexPath(self.viewModel, YJPoNPurposeSelected, indexPath, @(CellComponentMarkBtn), @(CellComponentSelection), nil)
        .fillPoNAtIndexPath(self.viewModel, YJPoNPurposeDisplay, indexPath, @(CellComponentSelection), nil);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel doSthAtIndexPath:indexPath callback:^(NSString * _Nonnull obj) {
            
    }];
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
    
    UIButton *actionSheetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [editBtn setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
    [actionSheetBtn setTitle:@"sheet" forState:UIControlStateNormal];
    [actionSheetBtn addTarget:self action:@selector(onSheetAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
    [_headerView addSubview:actionSheetBtn];
    [actionSheetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kVerticalMargin);
        make.trailing.offset(-kHorizontalMargin);
    }];
    
    UIButton *actionTabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionTabBtn setTitle:@"tab" forState:UIControlStateNormal];
    [actionTabBtn addTarget:self action:@selector(onTabAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
    [_headerView addSubview:actionTabBtn];
    [actionTabBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(actionSheetBtn);
        make.trailing.equalTo(actionSheetBtn.mas_leading).offset(-10.f);
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
        make.trailing.lessThanOrEqualTo(actionTabBtn.mas_leading).offset(-kHorizontalSpace);
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
                indicatorView.backgroundColor = [UIColor colorWithWhite:.2f alpha:1.f];
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

- (void)loadSingleOperationMaskView {
    self.singleMaskViewManager = [YJTopBottomMaskViewManager new];
    self.singleMaskViewManager.topMaskHeight = k_status_height + 44.f;
    self.singleMaskViewManager.topMaskView.backgroundColor = [UIColor colorWithWhite:.8f alpha:1.f];
    self.singleMaskViewManager.topMaskView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layout(self.topLayoutViewModel, ^__kindof UIView * _Nonnull(NSInteger scene) {
            switch (scene) {
                case YJMaskTopSceneClose: {
                    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [closeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
                    [closeBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
                    return closeBtn;
                }
                case YJMaskTopSceneTitle: {
                    UILabel *titleLabel = [UILabel new];
                    titleLabel.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightSemibold];
                    titleLabel.textColor = UIColor.darkTextColor;
                    titleLabel.text = @"单操作";
                    return titleLabel;
                }
                case YJMaskTopSceneRightBarButton: {
                    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    rightBarBtn.titleLabel.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightMedium];
                    [rightBarBtn setTitle:@"全选" forState:UIControlStateNormal];
                    [rightBarBtn setTitle:@"取消全选" forState:UIControlStateSelected];
                    [rightBarBtn setTitleColor:UIColor.cyanColor forState:UIControlStateNormal];
                    [rightBarBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
                    return rightBarBtn;
                }
                default: return nil;
            }
        });
    });
    
    __weak typeof(self) weakself = self;
    self.singleMaskViewManager.topMaskView.yj_eventBuild.buildEvent(^(id<YJEventBuilderProtocol>  _Nonnull builder) {
        builder.addActionForControlEvents(self.topLayoutViewModel, UIControlEventPrimaryActionTriggered, ^BOOL(id owner, __kindof UIControl *sender, NSInteger scene) {
            if (scene == YJMaskTopSceneClose) {
                [weakself.singleMaskViewManager removeFromMaskingViewController];
                [weakself onTableViewTransform:NO];
                [weakself.viewModel onSelectionChange:NO];
            } else if (scene == YJMaskTopSceneRightBarButton) {
                sender.selected = !sender.isSelected;
                [weakself.viewModel onSelectAll:sender.isSelected];
            }
            return YES;
        }, @(YJMaskTopSceneClose), @(YJMaskTopSceneRightBarButton), nil);
    });
    
    self.singleMaskViewManager.bottomMaskHeight = 96.f;
    self.singleMaskViewManager.bottomMaskView.backgroundColor = [UIColor colorWithWhite:.8f alpha:1.f];
    self.singleMaskViewManager.bottomMaskView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layout(self.singleBottomMaskLayoutViewModel, ^__kindof UIView * _Nonnull(NSInteger scene) {
            switch (scene) {
                case YJMaskBottomSingleSceneLine: {
                    UIView *line = [UIView new];
                    line.backgroundColor = UIColor.lightGrayColor;
                    return line;
                }
                case YJMaskBottomSingleSceneHint: {
                    UILabel *selectedTextLabel = [UILabel new];
                    selectedTextLabel.font = [UIFont systemFontOfSize:16.f];
                    selectedTextLabel.text = @"已选:";
                    selectedTextLabel.textColor = UIColor.darkTextColor;
                    return selectedTextLabel;
                }
                case YJMaskBottomSingleSceneCount: {
                    UILabel *countLabel = [UILabel new];
                    countLabel.font = [UIFont systemFontOfSize:16.f];
                    countLabel.textColor = UIColor.darkGrayColor;
                    countLabel.text = @"10";
                    return countLabel;
                }
                case YJMaskBottomSingleSceneOperation: {
                    UIButton *operateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    operateBtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
                    [operateBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                    [operateBtn setTitle:@"确定" forState:UIControlStateNormal];
                    operateBtn.backgroundColor = [UIColor colorWithWhite:.2f alpha:1.f];
                    operateBtn.layer.cornerRadius = 10.f;
                    operateBtn.layer.masksToBounds = YES;
                    return operateBtn;
                }
                default: return nil;
            }
        });
    });
}

- (void)loadDualOperationMaskView {
    self.dualMaskViewManager = [YJTopBottomMaskViewManager new];
    self.dualMaskViewManager.topMaskHeight = k_status_height + 44.f;
    self.dualMaskViewManager.topMaskView.backgroundColor = [UIColor colorWithWhite:.8f alpha:1.f];
    self.dualMaskViewManager.topMaskView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layout(self.topLayoutViewModel, ^__kindof UIView * _Nonnull(NSInteger scene) {
            switch (scene) {
                case YJMaskTopSceneClose: {
                    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [closeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
                    [closeBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
                    return closeBtn;
                }
                case YJMaskTopSceneTitle: {
                    UILabel *titleLabel = [UILabel new];
                    titleLabel.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightSemibold];
                    titleLabel.textColor = UIColor.darkTextColor;
                    titleLabel.text = @"双操作";
                    return titleLabel;
                }
                case YJMaskTopSceneRightBarButton: {
                    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    rightBarBtn.titleLabel.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightMedium];
                    [rightBarBtn setTitle:@"全选" forState:UIControlStateNormal];
                    [rightBarBtn setTitle:@"取消全选" forState:UIControlStateSelected];
                    [rightBarBtn setTitleColor:UIColor.cyanColor forState:UIControlStateNormal];
                    [rightBarBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
                    return rightBarBtn;
                }
                default: return nil;
            }
        });
    });
    
    __weak typeof(self) weakself = self;
    self.dualMaskViewManager.topMaskView.yj_eventBuild.buildEvent(^(id<YJEventBuilderProtocol>  _Nonnull builder) {
        builder.addActionForControlEvents(self.topLayoutViewModel, UIControlEventPrimaryActionTriggered, ^BOOL(id owner, __kindof UIControl *sender, NSInteger scene) {
            if (scene == YJMaskTopSceneClose) {
            [weakself.dualMaskViewManager removeFromMaskingViewController];
            [weakself onTableViewTransform:NO];
                    [weakself.viewModel onSelectionChange:NO];
            } else if (scene == YJMaskTopSceneRightBarButton) {
                sender.selected = !sender.isSelected;
                [weakself.viewModel onSelectAll:sender.isSelected];
            }
            return YES;
        }, @(YJMaskTopSceneClose), @(YJMaskTopSceneRightBarButton), nil);
    });
    
    self.dualMaskViewManager.bottomMaskHeight = 96.f;
    self.dualMaskViewManager.bottomMaskView.backgroundColor = [UIColor colorWithWhite:.8f alpha:1.f];
    self.dualMaskViewManager.bottomMaskView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layout(self.dualBottomMaskLayoutViewModel, ^__kindof UIView * _Nonnull(NSInteger scene) {
            switch (scene) {
                case YJMaskBottomDualSceneLine: {
                    UIView *line = [UIView new];
                    line.backgroundColor = UIColor.lightGrayColor;
                    return line;
                }
                case YJMaskBottomDualSceneLeftOperation: {
                    UIButton *operateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    operateBtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
                    [operateBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
                    [operateBtn setTitle:@"左" forState:UIControlStateNormal];
                    [operateBtn setImage:[UIImage imageNamed:@"icon_close_solid_red"] forState:UIControlStateNormal];
                    return operateBtn;
                }
                case YJMaskBottomDualSceneRightOperation: {
                    UIButton *operateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    operateBtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
                    [operateBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
                    [operateBtn setTitle:@"右" forState:UIControlStateNormal];
                    [operateBtn setImage:[UIImage imageNamed:@"icon_check_solid_blue_32"] forState:UIControlStateNormal];
                    return operateBtn;
                }
                default: return nil;
            }
        });
    });
}

- (void)loadActionTabViewController {
    self.actionTabViewController = [[YJActionViewController alloc] initWithNibName:nil bundle:nil];
    self.actionTabViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.actionTabViewController.actionView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"img_bg_alert"].CGImage);
    self.actionTabViewController.actionView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layout(self.actionTabLayoutViewModel, ^__kindof UIView * _Nonnull(NSInteger scene) {
            if (scene == YJActionTabSceneDrag) {
                UIImageView *dragImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_drag"]];
                return dragImageView;
            }
            if (scene >= YJActionTabScenePlaceholder) {
                UIView *view = [UIView new];
                return view;
            }
            NSInteger index = scene - YJActionTabSceneFirstBtn;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:tabImages[index]] forState:UIControlStateNormal];
            [btn setTitle:tabTitles[index] forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.darkTextColor forState:UIControlStateNormal];
            return btn;
        });
    });
    [self.actionTabViewController.view layoutIfNeeded];
    for (int i = 0; i <= 2; i++) {
        UIButton *tmpBtn = self.actionTabViewController.actionView.yj_extra.viewForIdentifier(YJComponentTypeButton, YJActionTabSceneFirstBtn+i);
        CGSize imgSize = tmpBtn.imageView.yj_frame.size;
        [tmpBtn.titleLabel sizeToFit];
        CGSize titleSize = tmpBtn.titleLabel.yj_frame.size;
        // 图片向右上偏移
        tmpBtn.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height, 0.f, 0.f, -titleSize.width);
        // label向左下偏移
        tmpBtn.titleEdgeInsets = UIEdgeInsetsMake(0.f, -imgSize.width, -imgSize.height-14.f, 0.f);
    }
}

- (void)loadActionSheetViewControlelr {
    self.actionSheetViewController = [[YJActionViewController alloc] initWithNibName:nil bundle:nil];
    self.actionSheetViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.actionSheetViewController.actionView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"img_bg_alert"].CGImage);
    self.actionSheetViewController.actionView.yj_layout.layoutComponent(^(id<YJLayouterProtocol>  _Nonnull layouter) {
        layouter.layout(self.actionSheetLayoutViewModel, ^__kindof UIView * _Nonnull(NSInteger scene) {
            if (scene == YJActionSheetSceneDrag) {
                UIImageView *dragImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_drag"]];
                return dragImageView;
            }
            if (scene >= YJActionSheetSceneFirstBtn) {
                NSInteger index = scene - YJActionSheetSceneFirstBtn;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setTitle:sheetTitles[index] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.darkTextColor forState:UIControlStateNormal];
                return btn;
            }
            UIView *line = [UIView new];
            line.backgroundColor = UIColor.lightGrayColor;
            return line;
        });
    });
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
    } dataReloader:^(BOOL isSelection){
        [weakself.tableView reloadData];
        if (isSelection) [weakself reloadDataOnSingleMaskView];
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
    // Note: 用两种Cell是为了YJLayouter 和 自定义Cell布局对比, 以及兼容演示
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:DemoLayoutCellIdentifier];
    [self.tableView registerClass:TableViewCell.class forCellReuseIdentifier:DemoUserCellIdentifier];
}

#pragma mark- ** Override **


#pragma mark- ** Lazy Loading **
- (YJMaskTopLayoutViewModel *)topLayoutViewModel {
    if (!_topLayoutViewModel) {
        _topLayoutViewModel = [YJMaskTopLayoutViewModel new];
        _topLayoutViewModel.leading = 20.f;
        _topLayoutViewModel.trailing = -20.f;
        _topLayoutViewModel.centerYOffset = k_status_height * .5f;
    }
    return _topLayoutViewModel;
}

- (YJMaskBottomSingleOperationLayoutViewModel *)singleBottomMaskLayoutViewModel {
    if (!_singleBottomMaskLayoutViewModel) {
        _singleBottomMaskLayoutViewModel = [YJMaskBottomSingleOperationLayoutViewModel new];
        _singleBottomMaskLayoutViewModel.leading = 20.f;
        _singleBottomMaskLayoutViewModel.trailing = -20.f;
        _singleBottomMaskLayoutViewModel.centerYOffset = -10.f;
        _singleBottomMaskLayoutViewModel.operateBtnSize = CGSizeMake(114.f, 44.f);
    }
    return _singleBottomMaskLayoutViewModel;
}


- (YJMaskBottomDualOperationsLayoutViewModel *)dualBottomMaskLayoutViewModel {
    if (!_dualBottomMaskLayoutViewModel) {
        _dualBottomMaskLayoutViewModel = [YJMaskBottomDualOperationsLayoutViewModel new];
        
    }
    return _dualBottomMaskLayoutViewModel;
}

- (MaskSingleViewModel *)maskSingleViewModel {
    if (!_maskSingleViewModel) _maskSingleViewModel = [MaskSingleViewModel viewModelWithSync:self.viewModel];
    return _maskSingleViewModel;
}

- (YJActionTabLayoutViewModel *)actionTabLayoutViewModel {
    if (!_actionTabLayoutViewModel) {
        _actionTabLayoutViewModel = [YJActionTabLayoutViewModel new];
        _actionTabLayoutViewModel.padding = UIEdgeInsetsMake(12.f, kHorizontalMargin, 46.f, kHorizontalMargin);
        _actionTabLayoutViewModel.actionCount = 3;
        _actionTabLayoutViewModel.actionSize = CGSizeMake(97.f, 97.f);
        _actionTabLayoutViewModel.actionTopMargin = 40.f;
    }
    return _actionTabLayoutViewModel;
}

- (YJActionSheetLayoutViewModel *)actionSheetLayoutViewModel {
    if (!_actionSheetLayoutViewModel) {
        _actionSheetLayoutViewModel = [YJActionSheetLayoutViewModel new];
        _actionSheetLayoutViewModel.padding = UIEdgeInsetsMake(12.f, kHorizontalMargin *2.f, 46.f, kHorizontalMargin * 2.f);
        _actionSheetLayoutViewModel.actionCount = 2;
        _actionSheetLayoutViewModel.actionTopMargin = 40.f;
        _actionSheetLayoutViewModel.actionHeight = 50.f;
        _actionSheetLayoutViewModel.splitHeight = 1.f;
    }
    return _actionSheetLayoutViewModel;
}

- (ActionTabViewModel *)actionTabViewModel {
    if (!_actionTabViewModel) _actionTabViewModel = [ActionTabViewModel new];
    return _actionTabViewModel;
}

- (ActionSheetViewModel *)actionSheetViewModel {
    if (!_actionSheetViewModel) _actionSheetViewModel = [ActionSheetViewModel new];
    return _actionSheetViewModel;
}
@end

