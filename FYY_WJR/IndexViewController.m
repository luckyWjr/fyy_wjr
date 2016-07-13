//
//  IndexViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/5/24.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "IndexViewController.h"
#import "MyTools.h"
#import "MyDefaultCellModel.h"
#import "MyTableViewGroupModel.h"
#import "MyImgScrollView.h"
#import "MsgTableViewController.h"
#import "MensesCalendarViewController.h"
#import "Valentine'sDayViewController.h"

@interface IndexViewController ()<MyImgScrollViewDelegate>

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    NSArray *images = @[[UIImage imageNamed:@"index"],
                        [UIImage imageNamed:@"IMG_6168"],
                        [UIImage imageNamed:@"IMG_6179"],
                        [UIImage imageNamed:@"IMG_6196"]
                        ];
    
    NSArray *titles = @[@"我",
                        @"爱",
                        @"你",
                        @"哟"
                        ];
    
    // 创建带标题的图片轮播器
    MyImgScrollView *ImgScrollView = [MyImgScrollView ImgScrollViewWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200) imagesGroup:images];
    ImgScrollView.dotsAliment = ImgScrollViewDotsAlimentRight;
    ImgScrollView.delegate = self;
    ImgScrollView.titlesGroup = titles;
    
    MyDefaultCellModel *group0_item0 =[MyDefaultCellModel itemWithIcon:@"icon1" title:@"love"];
    MyTableViewGroupModel *group0 = [[MyTableViewGroupModel alloc] init];
    [group0.items addObject:group0_item0];
    group0.headerHeight = 200;
    group0.headerView = ImgScrollView;
    
    MyDefaultCellModel *group1_item0 =[MyDefaultCellModel itemWithIcon:@"icon1" title:@"食物"];
    MyDefaultCellModel *group1_item1 =[MyDefaultCellModel itemWithIcon:@"icon1" title:@"化妆品"];
    MyTableViewGroupModel *group1 = [[MyTableViewGroupModel alloc] init];
    [group1.items addObject:group1_item0];
    [group1.items addObject:group1_item1];
    group1.header = @"最爱";
    
    MyDefaultCellModel *group2_item0 =[MyDefaultCellModel itemWithIcon:@"icon1" title:@"大姨妈"];
    MyDefaultCellModel *group2_item1 =[MyDefaultCellModel itemWithIcon:@"icon1" title:@"节日"];
    MyTableViewGroupModel *group2 = [[MyTableViewGroupModel alloc] init];
    [group2.items addObject:group2_item0];
    [group2.items addObject:group2_item1];
    
    [self.dataList addObject:group0];
    [self.dataList addObject:group1];
    [self.dataList addObject:group2];
}

- (void)clickCell:(MyTableViewGroupModel*)group model:(MyDefaultCellModel *)model{
    if ([model.title isEqualToString:@"love"]) {
        MsgTableViewController* msgVc = [[MsgTableViewController alloc] init];
        msgVc.msgType = MsgTypeLove;
        [self.navigationController pushViewController:msgVc animated:YES];
    }
    else if ([model.title isEqualToString:@"食物"]) {
        MsgTableViewController* msgVc = [[MsgTableViewController alloc] init];
        msgVc.msgType = MsgTypeFood;
        [self.navigationController pushViewController:msgVc animated:YES];
    }
    else if ([model.title isEqualToString:@"化妆品"]) {
        MsgTableViewController* msgVc = [[MsgTableViewController alloc] init];
        msgVc.msgType = MsgTypeToiletry;
        [self.navigationController pushViewController:msgVc animated:YES];
    }
    else if ([model.title isEqualToString:@"大姨妈"]) {
        MensesCalendarViewController* mensesVc = [[MensesCalendarViewController alloc] init];
        [self.navigationController pushViewController:mensesVc animated:YES];
    }
    else if ([model.title isEqualToString:@"节日"]) {
        Valentine_sDayViewController* valentineDayVc = [[Valentine_sDayViewController alloc] init];
        [self.navigationController pushViewController:valentineDayVc animated:YES];
    }
}

- (void)cycleScrollView:(MyImgScrollView *)ImgScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
