//
//  MyTableViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/5/24.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyTools.h"
#import "MyTableViewGroupModel.h"
#import "MyBaseTableViewCell.h"
#import "MyDefaultCellModel.h"

const CGFloat sectionHeight = 10;

@interface MyTableViewController ()

@end

@implementation MyTableViewController

- (NSMutableArray *)dataList {
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

// 初始化方法
- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView的背景颜色
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = ColorGray;
    
    // 适配iOS7的组间距
    if (IOS7) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MyTableViewGroupModel *group = self.dataList[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    MyBaseTableViewCell *cell = [[MyBaseTableViewCell class] cellWithTableView:tableView];
    
    // 取出模型
    MyTableViewGroupModel *group = self.dataList[indexPath.section];
    MyDefaultCellModel *item = group.items[indexPath.row];
    
    // 传递模型
    cell.item = item;
    
    //3.调整(iOS8以上)view边距
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath :(NSIndexPath *)indexPath {
    MyTableViewGroupModel *group = self.dataList[indexPath.section];
    MyDefaultCellModel  *item = group.items[indexPath.row];
    return item.cellHeight > 0 ? item.cellHeight : 44;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    MyTableViewGroupModel *group = self.dataList[section];
    if(group.headerHeight > 0){
        return group.headerHeight;
    }
    else if (group.header != nil) {
        return sectionHeight * 3;
    }
    else {
        if (section == 0) {
            return sectionHeight * 2;
        } else {
            return sectionHeight;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    MyTableViewGroupModel *group = self.dataList[section];
    if(group.footerHeight > 0){
        return group.footerHeight;
    }
    else {
        return sectionHeight;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    MyTableViewGroupModel *group = self.dataList[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    MyTableViewGroupModel *group = self.dataList[section];
    return group.footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MyTableViewGroupModel *group = self.dataList[section];
    return group.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    MyTableViewGroupModel *group = self.dataList[section];
    return group.footerrView;
}

/**
 *  点击某一行cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 取出模型
    MyTableViewGroupModel *group = self.dataList[indexPath.section];
    MyDefaultCellModel *item = group.items[indexPath.row];
    
    [self clickCell:group model:item];
    // 执行操作
//    if (item.opration) {
//        item.opration();
//        return;
//    }
}

- (void)clickCell:(MyTableViewGroupModel*)group model:(MyDefaultCellModel *)model{
    
}

@end
