//
//  MyTools.m
//  FYY_WJR
//
//  Created by wjr on 16/4/29.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "MyTools.h"

@implementation MyTools

#pragma mark - 日期和字符串转换
+(NSDate*)convertDateFromString:(NSString*)uiDate{
    return [self convertDateFromString:uiDate format:@"yyyy-MM-dd"];
}
+(NSDate*)convertDateFromString:(NSString*)uiDate format:(NSString*)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    NSDate *date=[formatter dateFromString:uiDate];
    return date;
}


+(NSString *)convertStringFromDate:(NSDate *)date{
    return [self convertStringFromDate:date format:@"yyyy-MM-dd"];
}
+(NSString *)convertStringFromDate:(NSDate *)date format:(NSString*)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

#pragma mark - 数据存储
+(id)getLocal:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+(void)saveLocal:(NSString*)key value:(id)obj{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    [defaults synchronize];
}

+(void)removeLocal:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [defaults synchronize];
}

#pragma mark - 图片处理
+ (UIImage *)scaleImage:(UIImage *)image toScale:(CGFloat)scaleSize{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


#pragma mark - 弹出框相关
+(void)showOneBtnAlertView:(NSString*)msg{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}
@end
