//
//  BKHelper.h
//  BKoo
//
//  Created by mac on 15/10/14.
//  Copyright © 2015年 王永军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface YJHelper : NSObject
//创建Button的工厂，将特殊的元素传入，生产相对应的Button
+ (UIButton *)createButton_WithTitle:(NSString *)title frame:(CGRect)frame target:(id)target selector:(SEL)selector;
//创建button可以创建 标题按钮和 图片按钮
+ (UIButton *)creatButton_WithFrame:(CGRect)frame
                             target:(id)target
                                sel:(SEL)sel
                                tag:(NSInteger)tag
                              image:(NSString *)name
                              title:(NSString *)title;



//创建Label的工厂，将特殊的元素传入，生产相对应的Label
+ (UILabel *)createLabel_WithTitle:(NSString *)title frame:(CGRect)frame;
+ (UILabel *)createLabel_WithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color;
+ (UILabel *)createLabel_WithTitle:(NSString *)title frame:(CGRect)frame fontSize:(CGFloat)size;
+ (UILabel *)createLabel_WithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color fontSize:(CGFloat)size;
+(UILabel *)frame:(CGRect)frame fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor text:(NSString *)text textAgt:(NSTextAlignment)textAgt1;
//创建View的工厂，将特殊的元素传入，生产相应的View
+ (UIView *)createView_WithBackgroundColor:(UIColor *)color frame:(CGRect)frame;

//创建textField的工厂，将特殊的元素传入，生产响应的textField
+ (UITextField *)createTextField_WithText:(NSString *)text frame:(CGRect)frame placeholder:(NSString *)placeholder textColor:(UIColor *)color borderStyle:(UITextBorderStyle)borderStyle;

//把一个秒字符串 转化为真正的本地时间
//@"1419055200" -> 转化 日期字符串
+ (NSString *)dateStringFromNumberTimer:(NSString *)timerStr;



//将系统时间或者是某一个时间转换成秒字符串
// 转化 日期字符串 ->@"1419055200"
+(NSTimeInterval)timeIntervalFormWithDate:(NSDate*)date;



//根据字符串内容的多少  在固定宽度 下计算出实际的行高
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size;

//获取 当前设备版本
+ (double)getCurrentIOS;



//获取当前设备屏幕的大小
+ (CGSize)getScreenSize;

//获得当前系统时间到指定时间的时间差字符串,传入目标时间字符串和格式
+(NSString*)stringNowToDate:(NSString*)toDate formater:(NSString*)formatStr;

//获取 一个文件 在沙盒沙盒Library/Caches/ 目录下的路径
+ (NSString *)getFullPathWithFile:(NSString *)urlName;


//检测 缓存文件 是否超时
+ (BOOL)isTimeOutWithFile:(NSString *)filePath timeOut:(double)timeOut;



//将汉字转换成UTF-8码
+(NSString*)stringFromUTFStringWithText:(NSString*)text;


//将UTF-8码转换成oc字符串
+(NSString*)utfStringFromObjectStringWithText:(NSString*)text;

//正则判断手机号码格式
+ (BOOL)validatePhone:(NSString *)phone;

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC;

#pragma mark-------- 支付宝输入金额
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

//快速创建barButtonItem
+(UIBarButtonItem *)backBarButonItem:(id)target
                            selector:(SEL)selector image:(NSString *)imageStr title:(NSString *)title;


#pragma mark - 身份证识别
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;

#pragma mark 封装异步加载请求
+(void)dispathLoad:(void (^)())block mainQueue:(void (^)())mainBlock;

#pragma mark-------菊花保护
+(MBProgressHUD *)showJuHua:(SEL)selector withObject:(id)object view:(UIView *)view target:(id)target text:(NSString *)text;

@end
