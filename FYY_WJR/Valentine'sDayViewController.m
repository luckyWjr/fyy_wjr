//
//  Valentine'sDayViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/6/1.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "Valentine'sDayViewController.h"
#import "MyTools.h"
#import "UIView+SDExtension.h"
#import "MsgTableViewController.h"

@interface Valentine_sDayViewController ()

@end

@implementation Valentine_sDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"节日";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setListView];
    // Do any additional setup after loading the view.
}

- (void)setListView {
    int margin = 10;
    int titleMarginTop = 30;
    int cardHeight = 150;
    int imgHeight = 120;
    int textHeight = 15;
    int scrollHeight = 1200;
    int titleHeight = 80;
    int titleLabelHeight = 40;
    int titleImgHeight = 40;
    
    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, scrollHeight);
    [self.view addSubview:scrollView];
    
    for (int i = 1; i < 15; i++) {
        if (i == 1 || i == 13) {
            UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(0, (i / 13 + 1) *titleMarginTop + i / 13 * 4 * (cardHeight + margin) + i / 13 * titleHeight, DEVICE_WIDTH, titleHeight)];
            
            UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, titleLabelHeight)];
            if (i == 1) {
                titleLabel.text = @"我们的情人节";
            }
            else{
                titleLabel.text = @"我们的其他节日";
            }
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:24];
            [titleView addSubview:titleLabel];
            
            UIImageView* titleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleLabelHeight - titleImgHeight / 3, DEVICE_WIDTH, titleImgHeight)];
            titleImgView.contentMode = UIViewContentModeCenter;
            titleImgView.image = [UIImage imageNamed:@"b0"];
            [titleView addSubview:titleImgView];
            
            [scrollView addSubview:titleView];
        }
        UIButton* ValentineDayView = [[UIButton alloc]initWithFrame:CGRectMake((i - 1) % 3 *DEVICE_WIDTH / 3 + margin, (i - 1) / 3 * (cardHeight + margin) + margin + titleMarginTop + titleHeight + i / 13 * (titleHeight + titleMarginTop), DEVICE_WIDTH / 3 - 2 * margin, cardHeight)];
        ValentineDayView.layer.borderWidth = 0.5;
        ValentineDayView.layer.borderColor = [[UIColor grayColor] CGColor];
        ValentineDayView.layer.cornerRadius = DEFAULT_RADIUS;
        ValentineDayView.layer.masksToBounds = YES;
        ValentineDayView.tag = i;
        [ValentineDayView addTarget:self action:@selector(dayClick:) forControlEvents:UIControlEventTouchDown];
        
        UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ValentineDayView.width, imgHeight)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"loveday_%d", i]];
        imgView.layer.borderWidth = 0.5;
        imgView.layer.borderColor = [[UIColor grayColor] CGColor];
        [ValentineDayView addSubview:imgView];
        
        UIImageView* borderImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ValentineDayView.width, ValentineDayView.height)];
        borderImg.image = [UIImage imageNamed:@"b1"];
        [ValentineDayView addSubview:borderImg];
        
        UILabel* nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imgHeight, ValentineDayView.width, textHeight)];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:12];
        [ValentineDayView addSubview:nameLabel];
        
        UILabel* dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imgHeight + textHeight, ValentineDayView.width, textHeight)];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.font = [UIFont systemFontOfSize:10];
        dateLabel.textColor = [UIColor grayColor];
        dateLabel.text = [NSString stringWithFormat:@"%d月14号", i];
        [ValentineDayView addSubview:dateLabel];
        
        [scrollView addSubview:ValentineDayView];
        
        switch (i) {
            case 1:
                nameLabel.text = @"日记情人节";
                break;
            case 2:
                nameLabel.text = @"情人节";
                break;
            case 3:
                nameLabel.text = @"白色情人节";
                break;
            case 4:
                nameLabel.text = @"黑色情人节";
                break;
            case 5:
                nameLabel.text = @"玫瑰情人节";
                break;
            case 6:
                nameLabel.text = @"亲亲情人节";
                break;
            case 7:
                nameLabel.text = @"银色情人节";
                break;
            case 8:
                nameLabel.text = @"绿色情人节";
                break;
            case 9:
                nameLabel.text = @"相片情人节";
                break;
            case 10:
                nameLabel.text = @"葡萄酒情人节";
                break;
            case 11:
                nameLabel.text = @"电影情人节";
                break;
            case 12:
                nameLabel.text = @"拥抱情人节";
                break;
            case 13:
                nameLabel.text = @"七夕节";
                dateLabel.text = @"农历7月初7";
                break;
            case 14:
                nameLabel.text = @"圣诞节";
                dateLabel.text = @"12月25号";
                break;
            default:
                break;
        }
    }
    
}

- (void)dayClick:(UIButton*)sender{
    MsgTableViewController* msgVc = [[MsgTableViewController alloc] init];
    msgVc.msgType = MsgTypeFestival;
    msgVc.index = (int)sender.tag;
    [self.navigationController pushViewController:msgVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
