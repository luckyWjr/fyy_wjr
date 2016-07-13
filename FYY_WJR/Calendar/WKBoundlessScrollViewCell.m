//
//  WKBoundlessScrollViewCell.m
//  Calendar
//
//  Created by macairwkcao on 15/12/16.
//  Copyright © 2015年 CWK. All rights reserved.
//

#import "WKBoundlessScrollViewCell.h"
#import "CellDateModel.h"
#import "DateView.h"
#import "DateModel.h"
#import "ModelTool.h"

@interface WKBoundlessScrollViewCell ()
{
    NSInteger _year;
    NSInteger _month;
    NSInteger _day;
    NSInteger _weekday;
}

@property(strong, nonatomic) ModelTool* dateTool;
@property(strong, nonatomic) NSMutableArray* modelArr;

@end


@implementation WKBoundlessScrollViewCell
-(instancetype)initWithIdentifier:(NSString *)identifier
{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    self = [super initWithFrame:frame];
    if (self) {
//        [self getCurrentDate];
        self.identifier = identifier;
        self.dateTool = [[ModelTool alloc]initByType:ModelTypeDate];
//        self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width-40, 40)];

    }
    return self;
}

-(void)fillDate:(CellDateModel *)cellDateModel
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self setThisMonthMensesDay:cellDateModel];
    
    CGFloat width = (self.frame.size.width-20)/7.0;
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,  (width+15)*cellDateModel.drawDayRow+10+30);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((cellDateModel.beginWeekDay-1)*width+10, 5, width, 30)];
    label.text = [NSString stringWithFormat:@"%ld月",(long)cellDateModel.month];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
//                        label.backgroundColor = [UIColor blueColor];
    [self addSubview:label];
    for (int i = 0; i < cellDateModel.monthDays; i++) {
        if (i == 0) {
            
        }
        DateModel *dateModel = cellDateModel.dateModelArray[i];
        NSInteger column =  dateModel.weekday;
        NSInteger row = (i+cellDateModel.drawDayBeginIndex)/7;
        BOOL isMensesDay = NO;
        
        for (int i = 0; i < self.modelArr.count; i++) {
            DateModel* model = self.modelArr[i];
            if ((dateModel.year == model.year) && (dateModel.month == model.month) && (dateModel.day == model.day)) {
                isMensesDay = YES;
                break;
            }
        }
        
        DateView *dateView = [[DateView alloc] initWithFrame:CGRectMake(column*width+10, row*(width+15)+5+30+5, width, width) isMensesDay:isMensesDay];
        
        [dateView fillDate:dateModel];
//        dateView.backgroundColor = [UIColor redColor];
        [self addSubview:dateView];
    }
}

- (void)setThisMonthMensesDay:(CellDateModel *)cellDateModel{
    self.modelArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < [self.dateTool getModelArr].count; i++) {
        DateModel* model = [self.dateTool getModelArr][i];
        if ((cellDateModel.year == model.year) && (cellDateModel.month == model.month)) {
            [self.modelArr addObject:model];
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
}


-(void)setDeviation:(NSInteger)deviation
{
    _deviation = deviation;
//    [self fillDate:[self getDateModel:deviation]];
//    self.label.text = [NSString stringWithFormat:@"%ld",(long)_deviation];
}

@end
