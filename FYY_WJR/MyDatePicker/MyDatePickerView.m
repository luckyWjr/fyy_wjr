//
//  MyDatePickerView.m
//  FYY_WJR
//
//  Created by wjr on 16/5/25.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MyDatePickerView.h"
#import "MyTools.h"

@interface MyDatePickerView ()

@end

@implementation MyDatePickerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addDatePicker];
        [self addOperateToolbar];
    }
    return self;
}

-(void)addDatePicker{
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DatePickerHeight)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate* minDate = [MyTools convertDateFromString:@"2016-01-07"];
    self.datePicker.minimumDate = minDate;
    self.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    [self.datePicker addTarget:self action:@selector(dataValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.datePicker];
}

-(void)addOperateToolbar{
    UIView* hline = [[UIView alloc] initWithFrame:CGRectMake(0, DatePickerHeight, DEVICE_WIDTH, LineHegiht)];
    hline.backgroundColor = RGBHexColor(@"e3e1e4");
    
    UIButton* cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(0, DatePickerHeight + LineHegiht, (DEVICE_WIDTH - LineHegiht) / 2, NavHeight);
    cancelBtn.tag = 0;
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* vline = [[UIView alloc] initWithFrame:CGRectMake((DEVICE_WIDTH - LineHegiht) / 2, DatePickerHeight + LineHegiht, LineHegiht, NavHeight)];
    vline.backgroundColor = RGBHexColor(@"e3e1e4");
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame = CGRectMake((DEVICE_WIDTH + LineHegiht) / 2, DatePickerHeight + LineHegiht, DEVICE_WIDTH / 2, NavHeight);
    confirmBtn.tag = 1;
    confirmBtn.backgroundColor = [UIColor whiteColor];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:hline];
    [self addSubview:cancelBtn];
    [self addSubview:vline];
    [self addSubview:confirmBtn];
}

- (void)btnClick:(UIButton *)sender{
    if(sender.tag == 0){
        if ([self.dateDelegate respondsToSelector:@selector(setDateValue:)]) {
            [self.dateDelegate setDateValue:@""];
        }
    }
    [self setHidden:YES];
    
    if ([self.viewDelegate respondsToSelector:@selector(hidePickerViewSuc)]) {
        [self.viewDelegate hidePickerViewSuc];
    }
}

- (void) dataValueChanged:(UIDatePicker *)sender{
    if ([self.dateDelegate respondsToSelector:@selector(setDateValue:)]) {
        NSString* date = [MyTools convertStringFromDate:[self.datePicker date]];
        [self.dateDelegate setDateValue:date];
    }
}

@end
