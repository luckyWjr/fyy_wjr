//
//  MensesCalendarViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/5/27.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MensesCalendarViewController.h"
#import "WKBoundlessScrollView.h"
#import "WKBoundlessScrollViewCell.h"
#import "TipView.h"
#import "DateTools.h"
#import "CellDateModel.h"
#import "DateModel.h"
#import "DateView.h"
#import "ModelTool.h"

@interface MensesCalendarViewController ()<WKBoundlessScrollViewDelegate, UIAlertViewDelegate>
{
    TipView *_tipView;
    NSInteger _currentYear;
    NSInteger _currentMonth;
    NSInteger _currentDay;
    NSInteger _currentWeekday;
    NSInteger _lastCellDeviation;
    NSMutableDictionary *_cell;
    DateView* _selectView;
    DateModel* _selectedDateModel;
}

@property(strong, nonatomic) ModelTool* dateTool;

@end

@implementation MensesCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateTool = [[ModelTool alloc]initByType:ModelTypeDate];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"姨妈日期";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelecteDate:) name:@"DID_SELETED_DATEVIEW" object:nil];
    
    [self.view addSubview:[self getTitleView]];
    
    WKBoundlessScrollView *boundlessScrollView = [[WKBoundlessScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    
    boundlessScrollView.decelerationRate = 1.0;
    boundlessScrollView.delegateForCell = self;
    [self.view addSubview:boundlessScrollView];
}

-(UIView *)getTitleView{
    NSArray *titleArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-20)/7;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 20)];
    for (int i = 0; i < titleArray.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*width+10, 0, width, 20)];
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:12.0];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
    }
    return view;
}

-(TipView *)getTipLabel:(NSString *)string{
    if (!_tipView) {
        _tipView = [[TipView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 50)];
        _tipView.backgroundColor = [UIColor clearColor];
        _tipView.hidden = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.0];
        label.tag = 100;
        [_tipView addSubview:label];
        _tipView.alpha = 0.0;
        [self.view addSubview:_tipView];
    }
    UILabel *label = [_tipView viewWithTag:100];
    label.text = string;
    return _tipView;
}

-(void)didSelecteDate:(NSNotification *)notification{
    NSDictionary * dict = notification.userInfo;
    _selectedDateModel = [dict objectForKey:@"dateModel"];
    _selectView = dict[@"view"];
    
    NSString* content;
    if (_selectView.isMensesDay) {
        content = [NSString stringWithFormat:@"%ld年%ld月%ld日的大姨妈消失了？", (long)_selectedDateModel.year, (long)_selectedDateModel.month, (long)_selectedDateModel.day];
    }
    else{
        content = [NSString stringWithFormat:@"是否将%ld年%ld月%ld日设为姨妈日？", (long)_selectedDateModel.year, (long)_selectedDateModel.month, (long)_selectedDateModel.day];
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            _selectView.isMensesDay = !_selectView.isMensesDay;
            [_selectView setDayBg];
            if (_selectView.isMensesDay) {
                [self.dateTool addNewModel:_selectedDateModel];
            }
            else{
                int i = 0;
                for (; i < [self.dateTool getModelArr].count; i++) {
                    DateModel* model = [self.dateTool getModelArr][i];
                    if ((_selectedDateModel.year == model.year) && (_selectedDateModel.month == model.month) && (_selectedDateModel.day == model.day)) {
                        break;
                    }
                }
                [self.dateTool removeModel:i];
            }
            break;
        default:
            break;
    }
}

-(WKBoundlessScrollViewCell *)boundlessScrollViewCellWithDeviation:(NSInteger)deviation boundlessScrollView:(WKBoundlessScrollView *)boundlessScrollView {
    static NSString *cellID = @"cellID";
    
    WKBoundlessScrollViewCell *cell = [boundlessScrollView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[WKBoundlessScrollViewCell alloc] initWithIdentifier:cellID];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CellDateModel *cellDateModel = [DateTools dateToCell:deviation];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell fillDate:cellDateModel];
        });
    });
    
    return cell;
}

-(CGFloat)boundlessScrollViewCellHeightWithdeviation:(NSInteger)deviation boundlessScrollView:(WKBoundlessScrollView *)boundlessScrollView{
    
    NSInteger row = [DateTools getDrawRow:deviation];
    CGFloat width = (self.view.frame.size.width-20)/7.0;
    return (width+15)*row+10+30;
}

-(void)didSelectedWithDeviation:(NSInteger)deviation boundlessScrollView:(WKBoundlessScrollView *)boundlessScrollView {
//    NSLog(@"%ld",(long)deviation);
}

-(void)boundlessScrollViewArriveTopVisible:(NSInteger)deviation {
    NSDateComponents *components = [DateTools getCellMonthDate:deviation];
    NSString *string = [NSString stringWithFormat:@"%ld年%ld月",(long)[components year],(long)[components month]];
    TipView *tipView = [self getTipLabel:string];
    if (tipView.hidden == YES) {
        tipView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            tipView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.6 animations:^{
                tipView.alpha = 0.6;
            } completion:^(BOOL finished) {
                tipView.hidden = YES;;
            }];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
