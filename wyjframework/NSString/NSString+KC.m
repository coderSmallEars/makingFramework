//
//  NSString+KC.m
//  新浪微博
//
//  Created by apple on 13-10-27.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSString+KC.h"

@implementation NSString (KC)

-(NSString *)fileAppend:(NSString *)append
{
    // 1.1.获得文件拓展名
    NSString *ext = [self pathExtension];
    
    // 1.2.删除最后面的扩展名
    NSString *imgName = [self stringByDeletingPathExtension];
    
    // 1.3.拼接-568h@2x
    imgName = [imgName stringByAppendingString:append];
    
    // 1.4.拼接扩展名
    return [imgName stringByAppendingPathExtension:ext];
}


#pragma mark----------去除换行符 和  空白字符
+(NSString *)replaceSpaceAndNewlineOfString:(NSString *)sourceStr
{
    NSString *realSre = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *realSre1 = [realSre stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSString *realSre2 = [realSre1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *realSre3 = [realSre2 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *realSre4 = [realSre3 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    NSString *realSre5 = [realSre4 stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    
    
    NSArray *array = [realSre5 componentsSeparatedByString:@","];
    
    
    
    return [array objectAtIndex:0];
    
}


#pragma mark-------double小数点位数自动增加
+(NSString * )adaptiveDecimalPoint:(NSArray *)source  retainDigits:(int)retainDigits
{
    
    int decimalNum = retainDigits; //保留的小数位数
    
    NSNumberFormatter *nFormat = [[NSNumberFormatter alloc] init];
    
    [nFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    
    [nFormat setMaximumFractionDigits:decimalNum];
    
    return [NSString stringWithFormat:@"%@",[nFormat stringFromNumber:(NSNumber *)source[0] ]];
    
}





@end
