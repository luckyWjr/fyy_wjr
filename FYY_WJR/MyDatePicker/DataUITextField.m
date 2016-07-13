//
//  DataUITextField.m
//  FYY_WJR
//
//  Created by wjr on 16/5/3.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "DataUITextField.h"

@implementation DataUITextField

- (void)drawRect:(CGRect)rect {
    self.delegate = self;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if ([self.dateTextViewDelegate respondsToSelector:@selector(showDatePickerView)]) {
        [self.dateTextViewDelegate showDatePickerView];
    }
    return NO;
}

#pragma mark - 自定义选择日期控件委托
- (void)setDateValue:(NSString*)date{
    self.text = date;
}

@end
