//
//  UIColor+KCColor.h
//  RCloudMessage
//
//  Created by Liv on 15/4/3.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KCColor)


//十六进制颜色
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

//UIColor 转UIImage
+ (UIImage*) imageWithColor: (UIColor*) color;

@end
