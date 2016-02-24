//
//  BKHelper.m
//  BKoo
//
//  Created by mac on 15/10/14.
//  Copyright © 2015年 王永军. All rights reserved.
//

#import "YJHelper.h"
#import "YJMD5.h"

@implementation YJHelper
+ (UIButton *)createButton_WithTitle:(NSString *)title
                               frame:(CGRect)frame
                              target:(id)target
                            selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    button.layer.cornerRadius = 3.f;
    button.layer.masksToBounds = YES;
    
    button.backgroundColor = [UIColor colorWithRed:0.3 green:0.8f blue:1.f alpha:1.f];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+ (UIButton *)creatButton_WithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)name title:(NSString *)title{
    UIButton *button = nil;
    if (name) {
        //创建图片按钮
        //创建背景图片 按钮
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        if (title) {//图片标题按钮
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        
    }else if (title) {
        //创建标题按钮
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    button.frame = frame;
    button.tag = tag;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+ (UILabel *)createLabel_WithTitle:(NSString *)title frame:(CGRect)frame {
    return [self createLabel_WithTitle:title frame:frame fontSize:14.f];
}

+ (UILabel *)createLabel_WithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color {
    return [self createLabel_WithTitle:title frame:frame textColor:color fontSize:14.f];
}

+ (UILabel *)createLabel_WithTitle:(NSString *)title frame:(CGRect)frame fontSize:(CGFloat)size {
    return [self createLabel_WithTitle:title frame:frame textColor:[UIColor blackColor] fontSize:size];
}

+(UILabel *)frame:(CGRect)frame fontSize:( CGFloat )fontSize textColor:(UIColor *)textColor text:(NSString *)text textAgt:(NSTextAlignment )textAgt1{
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    label.textAlignment = textAgt1;
    return label;
}
+ (UILabel *)createLabel_WithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color fontSize:(CGFloat)size {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:size];
    //return [label autorelease];
    return label;
}

+ (UIView *)createView_WithBackgroundColor:(UIColor *)color frame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    //return [view autorelease];
    return view;
}

+ (UITextField *)createTextField_WithText:(NSString *)text frame:(CGRect)frame placeholder:(NSString *)placeholder textColor:(UIColor *)color borderStyle:(UITextBorderStyle)borderStyle {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.borderStyle = borderStyle;
    textField.text = text;
    textField.textColor = color;
    //return [textField autorelease];
    return textField;
}
+ (NSString *)dateStringFromNumberTimer:(NSString *)timerStr {
    //转化为Double
    double t = [timerStr doubleValue]/1000;
    //计算出距离1970的NSDate
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t];
    //转化为 时间格式化字符串
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //转化为 时间字符串
    return [df stringFromDate:date];
}
+(NSTimeInterval)timeIntervalFormWithDate:(NSDate*)date{
    NSTimeInterval time=0;
    if (!date) {
        NSDate *today = [NSDate date];
        time=[today timeIntervalSince1970];
    }else{
        time=[date timeIntervalSince1970];
    }
    return time;
}

//动态 计算行高
//根据字符串的实际内容的多少 在固定的宽度和字体的大小，动态的计算出实际的高度
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    
    if ([self getCurrentIOS] >= 7.0) {
        //iOS7之后
        /*
         第一个参数: 预设空间 宽度固定  高度预设 一个最大值
         第二个参数: 行间距 如果超出范围是否截断
         第三个参数: 属性字典 可以设置字体大小
         */
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
        
        CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        //返回计算出的行高
        return rect.size.height;
        
    }else {
        //iOS7之前
        /*
         1.第一个参数  设置的字体固定大小
         2.预设 宽度和高度 宽度是固定的 高度一般写成最大值
         3.换行模式 字符换行
         */
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(textWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        return textSize.height;//返回 计算出得行高
    }
}

//获取iOS版本号
+ (double)getCurrentIOS {
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}
+ (CGSize)getScreenSize {
    return [[UIScreen mainScreen] bounds].size;
}
//获得当前系统时间到指定时间的时间差字符串,传入目标时间字符串和格式
+(NSString*)stringNowToDate:(NSString*)toDate formater:(NSString*)formatStr
{
    
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    if (formatStr) {
        [formater setDateFormat:formatStr];
    }
    else{
        [formater setDateFormat:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
    }
    NSDate *date=[formater dateFromString:toDate];
    
    return [self stringNowToDate:date];
    
}


//获得到指定时间的时间差字符串,格式在此方法内返回前自己根据需要格式化
+(NSString*)stringNowToDate:(NSDate*)toDate
{
    //创建日期 NSCalendar对象
    NSCalendar *cal = [NSCalendar currentCalendar];
    //得到当前时间
    NSDate *today = [NSDate date];
    
    //用来得到具体的时差,位运算
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
    
    if (toDate && today) {//不为nil进行转化
        NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:toDate options:0 ];
        
        //NSString *dateStr=[NSString stringWithFormat:@"%d年%d月%d日%d时%d分%d秒",[d year],[d month], [d day], [d hour], [d minute], [d second]];
        NSString *dateStr=[NSString stringWithFormat:@"ld:ld:ld",[d hour], [d minute], [d second]];
        return dateStr;
    }
    return @"";
}

//获取 一个文件 在沙盒Library/Caches/ 目录下的路径
+ (NSString *)getFullPathWithFile:(NSString *)urlName {
    
    //先获取 沙盒中的Library/Caches/路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *myCacheDirectory = [docPath stringByAppendingPathComponent:@"MyCaches"];
    //检测MyCaches 文件夹是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:myCacheDirectory]) {
        //不存在 那么创建
        [[NSFileManager defaultManager] createDirectoryAtPath:myCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //用md5进行 加密 转化为 一串十六进制数字 (md5加密可以把一个字符串转化为一串唯一的用十六进制表示的串)
    NSString * newName = [YJMD5 md5:urlName];
    
    //拼接路径
    return [myCacheDirectory stringByAppendingPathComponent:newName];
}
//检测 缓存文件 是否超时
+ (BOOL)isTimeOutWithFile:(NSString *)filePath timeOut:(double)timeOut {
    //获取文件的属性
    NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    //获取文件的上次的修改时间
    NSDate *lastModfyDate = fileDict.fileModificationDate;
    //算出时间差 获取当前系统时间 和 lastModfyDate时间差
    NSTimeInterval sub = [[NSDate date] timeIntervalSinceDate:lastModfyDate];
    if (sub < 0) {
        sub = -sub;
    }
    //比较是否超时
    if (sub > timeOut) {
        //如果时间差 大于 设置的超时时间 那么就表示超时
        return YES;
    }
    return NO;
}
//将汉字转换成UTF-8码
+(NSString*)stringFromUTFStringWithText:(NSString*)text{
    
    return [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
//将UTF-8码转换成oc字符串
+(NSString*)utfStringFromObjectStringWithText:(NSString*)text{
    
    return [text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}



//正则判断手机号码格式
+ (BOOL)validatePhone:(NSString *)phone
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phone] == YES)
        || ([regextestcm evaluateWithObject:phone] == YES)
        || ([regextestct evaluateWithObject:phone] == YES)
        || ([regextestcu evaluateWithObject:phone] == YES))
    {
        if([regextestcm evaluateWithObject:phone] == YES) {
          //  NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:phone] == YES) {
          //  NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:phone] == YES) {
          //  NSLog(@"China Unicom");
        } else {
          //  NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}




//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

#pragma mark-------- 支付宝输入金额
#define myDotNumbers     @"0123456789.\n"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //输入字符限制
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (filtered.length == 0) {
        //支持删除键
        return [string isEqualToString:@""];
    }
    if (textField.text.length == 0) {
        return ![string isEqualToString:@"."];
    }
    //第一位为0，只能输入.
    else if (textField.text.length == 1){
        if ([textField.text isEqualToString:@"0"]) {
            return [string isEqualToString:@"."];
        }
    }
    else{//只能输入一个.
        if ([textField.text rangeOfString:@"."].length) {
            if ([string isEqualToString:@"."]) {
                return NO;
            }
            //两位小数
            NSArray *ary =  [textField.text componentsSeparatedByString:@"."];
            if (ary.count == 2) {
                if ([ary[1] length] == 2) {
                    return NO;
                }
            }
        }
    }
    
    return YES;
}




+(UIBarButtonItem *)backBarButonItem:(id)target
                            selector:(SEL)selector image:(NSString *)imageStr title:(NSString *)title
{
    
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    
    if (imageStr.length!=0) {
        
        button.frame = CGRectMake(0, 0, 18, 25);
        
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    }
    if (title.length!=0) {
        button.frame = CGRectMake(0, 0, 40, 25);

        button.titleLabel.font = [UIFont systemFontOfSize:19];
    
    [button setTitle:title forState:UIControlStateNormal];
  }
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    button.tintColor = [UIColor whiteColor];

    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    [bar setTintColor:[UIColor whiteColor]];
    
      return bar;

    
}


#pragma mark - 身份证识别
+(BOOL)checkIdentityCardNo:(NSString*)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

#pragma mark 封装异步加载请求
+(void)dispathLoad:(void (^)())block mainQueue:(void (^)())mainBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        block();
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            mainBlock();
        });
        
    });
    
}


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

+(MBProgressHUD *)showJuHua:(SEL)selector withObject:(id)object view:(UIView *)view target:(id)target text:(NSString *)text
{
    
    MBProgressHUD *  hub = [[MBProgressHUD alloc] initWithView:view];
    
    [view addSubview:hub];
    
    hub.delegate = target;
    
    
    
    if (text.length == 0) {
        
        hub.labelText = @"Loading";
    }else
    {
        
        hub.labelText = text;
        
    }
    
    if (object!=nil) {
        
        __unsafe_unretained typeof(self) weakSelf = target;
        
        [hub showAnimated:YES whileExecutingBlock:^{
            
            SuppressPerformSelectorLeakWarning(
                                               
                                               [weakSelf performSelector:selector withObject:object];
                                               );
            
        } onQueue:dispatch_get_main_queue()];
        
        
        return hub;
    }
    
    
    
    
    __unsafe_unretained typeof(self) weakSelf = target;
    
    [hub showAnimated:YES whileExecutingBlock:^{
        
        // SEL selector = NSSelectorFromString(@"processRegion:ofView:");
        
        IMP imp = [weakSelf methodForSelector:selector];
        
        void (*func)(id, SEL) = (void *)imp;
        
        func(weakSelf, selector);
        
        
        
        //        IMP imp = [weakSelf methodForSelector:selector];
        //
        //        id (*func)(id, SEL, id ) = (void *)imp;
        //
        //        id result = func(weakSelf, selector, object);
        
    } onQueue:dispatch_get_main_queue()];
    
    return hub;
}




@end
