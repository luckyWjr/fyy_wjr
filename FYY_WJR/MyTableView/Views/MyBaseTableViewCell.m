//
//  MyTableViewCell.m
//  FYY_WJR
//
//  Created by wjr on 16/5/24.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MyBaseTableViewCell.h"
#import "MyTools.h"
#import "UIView+SDExtension.h"
#import "MyOnlyTitleCellModel.h"

@interface MyBaseTableViewCell ()

@property(nonatomic, strong) UIImageView *imgView;
//@property(nonatomic, strong) UISwitch *switchView;
@property(nonatomic, strong) UILabel *labelView;
//@property(nonatomic, strong) CFLabelArrowView *labelarrowView;
//@property(nonatomic, strong) CFIconArrowView *iconArrowView;
@property(nonatomic, strong) UIButton *headView;

@property(nonatomic, weak) UIView *divider;

@end


@implementation MyBaseTableViewCell

- (UILabel *)labelView {
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.bounds = CGRectMake(0, 0, self.width * 0.55, self.height);
    }
    return _labelView;
}

- (UIButton *)headView {
    if (_headView == nil) {
        _headView = [[UIButton alloc] init];
        _headView.userInteractionEnabled = NO;
        _headView.frame = CGRectMake(0, 0, 80, 80);
    }
    return _headView;
}

//- (CFLabelArrowView *)labelarrowView {
//    if (_labelarrowView == nil) {
//        _labelarrowView = [[CFLabelArrowView alloc] init];
//        _labelarrowView.iconArrow = self.iconArrow;
//        _labelarrowView.bounds = CGRectMake(0, 0, self.frame.size.width * 0.55, self.frame.size.height);
//    }
//    return _labelarrowView;
//}
//
//- (CFIconArrowView *)iconArrowView {
//    if (_iconArrowView == nil) {
//        _iconArrowView = [[CFIconArrowView alloc] init];
//        _iconArrowView.iconArrow = self.iconArrow;
//        _iconArrowView.bounds = CGRectMake(0, 0, self.frame.size.width * 0.55, self.frame.size.height);
//    }
//    return _iconArrowView;
//}

//- (UISwitch *)switchView {
//    if (_switchView == nil) {
//        _switchView = [[UISwitch alloc] init];
//    }
//    return _switchView;
//}

- (void)setItem:(MyDefaultCellModel *)item {
    _item = item;
    // 设置cell的子控件的数据
    [self setUpData];
    // 设置右边视图
    [self setUpAccessoryView];
}

/**
 *  设置cell的子控件的数据
 */
- (void)setUpData {
    if(_item.contentView == nil){
        if (_item.icon.length) {
            self.imageView.image = [UIImage imageNamed:_item.icon];
        }
        else {
            self.imageView.image = nil;
        }
        self.textLabel.text = _item.title;
        
        self.detailTextLabel.text = _item.subTitle;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    else{
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        for(UIView *view in [self subviews]){
            [view removeFromSuperview];
        }
        [self addSubview:_item.contentView];
//        self.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    }
}

/**
 *  设置右边视图
 */
- (void)setUpAccessoryView {
    if (_item.contentView != nil || [_item isKindOfClass:[MyOnlyTitleCellModel class]]) { // Cell右边为空
        self.accessoryView = nil;
    }
//    else if ([_item isKindOfClass:[CFSettingSwitchItem class]]) { // Cell右边Switch
//        self.accessoryView = self.switchView;
//        CFSettingSwitchItem *switchItem = (CFSettingSwitchItem *)_item;
//        if([CFSaveTool isContainsKey:_item.title]){
//            self.switchView.on = [CFSaveTool isTurnOnSwitchByTitle:_item.title];
//        }
//        else{
//            [CFSaveTool setBool:switchItem.defaultOn forKey:_item.title];
//            self.switchView.on = switchItem.defaultOn;
//        }
//        [self.switchView addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    else if ([_item isKindOfClass:[CFSettingLabelItem class]]) { // Cell右边Label
//        self.accessoryView = self.labelView;
//        CFSettingLabelItem *labelItem = (CFSettingLabelItem *)_item;
//        self.labelView.text = labelItem.text_right;
//        self.labelView.textColor = CFRightLabelTextColor;
//        self.labelView.font = [UIFont systemFontOfSize:15];
//        self.labelView.textAlignment = NSTextAlignmentRight;
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    else if ([_item isKindOfClass: [CFSettingLabelArrowItem class]]) { // Cell右边Label和Arrow
//        self.accessoryView = self.labelarrowView;
//        CFSettingLabelArrowItem *labelarrowItem = (CFSettingLabelArrowItem *)_item;
//        self.labelarrowView.text = labelarrowItem.text_right;
//        self.selectionStyle = UITableViewCellSelectionStyleDefault;
//    }
//    else if ([_item isKindOfClass:[CFSettingIconItem class]]) { //Cell右边是图片
//        self.accessoryView = self.headView;
//        CFSettingIconItem *iconItem = (CFSettingIconItem *)_item;
//        [self.headView setImage:[UIImage imageNamed:iconItem.icon_right] forState:UIControlStateNormal];
//        self.selectionStyle = iconItem.cellSelectionStyle;
//    }
//    else if ([_item isKindOfClass: [CFSettingIconArrowItem class]]) { //Cell右边有图片和箭头
//        self.accessoryView = self.iconArrowView;
//        CFSettingIconArrowItem *iconArrowItem = (CFSettingIconArrowItem *)_item;
//        self.iconArrowView.icon_right = iconArrowItem.icon_right;
//        self.selectionStyle = iconArrowItem.cellSelectionStyle;
//    }
    else {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

//-(void)switchValueChanged:(UISwitch *)switchControl{
//    CFLog(@"switchValueChanged %d",switchControl.isOn);
//    [CFSaveTool setBool:switchControl.isOn forKey:_item.title];
//    if ([_item isKindOfClass:[CFSettingSwitchItem class]]) { // Cell右边Switch
//        CFSettingSwitchItem *switchItem = (CFSettingSwitchItem *)_item;
//        if(switchItem.opration_switch){
//            switchItem.opration_switch(switchControl.isOn);
//        }
//    }
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

/**
 *  快速创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MYCELL";
    MyBaseTableViewCell *cell = nil;
//    MyBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
        cell = [[MyBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.textLabel.textColor = MyCellTextColor;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
//    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 清空子视图的背景
        [self setSubViews];
    }
    
    return self;
}

/**
 *  清空子控件的背景颜色
 */
- (void)setSubViews {
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}

/**
 * 适配ios6的cell
 */
- (void)setFrame:(CGRect)frame {
    if (!IOS7) {
        frame.size.width += 20;
        frame.origin.x -= 10;
    }
    
    [super setFrame:frame];
}

/**
 *  cell右边Label字体
 */
//-(void)setRightLabelFont:(UIFont *)rightLabelFont{
//    _rightLabelFont = rightLabelFont;
//    self.labelView.font = rightLabelFont;
//    self.labelarrowView.rightLabelFont = rightLabelFont;
//}

/**
 *  cell右边Label字体颜色
 */
//-(void)setRightLabelFontColor:(UIColor *)rightLabelFontColor{
//    _rightLabelFontColor = rightLabelFontColor;
//    self.labelView.textColor = rightLabelFontColor;
//    self.labelarrowView.rightLabelFontColor = rightLabelFontColor;
//}


/**
 *  设置分割线的frame
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat dividerX = self.textLabel.x;
    CGFloat dividerY = 0;
    CGFloat dividerH = 1;
    CGFloat dividerW = self.width;
    
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}

@end
