//
//  UIPlaceHolderTextView.m
//  FYY_WJR
//
//  Created by wjr on 16/6/30.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "UIPlaceHolderTextView.h"
#import "MyTools.h"

@interface UIPlaceHolderTextView ()

@property(nonatomic, retain) UILabel *placeHolderLabel;

@end

@implementation UIPlaceHolderTextView

- (void)drawRect:(CGRect)rect {
    [self placeHolderInit];
    self.delegate = self;
}

- (void)placeHolderInit{
    self.placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, DEVICE_WIDTH, 50)];
    self.placeHolderLabel.text = self.placeholder;
    self.placeHolderLabel.font = self.font;
    self.placeHolderLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.placeHolderLabel];
    
    [self.placeHolderLabel sizeToFit];
    [self sendSubviewToBack:self.placeHolderLabel];
}

- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        self.placeHolderLabel.hidden = NO;
    }
    else{
        self.placeHolderLabel.hidden = YES;
    }
}

- (void)_firstBaselineOffsetFromTop {
    
}

- (void)_baselineOffsetFromBottom {
    
}

//隐藏键盘
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text {
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}
@end
