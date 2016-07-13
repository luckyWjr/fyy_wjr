//
//  MyDatePickerView.h
//  FYY_WJR
//
//  Created by wjr on 16/5/25.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyDatePickerViewValueDelegate <NSObject>

@optional

- (void)setDateValue:(NSString*)date;

@end

@protocol MyDatePickerViewDelegate <NSObject>

@optional

- (void)hidePickerViewSuc;

@end

@interface MyDatePickerView : UIView

@property(nonatomic, strong)UIDatePicker *datePicker;
@property (nonatomic, weak) id<MyDatePickerViewValueDelegate> dateDelegate;
@property (nonatomic, weak) id<MyDatePickerViewDelegate> viewDelegate;

@end
