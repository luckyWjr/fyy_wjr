//
//  MyTools.h
//  FYY_WJR
//
//  Created by wjr on 16/4/29.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+Hex.h"

@interface MyTools : NSObject

#define DEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define DEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width
#define NavHeight 44
#define StatusBarHeight 20
#define DatePickerHeight 216
#define LineHegiht 1

#define TEXTFIELD_WIDTH 190
#define HINTLABEL_WIDTH 60
#define VIEW_DEFAULT_HEIGHT 34
#define VIEWBOX_DEFAULT_HEIGHT 50
#define DEFAULT_RADIUS 8

#define photoCountEachRow 4

#define DREAM_ITEMS @"DREAM_ITEMS"

#define DREAM_FILR_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"dream.data"]
#define DATE_FILR_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"date.data"]

#define DREAM_IMG_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

#define ALERTVIEW_TAG_HIDEALERT 1

// RGBA颜色
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGBColor(r, g, b) RGBAColor(r, g, b, 1.0)

#define RGBHexColor(rgb) [UIColor colorWithHexString:rgb]
// Cell上文字颜色
#define MyCellTextColor RGBHexColor(@"#5e5e5e")
// 背景灰色
#define MyGrayColor RGBHexColor(@"#d9d9d9")
//lineyans
#define MyLineColor RGBHexColor(@"e3e1e4")
// view背景颜色
#define ColorGray RGBColor(244, 243, 241)
//字体系统蓝色
#define DefaultTextColor RGBColor(0, 122, 255)

// iOS7以上
#define IOS7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)


+(NSDate*)convertDateFromString:(NSString*)uiDate;
+(NSDate*)convertDateFromString:(NSString*)uiDate format:(NSString*)format;
+(NSString *)convertStringFromDate:(NSDate *)date;
+(NSString *)convertStringFromDate:(NSDate *)date format:(NSString*)format;

+(id)getLocal:(NSString *)key;
+(void)saveLocal:(NSString*)key value:(id)obj;
+(void)removeLocal:(NSString *)key;

+ (UIImage *)scaleImage:(UIImage *)image toScale:(CGFloat)scaleSize;

+(void)showOneBtnAlertView:(NSString*)msg;

@end
