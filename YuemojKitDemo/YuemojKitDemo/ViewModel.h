//
//  ViewModel.h
//  YuemojKitDemo
//
//  Create by Yuemoj on 2024/5/21.
//

#import <Foundation/Foundation.h>
#import "YJComponentDataSource.h"
#import "YJDataFillDataSource.h"
#import "YJLayoutDataSource.h"
#import "YJTabEnums.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UITableViewDataSource;
@class UITableViewCell, TabDataViewModel;
@interface ViewModel : NSObject<YJComponentDataSource ,YJLayoutDataSource, YJLayoutUpdateDataSource, YJDataFillTextDataSource, YJDataFillFontDataSource, YJDataFillColorDataSource, YJDataFillImageDataSource, YJDataFillPoNDataSource, YJDataFillShouldUpdateDataSource>
@property (nonatomic) TabDataViewModel *tabTitleDataSource;

+ (instancetype)viewModelWithDataSourceSetter:(void (NS_NOESCAPE^)(id<UITableViewDataSource> _Nonnull))setter
                            identifierFetcher:(nonnull NSString * _Nonnull (^)(NSIndexPath *))fetcher
                                   cellFiller:(void (^)(__kindof UITableViewCell * _Nonnull, NSIndexPath * _Nonnull))filler
                                 dataReloader:(void (^)(BOOL))reloader
                                       result:(void (^)(void))result;
- (void)doSthAtIndexPath:(NSIndexPath *)indexPath callback:(void(NS_NOESCAPE^)(NSString *obj))callback;
- (void)onTabChoose:(YJTabScene)scene;
- (void)onSelectionChange:(BOOL)canSelect;
- (void)onSelectAll:(BOOL)isAll;
@end
// TODO: 如果与自定义Cell一起用, 不应该写这里的  偷懒
typedef NS_ENUM(int, CellComponent) {
    CellComponentBackgroundImage,
    CellComponentSelection,
    CellComponentHeadImage,
    CellComponentTitle,
    CellComponentMarkBtn,
    CellComponentDetailImage,
};

@interface TabDataViewModel : NSObject <YJComponentDataSource, YJDataFillColorDataSource, YJDataFillTextDataSource, YJDataFillPoNDataSource>
@property (nonatomic, copy) NSArray  * _Nullable (^dataSourceFetcher)(void);
@property (nonatomic, copy) YJTabScene (^sceneFetcher)(void);
@end

@interface MaskSingleViewModel : NSObject <YJComponentDataSource, YJDataFillTextDataSource, YJDataFillPoNDataSource>
+ (instancetype)viewModelWithSync:(ViewModel *)viewModel;
- (instancetype)initWithSync:(ViewModel *)viewModel NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
@end
NS_ASSUME_NONNULL_END
