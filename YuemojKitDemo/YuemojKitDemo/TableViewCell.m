//
//  TableViewCell.m
//  YuemojKitDemo
//
//  Created by HYT200841559 on 2024/5/22.
//

#import "TableViewCell.h"
#import "Masonry.h"
#import "UIKit+Yuemoj.h"

@interface TableViewCell ()
@property (nonatomic) UIImageView *backgroundImageView;
@property (nonatomic) UIImageView *headImageView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIButton *markBtn;
@property (nonatomic) UIImageView *detailImageView;
@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self privateLayout];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)privateLayout {
    // note: scene图方便就直接用数字了, 正常情况就设置enum和ViewModel共同使用
    self.backgroundImageView = [UIImageView new];
//    self.backgroundImageView.yj_extra.setJTag(YJComponentTypeImage, 0);
    [self.contentView addSubview:self.backgroundImageView];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    self.headImageView = [UIImageView new];
//    self.backgroundImageView.yj_extra.setJTag(YJComponentTypeImage, 1);
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(32.f);
        make.centerY.offset(-5.f);
    }];
    
    self.titleLabel = [UILabel new];
//    self.titleLabel.yj_extra.setJTag(YJComponentTypeLabel, 2);
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImageView);
        make.leading.equalTo(self.headImageView.mas_trailing).offset(12.f);
    }];
    
    /// jtag用于在事件回调中区分scene
    self.markBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.markBtn.yj_extra.setJTag(YJComponentTypeButton, 3);
    [self.contentView addSubview:self.markBtn];
    [self.markBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImageView);
        make.leading.greaterThanOrEqualTo(self.titleLabel.mas_trailing).offset(12.f);
    }];
    
    self.detailImageView = [UIImageView new];
//    self.detailImageView.yj_extra.setJTag(YJComponentTypeImage, 4);
    [self.contentView addSubview:self.detailImageView];
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImageView);
        make.leading.equalTo(self.markBtn.mas_trailing).offset(5.f);
        make.trailing.offset(-32.f);
    }];
    
    self.contentView.yj_extra.viewForIdentifier = ^__kindof UIView * _Nonnull(YJComponentType type, NSInteger scene) {
        switch (scene) {
            case 0: return self.backgroundImageView;
            case 1: return self.headImageView;
            case 2: return self.titleLabel;
            case 3: return self.markBtn;
            case 4: return self.detailImageView;
            default: break;
        }
        return nil;
    };
}

@end
