//
//  DateView.m
//  Calendar
//
//  Created by macairwkcao on 15/12/18.
//  Copyright © 2015年 CWK. All rights reserved.
//

#import "DateView.h"
#import "DateModel.h"
@interface DateView()
{
    UIView *_backgroundView;
}
@end
@implementation DateView

-(instancetype)initWithFrame:(CGRect)frame isMensesDay:(BOOL)isMensesDay{
    self = [self initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        _solarCalendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height*0.6)];
        _lunarCalendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, width*0.45, width, width*0.3)];
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.isMensesDay = isMensesDay;
        [self setDayBg];
        _backgroundView.layer.cornerRadius = width/2.0;
        _backgroundView.layer.masksToBounds = YES;
        [self addSubview:_backgroundView];
        [self addSubview:_solarCalendarLabel];
        [self addSubview:_lunarCalendarLabel];
        
        //        self.layer.cornerRadius = width/2.0;
        //        self.layer.masksToBounds = YES;
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setSelectedBg];
}


-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setDayBg];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setDayBg];
    NSString* isMensesDayStr = @"NO";
    if (self.isMensesDay) {
        isMensesDayStr = @"YES";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DID_SELETED_DATEVIEW" object:nil userInfo:@{@"dateModel": self.dateModel, @"view": self}];
}


-(void)fillDate:(DateModel *)dateModel
{
    _dateModel = dateModel;
    self.solarCalendarLabel.text = [NSString stringWithFormat:@"%ld",(long)dateModel.day];
    self.lunarCalendarLabel.text = dateModel.lunarDay;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.solarCalendarLabel.textAlignment = NSTextAlignmentCenter;
    
    self.lunarCalendarLabel.font = [UIFont systemFontOfSize:9.0];
    self.lunarCalendarLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)setDayBg{
    if (self.isMensesDay) {
        _backgroundView.backgroundColor = [UIColor redColor];
    }
    else{
        _backgroundView.backgroundColor = [UIColor clearColor];
    }
}

-(void)setSelectedBg{
    if (self.isMensesDay) {
        
    }
    else{
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0.923 alpha:1.000];
    }
}

@end
