//
//  PMD5.m
//  fruit
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 王永军. All rights reserved.
//

#import "YJMD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation YJMD5 : NSObject



#pragma mark----------MD5加密
+(NSString *)md5:(NSString *)tokenStr
{
    const char *cStr = [tokenStr UTF8String];
    
    unsigned char result[16];
    
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    
    CC_MD5( cStr,[num intValue], result );
    
    
    return [[NSString stringWithFormat:
             
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             
             result[0], result[1], result[2], result[3],
             
             result[4], result[5], result[6], result[7],
             
             result[8], result[9], result[10], result[11],
             
             result[12], result[13], result[14], result[15]
             
             ] lowercaseString];
    
}
@end
