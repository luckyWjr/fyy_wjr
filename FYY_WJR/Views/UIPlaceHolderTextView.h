//
//  UIPlaceHolderTextView.h
//  FYY_WJR
//
//  Created by wjr on 16/6/30.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView<UITextViewDelegate>

@property(nonatomic, retain) NSString *placeholder;
//@property(nonatomic, retain) UIColor *placeholderColor;

@end
