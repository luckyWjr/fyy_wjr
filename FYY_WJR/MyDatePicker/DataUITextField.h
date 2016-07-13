//
//  DataUITextField.h
//  FYY_WJR
//
//  Created by wjr on 16/5/3.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDatePickerView.h"

@protocol DataUITextFieldDelegate <NSObject>

@optional

- (void)showDatePickerView;

@end

@interface DataUITextField : UITextField <UITextFieldDelegate, MyDatePickerViewValueDelegate>

@property (nonatomic, weak) id<DataUITextFieldDelegate> dateTextViewDelegate;

@end
