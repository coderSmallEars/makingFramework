//
//  NSString+KC.h
//  新浪微博
//
//  Created by apple on 13-10-27.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KC)

#pragma mark--------实现方法

//    // 1.1.获得文件拓展名
//    NSString *ext = [self pathExtension];
//    
//    // 1.2.删除最后面的扩展名
//    NSString *imgName = [self stringByDeletingPathExtension];
//    
//    // 1.3.拼接-568h@2x
//    imgName = [imgName stringByAppendingString:append];
//    
//    // 1.4.拼接扩展名
//    return [imgName stringByAppendingPathExtension:ext];
//


-(NSString *)fileAppend:(NSString *)append;


#pragma mark----------去除换行符 和  空白字符
+(NSString *)replaceSpaceAndNewlineOfString:(NSString *)str;

#pragma mark-------double小数点位数自动增加 用于金额显示
+(NSString * )adaptiveDecimalPoint:(NSArray *)source retainDigits:(int)retainDigits;


@end
